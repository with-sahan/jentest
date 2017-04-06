package com.mdl.mdlrestapi.psm.dao.impl;

import org.apache.log4j.Logger;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.google.gson.Gson;

import com.mdl.mdlrestapi.psm.dao.EMDashBoardDao;
import com.mdl.mdlrestapi.util.SimpleRequest;
import com.mdl.mdlrestapi.util.database.DatabaseConnectionManager;
import com.mdl.mdlrestapi.util.database.subscription.SubscriptionQuerryHandler;
import com.mdl.mdlrestapi.util.models.*;
import com.mdl.mdlrestapi.psm.dao.CommonDao;
import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.util.database.security.SecurityQuerryHandler;

/**
 * Created with IntelliJ IDEA.
 * User: AnushaP
 * Date: 3/3/17
 * Time: 2:42 PM
 * To change this template use File | Settings | File Templates.
 */
public class EMDashBoardDaoImpl implements EMDashBoardDao {

    private static final Logger logger = Logger.getLogger(EMDashBoardDaoImpl.class);
    private CommonDao commonDao = new CommonDaoImpl();

    @Override
    public ArrayList<GraphBallotStatsDto> getBallotGraphStats(String token, int hierarchyId) throws MDLDBException {
        int orgId = SubscriptionQuerryHandler.getOrganizationId(token);
        ArrayList<GraphBallotStatsDto> statsDetails = new ArrayList<GraphBallotStatsDto>();
        int userId = SecurityQuerryHandler.getUserId(token, orgId);
        String stationList = commonDao.getPollingStationList(hierarchyId, orgId, userId).replaceAll(",$", "");
        String query = "select el.election_name as electionname,HOUR(est.updatedon) as issuehour, "
                    + "sum(ballotpaper) as ballotpaperissued,"
                    + "'success' as response from psm.election_stats  est "
                    + "inner join psm.election el on el.id=est.electionid "
                    + "where date(el.election_date_start)=date(current_date) and "
                    + "est.organization_id=? and el.organization_id=? "
                    + "and est.polling_station_id in (" + stationList + ") "
                    + "group by el.id, el.election_name, HOUR(est.updatedon); ";

            try( Connection conn = DatabaseConnectionManager.getConnection();
            PreparedStatement preparedStatement = conn.prepareStatement(query)){
            preparedStatement.setInt(1, orgId);
            preparedStatement.setInt(2, orgId);
            try ( ResultSet rs = preparedStatement.executeQuery()){
                while (rs.next()) {
                    GraphBallotStatsDto csd = new GraphBallotStatsDto();
                    csd.electionname = rs.getString("electionname");
                    csd.issuehour = rs.getString("issuehour");
                    csd.ballotpaperissued = rs.getString("ballotpaperissued");
                    csd.response = rs.getString("response");
                    statsDetails.add(csd);
                }
            }
        } catch (SQLException | MDLDBException e) {
                logger.error("Error : "+ e.getMessage());
                throw new MDLDBException("DB Exception " + e.getMessage());
        }
        return statsDetails;
    }

    /**
     * Get Election list
     *
     * @param hierarchyId
     * @param token
     * @return
     * @throws com.mdl.mdlrestapi.psm.exception.MDLDBException
     *
     */
    @Override
    public ArrayList<ElectionDto> getElectionList(int hierarchyId, String token) throws MDLDBException {
        // gets the election list on selected polling stastions that are running
        // today
        ArrayList<ElectionDto> elList = new ArrayList<>();
        if (hierarchyId > 0 && token != null && token.length() > 0) {
            int orgid = SubscriptionQuerryHandler.getOrganizationId(token);
            int userId = SecurityQuerryHandler.getUserId(token, orgid);
            String stationList = commonDao.getPollingStationList(hierarchyId, orgid, userId).replaceAll(",$", "");
            if (stationList != null && stationList.length() > 0 && orgid > 0) {
                String query1 = "select distinct(el.id),el.election_name from psm.polling_station_election pse inner "
                        + "join psm.election el on pse.election_id=el.id where el.organization_id= ? "
                        + " and pse.organization_id = ?  and " + "pse.polling_station_id in (" + stationList
                        + ") and " + "date(el.election_date_start)=date(current_date);";
            try ( Connection conn = DatabaseConnectionManager.getConnection();
                    PreparedStatement preparedStatement = conn.prepareStatement(query1)){
                    preparedStatement.setInt(1, orgid);
                    preparedStatement.setInt(2, orgid);
                    try ( ResultSet rs1 = preparedStatement.executeQuery()){
                        while (rs1.next()) {
                            ElectionDto dto = new ElectionDto();
                            dto.electionName = rs1.getString("election_name");
                            dto.id = rs1.getInt("id");
                            elList.add(dto);
                        }
                    }
            }catch (SQLException | MDLDBException e) {
                logger.error("Error : "+ e.getMessage());
                throw new MDLDBException("DB Exception " + e.getMessage());
            }
        }
    }
        return elList;
    }

    /**
     * get sum of all stats
     *
     * @param token
     * @param hierarchyId
     * @param electionId
     * @return
     * @throws Exception
     */
    @Override
    public List<EmDashboardGridData> getAllSumStats(String token, int hierarchyId, int electionId) throws MDLDBException {
        ArrayList<EmDashboardGridData> elList = new ArrayList<>();
        EmDashboardGridData dto = new EmDashboardGridData();
        int totalturnout = 0;
        int orgid = SubscriptionQuerryHandler.getOrganizationId(token);
        int userId = SecurityQuerryHandler.getUserId(token, orgid);
        String stationList = commonDao.getPollingStationList(hierarchyId, orgid, userId).replaceAll(",$", "");
        if (stationList != null && stationList.length() > 0 && orgid > 0 && electionId > 0) {
            String query1 = "SELECT sum((pse.ballotend+1)-pse.ballotstart) as turnouts FROM psm.polling_station_election pse "
                    + "inner join psm.polling_station ps on ps.id=pse.polling_station_id "
                    + "where pse.polling_station_id in (" + stationList + ") and pse.election_id= ? "
                    + ";";
            try ( Connection conn = DatabaseConnectionManager.getConnection();
                PreparedStatement statement1 = conn.prepareStatement(query1)) {
                statement1.setInt(1, electionId);
                try ( ResultSet rs1 = statement1.executeQuery()){
                    while (rs1.next()) {
                        totalturnout = rs1.getInt("turnouts");
                    }
                }
                String query2 = "select sum(es.ballotpaper) as totballot,sum(es.postalpack) as totpostal,sum(es.postalpack_collected) as totcollected,"
                        + "el.election_name as electionname from psm.election_stats es "
                        + "inner join psm.election el on es.electionid=el.id " + "where el.id=? "
                        + " and es.organization_id=? and es.polling_station_id in (" + stationList
                        + ") and " + "date(el.election_date_start)=current_date() group by el.election_name;";

                try ( PreparedStatement statement2 = conn.prepareStatement(query2)){
                    statement2.setInt(1, electionId);
                    statement2.setInt(2, orgid);
                    try ( ResultSet rs2 = statement2.executeQuery()){
                        while (rs2.next()) {
                            int turnout = rs2.getInt("totballot");
                            dto.ballotPapers = turnout;
                            dto.packestobecollected = (rs2.getInt("totpostal") - rs2.getInt("totcollected"));
                            dto.electionname = rs2.getString("electionname");
                            double percentage = ((totalturnout == 0) ? 0
                                    : (double) 100.0 * (((double) turnout) / ((double) totalturnout)));
                            dto.voterturnout = percentage;
                        }
                    }
                    elList.add(dto);
                }
            } catch (SQLException | MDLDBException e) {
                logger.error("Error : "+ e.getMessage());
                throw new MDLDBException("DB Exception " + e.getMessage());
            }
        }
        return elList;
    }

    /**
     * Get stats
     *
     * @param hierarchyId
     * @param token
     * @param electionId
     * @return
     * @throws Exception
     */
    @Override
    public ArrayList<EmDashboardDto> getStats(int hierarchyId, String token, int electionId) throws MDLDBException {
        int orgid = 0;
        ArrayList<EmDashboardDto> resList = new ArrayList<EmDashboardDto>();
            // get the organization id
            orgid = SubscriptionQuerryHandler.getOrganizationId(token);
            int userId = SecurityQuerryHandler.getUserId(token, orgid);
            String stationList = commonDao.getPollingStationList(hierarchyId, orgid, userId).replaceAll(",$", "");
            if (stationList != null && stationList.length() > 0 && electionId > 0) {
                if(logger.isDebugEnabled()){
                logger.debug("Organization ID :" + orgid + " , Station List :" + stationList);
                }
                String blrQry = "select ps.id as stationid,ps.name as pollingstation,hv.value as parentHierarchyName,pse.isopen as stationopenstatus,pse.isclose as stationclosestatus,(sum(es.ballotpaper)) as ballotpapers,sum(es.postalpack) as postalreceived,"
                        + "sum(es.postalpack_collected) as postalcollected "
                        + "from psm.election_stats es inner join psm.polling_station ps on es.polling_station_id=ps.id "
                        + "inner join psm.hierarchy_value hv on ps.hierarchy_value_id=hv.id "
                        + "inner join psm.polling_station_election pse on pse.election_id=es.electionid and pse.polling_station_id=es.polling_station_id "
                        + "where es.electionid=? and pse.polling_station_id in (" + stationList + ") "
                        + "and es.organization_id=? and ps.organization_id=? group by ps.name;";

                try ( Connection conn = DatabaseConnectionManager.getConnection();
                PreparedStatement statement1 = conn.prepareStatement(blrQry)){
                statement1.setInt(1, electionId);
                statement1.setInt(2, orgid);
                statement1.setInt(3, orgid);
                try ( ResultSet rs1 = statement1.executeQuery()){
                    while (rs1.next()) {
                        EmDashboardDto dbd = new EmDashboardDto();
                        dbd.parentHierarchyName = rs1.getString("parentHierarchyName");
                        dbd.ballotPapersIssued = rs1.getInt("ballotpapers");
                        dbd.postalPackesCollected = rs1.getInt("postalcollected");
                        dbd.postalPackesRecevied = rs1.getInt("postalreceived");
                        dbd.stationName = rs1.getString("pollingstation");
                        dbd.status = rs1.getInt("stationopenstatus");
                        dbd.stationid = rs1.getInt("stationid");
                        dbd.openStatus = rs1.getInt("stationopenstatus");
                        dbd.closeStatus = rs1.getInt("stationclosestatus");
                        dbd.photoUrl = getPhotoUrl(rs1.getInt("stationid"), electionId, orgid);
                        resList.add(dbd);
                    }
                }
            }catch (SQLException | MDLDBException e) {
               logger.error("Error : "+ e.getMessage());
               throw new MDLDBException("DB Exception " + e.getMessage());
            }
        }
        return resList;
    }

    private ArrayList<String> getPhotoUrl(int stationId, int electionId, int orgId) throws MDLDBException {
        String query = "select image_url from psm.station_photo where organization_id=? and station_id=? and election_id=?";
        String photo = "";
        ArrayList<String> urlarray = new ArrayList<String>();
        try ( Connection conn = DatabaseConnectionManager.getConnection();
            PreparedStatement statement1 = conn.prepareStatement(query)){
            statement1.setInt(1, orgId);
            statement1.setInt(2, stationId);
            statement1.setInt(3, electionId);
            try ( ResultSet rs1 = statement1.executeQuery()){
                while (rs1.next()) {
                    photo = rs1.getString("image_url");
                    urlarray.add(photo);
                }
            }
        } catch (SQLException | MDLDBException e) {
            logger.error("Error : "+ e.getMessage());
            throw new MDLDBException("DB Exception " + e.getMessage());
        }
        return urlarray;
    }

    /**
     * Get Issue count graph stats
     *
     * @param request
     * @return
     * @throws Exception
     */
    @Override
    public String getIssueCountGraphStats(SimpleRequest request) throws MDLDBException {
        int orgid = 0;
        StringBuffer sb = new StringBuffer();
        EmIssueWithStationCount obj = new EmIssueWithStationCount();
        //get the organization id
        orgid = SubscriptionQuerryHandler.getOrganizationId(request.token);
        int userId = SecurityQuerryHandler.getUserId(request.token, orgid);
        String stationList = commonDao.getPollingStationList(request.hierarchyId, orgid, userId).replaceAll(",$", "");
        if (stationList != null && stationList.length() > 0 && orgid > 0) {
            String querry = "call psm.isopenisclosed(?)";
            try ( Connection conn = DatabaseConnectionManager.getConnection();
                PreparedStatement preparedStatement = conn.prepareStatement(querry)) {
                preparedStatement.setString(1, stationList);
                try (ResultSet rs1 = preparedStatement.executeQuery()) {
                    while (rs1.next()) {
                        obj.opencount = rs1.getInt("opened");
                        obj.closecount = rs1.getInt("closed");
                    }
                }
                String blrQry = "select count(isu.id) as openissues,'success' as response from psm.issue isu "
                        + "where isu.pollingstation_id in (" + stationList + ") and "
                        + "isu.status in (0,3,4) and  isu.organization_id=?;";
                try (PreparedStatement statement2 = conn.prepareStatement(blrQry)) {
                    statement2.setInt(1, orgid);
                    try ( ResultSet rs2 = statement2.executeQuery()){
                        while (rs2.next()) {
                            obj.response = rs2.getString("response");
                            obj.openissues = rs2.getInt("openissues");
                        }
                    }
                }
            } catch (SQLException | MDLDBException e) {
                logger.error("Error : "+ e.getMessage());
                throw new MDLDBException("DB Exception " + e.getMessage());
            }
            Gson gson = new Gson();
            sb.append("{\"result\": {\"entry\": " + gson.toJson(obj) + "}}");
        } else {
            logger.warn("stationList : " + stationList + " and orgid : " + orgid);
        }
        return sb.toString();
    }

    /**
     * Get process polling station details
     *
     * @param token
     * @param hierarchyId
     * @return
     */
    @Override
    public List<PollingStationElectionDto> getProcessPollingStationDetailsV2(String token, int hierarchyId) throws MDLDBException {
        List<PollingStationElectionDto> pollingStationElections = new ArrayList<PollingStationElectionDto>();
        int orgId = SubscriptionQuerryHandler.getOrganizationId(token);
        int userId = SecurityQuerryHandler.getUserId(token, orgId);
        String stationList = commonDao.getPollingStationList(hierarchyId, orgId, userId).replaceAll(",$", "");
        if (orgId > 0 && hierarchyId > 0 && stationList != null) {
            String query = "select ps.id as id, ps.name as stationname, hv.value as place, "
                        + "psm.isopen(ps.id) as openstatus "
                        + "from psm.polling_station ps "
                        + "inner join psm.hierarchy_value hv on ps.hierarchy_value_id=hv.id "
                        + "where ps.organization_id=? and ps.id in (" + stationList + ");";
            try (Connection conn = DatabaseConnectionManager.getConnection();
                PreparedStatement preparedStatement = conn.prepareStatement(query)){
                preparedStatement.setInt(1, orgId);
                try ( ResultSet rs = preparedStatement.executeQuery()){
                    while (rs.next()) {
                        PollingStationElectionDto pdt = new PollingStationElectionDto();
                        pdt.place = rs.getString("place");
                        pdt.pollingStation = rs.getString("stationname");
                        pdt.keyContactName = "";            //TODO Values hardcoded due to unimplemented functionality
                        pdt.contactDetails = "";
                        pdt.openStatus = rs.getString("openstatus");
                        pollingStationElections.add(pdt);
                    }
                }
            } catch (SQLException | MDLDBException e) {
                logger.error("Error : "+ e.getMessage());
                throw new MDLDBException("DB Exception " + e.getMessage());
            }
        }
        return pollingStationElections;
    }

    /**
     * GetPostal Graph Stats
     *
     * @param token
     * @param hierarchyId
     * @return
     * @throws Exception
     */
    @Override
    public ArrayList<GraphBallotStatsDto> getPostalGraphStats(String token, int hierarchyId) throws MDLDBException {
        int orgId = SubscriptionQuerryHandler.getOrganizationId(token);
        ArrayList<GraphBallotStatsDto> statsDetails = new ArrayList<GraphBallotStatsDto>();
        if (orgId > 0 && hierarchyId > 0) {
            int userId = SecurityQuerryHandler.getUserId(token, orgId);
            String stationList = commonDao.getPollingStationList(hierarchyId, orgId, userId).replaceAll(",$", "");
            String query = "select el.election_name as electionname,HOUR(est.updatedon) as issuehour,"
                        + " sum(postalpack_collected) as postalcollected,'success' as response "
                        + "from psm.election_stats  est "
                        + "inner join psm.election el on el.id=est.electionid "
                        + "where date(el.election_date_start)=date(current_date) "
                        + "and est.organization_id=? and el.organization_id=? "
                        + "and est.polling_station_id in (" + stationList + ") "
                        + "group by el.election_name, HOUR(est.updatedon);";
            try ( Connection conn = DatabaseConnectionManager.getConnection();
                PreparedStatement preparedStatement = conn.prepareStatement(query)){
                preparedStatement.setInt(1, orgId);
                preparedStatement.setInt(2, orgId);
                try ( ResultSet rs = preparedStatement.executeQuery()) {
                    while (rs.next()) {
                        GraphBallotStatsDto csd = new GraphBallotStatsDto();
                        csd.electionname = rs.getString("electionname");
                        csd.issuehour = rs.getString("issuehour");
                        csd.postalcollected = rs.getString("postalcollected");
                        csd.response = rs.getString("response");
                        statsDetails.add(csd);
                    }
                }
            } catch (SQLException | MDLDBException e) {
                logger.error("Error : "+ e.getMessage());
                throw new MDLDBException("DB Exception " + e.getMessage());
            }
        } else {
            logger.warn("orgid(" + orgId + ") or hierarchyid(" + hierarchyId + ")  is not defined");
        }
        return statsDetails;
    }

}
