package com.mdl.mdlrestapi.psm.dao.impl;

import com.mdl.mdlrestapi.psm.dao.NotificationDao;
import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.psm.utils.ConfigUtil;
import com.mdl.mdlrestapi.util.database.DatabaseConnectionManager;
import com.mdl.mdlrestapi.util.database.subscription.SubscriptionQuerryHandler;
import com.mdl.mdlrestapi.util.models.NotificationDto;
import com.mdl.mdlrestapi.util.models.NotificationEntryDto;
import com.mdl.mdlrestapi.util.models.NotificationResultDto;
import com.mdl.mdlrestapi.util.models.PollingStationDto;
import org.apache.log4j.Logger;

import java.io.*;
import java.sql.*;
import java.util.ArrayList;

/**
 * Created by lasantha on 3/13/2017.
 */
public class NotificationDaoImpl implements NotificationDao {
    private static final Logger logger = Logger.getLogger(NotificationDaoImpl.class);

    public ArrayList<NotificationDto> getFilteredResults(int hierarchyId, String token) throws MDLDBException {

        //NotificationResultDto nr = new NotificationResultDto();
        ArrayList<NotificationDto> nrList = new ArrayList<NotificationDto>();
        int orgid = SubscriptionQuerryHandler.getOrganizationId(token);
        if(logger.isDebugEnabled()){
        logger.debug("Organization Id :" + orgid);
        }
        String stations = getActivePollingStationListString(hierarchyId, token);
        String userList = getActiveUserListForStationList(stations, orgid);
        if (!stations.equals("")) {
            String sql = "select distinct(noti.id),noti.message,noti.attachtment_url, noti.createdon from psm.notification noti "
                    + "inner join psm.notification_status ns on noti.id=ns.notificationid "
                    + "where noti.organization_id=? and ns.organization_id=? and userid in ("+userList+") and date(noti.createdon)=date(current_date);";

            try (Connection conn = DatabaseConnectionManager.getConnection();
                 PreparedStatement preparedStatement1 = conn.prepareStatement(sql)) {
                preparedStatement1.setInt(1, orgid);
                preparedStatement1.setInt(2, orgid);
                //preparedStatement1.setString(3, userList);
                try (ResultSet rs1 = preparedStatement1.executeQuery()) {


                    //nr.result = new NotificationEntryDto();
                    //nr.result.entry = new ArrayList<NotificationDto>();
                    while (rs1.next()) {
                        //get the counts
                        int readCount = 0;
                        int unReadCount = 0;
                        NotificationDto dto = new NotificationDto();
                        String readCnt = "(select count(id) as reccount from psm.notification_status where notificationid=? and organization_id=? and status=1);";
                        try (PreparedStatement preparedStatement2 = conn.prepareStatement(readCnt)) {
                            preparedStatement2.setInt(1, rs1.getInt("id"));
                            preparedStatement2.setInt(2, orgid);
                            try (ResultSet rs2 = preparedStatement2.executeQuery()) {
                                while (rs2.next()) {
                                    readCount = rs2.getInt("reccount");
                                }
                            }

                            String unReadCnt = "(select count(id) as reccount from psm.notification_status where notificationid=? and organization_id=? and status=0);";
                            try (PreparedStatement preparedStatement3 = conn.prepareStatement(unReadCnt)) {
                                preparedStatement3.setInt(1, rs1.getInt("id"));
                                preparedStatement3.setInt(2, orgid);
                                try (ResultSet rs3 = preparedStatement3.executeQuery()) {
                                    while (rs3.next()) {
                                        unReadCount = rs3.getInt("reccount");
                                    }
                                }
                                dto.attachtment = rs1.getString("attachtment_url");
                                dto.id = String.valueOf(rs1.getInt("id"));
                                dto.message = rs1.getString("message");
                                dto.response = "success";

                                //StringBuffer sb = new StringBuffer();
                                //String timesent = String.valueOf(rs1.getTimestamp("createdon"));
                                //String[] splited = timesent.split(" ");
                                //sb.append(splited[0] + "T" + splited[1] + "00+00:00");
                                //dto.senton = sb.toString();

                                dto.senton = String.valueOf(rs1.getTimestamp("createdon"));
                                dto.status = readCount + "/" + (readCount + unReadCount);
                                //nr.result.entry.add(dto);
                                nrList.add(dto);
                                //sb.setLength(0);

                            }
                        }
                    }
                }
            } catch (SQLException | MDLDBException e) {
                logger.error("Error : "+ e.getMessage());
                throw new MDLDBException("DB Exception " + e.getMessage());
            }
        }
        return nrList;
    }

    public void saveToDbNotification(String uploadedFileLocation,String station_id,String hierarchyId,String description, String token) throws MDLDBException {
        int notificationid = 0;
        int orgid = SubscriptionQuerryHandler.getOrganizationId(token);
            if(!station_id.equals("-1")){
                //message will be sent only for a single polling station
                String singleStationInsert = "insert into psm.notification" +
                        "(organization_id,message,attachtment_url,createdon ) values(?,?,?,CURRENT_TIMESTAMP);";
                //System.out.println(singleStationInsert);
                try(Connection conn = DatabaseConnectionManager.getConnection();
                    PreparedStatement preparedStatement1 = conn.prepareStatement(singleStationInsert)){
                    preparedStatement1.setInt(1, orgid);
                    preparedStatement1.setString(2, description);
                    preparedStatement1.setString(3, uploadedFileLocation);
                    preparedStatement1.executeUpdate();

                    try(PreparedStatement statement2 = conn.prepareStatement("SELECT LAST_INSERT_ID() as id;");
                        ResultSet rs1 = statement2.executeQuery()) {
                        while (rs1.next()) {
                            notificationid = rs1.getInt("id");
                        }
                    }

                    //notification is created. Now send the message to all users as a private message
                    ArrayList<Integer> userIdList = getUserIdList(orgid, Integer.parseInt(station_id));
                    for (Integer usrId : userIdList) {
                        String statQry = "insert into psm.notification_status" +
                                "(organization_id,notificationid,userid,status,isprivate)" +
                                "values(?,?,?,0,1)";
                        try(PreparedStatement preparedStatement3 = conn.prepareStatement(statQry)) {
                            preparedStatement3.setInt(1, orgid);
                            preparedStatement3.setInt(2, notificationid);
                            preparedStatement3.setInt(3, usrId);
                            preparedStatement3.executeUpdate();
                        }
                    }
                }catch(SQLException | MDLDBException e){
                    logger.error("Error : "+ e.getMessage());
                    throw new MDLDBException("DB Exception " + e.getMessage());
                }

            }else {
                //message will be sent to all the stations in the hierarchy
                String stationList = getActivePollingStationListString(Integer.parseInt(hierarchyId), token);
                ArrayList<Integer> userList = getActiveUserIdArrayForStationList(stationList, orgid);
                String stsationQry = "insert into psm.notification" +
                        "(organization_id,message,attachtment_url,createdon )" +
                        "values(?,?,?,CURRENT_TIMESTAMP);";
                //System.out.println(stsationQry);
                try (Connection conn = DatabaseConnectionManager.getConnection();
                     PreparedStatement preparedStatement1 = conn.prepareStatement(stsationQry)) {
                    preparedStatement1.setInt(1, orgid);
                    preparedStatement1.setString(2, description);
                    preparedStatement1.setString(3, uploadedFileLocation);
                    preparedStatement1.executeUpdate();

                    try (PreparedStatement statement2 = conn.prepareStatement("SELECT LAST_INSERT_ID() as id;");
                         ResultSet rs1 = statement2.executeQuery()) {
                        while (rs1.next()) {
                            notificationid = rs1.getInt("id");
                        }
                    }

                    for (int usrId : userList) {
                        String statQry = "insert into psm.notification_status" +
                                "(organization_id,notificationid,userid,status,isprivate)" +
                                "values(?,?,?,0,0)";
                        try (PreparedStatement preparedStatement3 = conn.prepareStatement(statQry)) {
                            preparedStatement3.setInt(1, orgid);
                            preparedStatement3.setInt(2, notificationid);
                            preparedStatement3.setInt(3, usrId);
                            preparedStatement3.executeUpdate();
                        }
                    }
                } catch (SQLException | MDLDBException e) {
                    logger.error("Error : "+ e.getMessage());
                    throw new MDLDBException("DB Exception " + e.getMessage());
                }
            }
    }

    public ArrayList<Integer> getUserIdList(int orgId,int stationId) throws MDLDBException {
        ArrayList<Integer> userList=new ArrayList<Integer>();
        ResultSet rs1 = null;

            String sql="select distinct(eu.user_id) from psm.user_election eu inner join psm.election el "
                    + "on el.id=eu.election_id where date(el.election_date_start)=date(current_date) "
                    + "and eu.pollingstation_id =? and eu.organization_id=? and el.organization_id=?;";
            try(Connection conn = DatabaseConnectionManager.getConnection();
            PreparedStatement preparedStatement1 = conn.prepareStatement(sql)){
            preparedStatement1.setInt(1, stationId);
            preparedStatement1.setInt(2, orgId);
            preparedStatement1.setInt(3, orgId);
            rs1 = preparedStatement1.executeQuery();
            while(rs1.next()){
                userList.add(rs1.getInt("user_id"));
            }

        } catch (SQLException | MDLDBException e) {
            logger.error("Error : "+ e.getMessage());
            throw new MDLDBException("DB Exception " + e.getMessage());
        }
        return userList;
    }



    public String getAllPollingStationList(int hierarchyId,int orgId) throws MDLDBException {
        StringBuilder sb = new StringBuilder();
        if(logger.isDebugEnabled()){
        logger.debug("Got parameters for GetAllPollingStationList :" + hierarchyId + " " + orgId);
        }
        int selHrc = 0;
        //first get all the polling stations under this hierarchy
        String query0 = "SELECT id FROM psm.polling_station where hierarchy_value_id=? and organization_id=?;";
        //add all the polling station ids
        try (Connection conn = DatabaseConnectionManager.getConnection();
             PreparedStatement preparedStatement1 = conn.prepareStatement(query0)) {
            preparedStatement1.setInt(1, hierarchyId);
            preparedStatement1.setInt(2, orgId);
            try (ResultSet rs1 = preparedStatement1.executeQuery()) {
                while (rs1.next()) {
                    sb.append(rs1.getInt("id") + ",");
                }
            }

            //now check child hierarchies for this hierachy and recurse
            String query1 = "SELECT id FROM psm.hierarchy_value where parent_id=? and organization_id=?;";
            try (PreparedStatement statement2 = conn.prepareStatement(query1)) {
                statement2.setInt(1, hierarchyId);
                statement2.setInt(2, orgId);
                try (ResultSet rs2 = statement2.executeQuery()) {
                    while (rs2.next()) {
                        selHrc = rs2.getInt("id");
                        sb.append(getAllPollingStationList(selHrc, orgId));
                    }
                }
            }
        } catch (SQLException | MDLDBException e) {
            logger.error("Error : "+ e.getMessage());
            throw new MDLDBException("DB Exception " + e.getMessage());
        }
        return sb.toString();
    }

    public ArrayList<PollingStationDto> getActivePollingStationList(int hierarchyId, String token) throws MDLDBException {
        //gets the election list on selected polling stastions that are running today
        ArrayList<PollingStationDto> elList = new ArrayList<PollingStationDto>();
        if(logger.isDebugEnabled()){
        logger.debug("Got Parameters for GetActivePollingStationList :" + hierarchyId + " " + token);
        }
        int orgid = 0;
        orgid = SubscriptionQuerryHandler.getOrganizationId(token);
        String stationList = getAllPollingStationList(hierarchyId, orgid).replaceAll(",$", "");
        String query1 = "select distinct(pse.polling_station_id) as stationid,ps.name as stationname from psm.polling_station_election pse inner "
                + "join psm.election el on pse.election_id=el.id "
                + "inner join psm.polling_station ps on ps.id=pse.polling_station_id "
                + "where el.organization_id=? and pse.organization_id=?  and "
                + "pse.polling_station_id in ("+stationList+") and "
                + "date(el.election_date_start)=date(current_date);";
        try (Connection conn = DatabaseConnectionManager.getConnection();
             PreparedStatement statement = conn.prepareStatement(query1)) {
            statement.setInt(1, orgid);
            statement.setInt(2, orgid);
            //statement.setString(3, stationList);
            try (ResultSet rs = statement.executeQuery()) {

                while (rs.next()) {
                    PollingStationDto dto = new PollingStationDto();
                    dto.stationId = rs.getInt("stationid");
                    dto.stationName = rs.getString("stationname");
                    elList.add(dto);
                }
            }
        } catch (SQLException | MDLDBException e) {
            logger.error("Error : "+ e.getMessage());
            throw new MDLDBException("DB Exception " + e.getMessage());
        }
        return elList;
    }

    public String getActivePollingStationListString(int hierarchyId,String token) throws MDLDBException {
        String elList = "";
        StringBuilder sb = new StringBuilder();

        int orgid = 0;
        //get the organization id
        orgid = SubscriptionQuerryHandler.getOrganizationId(token);

        String stationList = getAllPollingStationList(hierarchyId, orgid).replaceAll(",$", "");
        String query1 = "select distinct(pse.polling_station_id) as stationid,ps.name as stationname from psm.polling_station_election pse inner "
                + "join psm.election el on pse.election_id=el.id "
                + "inner join psm.polling_station ps on ps.id=pse.polling_station_id "
                + "where el.organization_id=? and pse.organization_id=?  and "
                + "pse.polling_station_id in ("+stationList+") and "
                + "date(el.election_date_start)=date(current_date);";
        try (Connection conn = DatabaseConnectionManager.getConnection();
             PreparedStatement statement = conn.prepareStatement(query1)) {
            statement.setInt(1, orgid);
            statement.setInt(2, orgid);
            //statement.setString(3, stationList);
            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    sb.append(rs.getInt("stationid") + ",");
                }
            }
            elList = sb.toString().replaceAll(",$", "");

        } catch (SQLException | MDLDBException e) {
            logger.error("Error : "+ e.getMessage());
            throw new MDLDBException("DB Exception " + e.getMessage());
        }
        return elList;
    }

    public String getActiveUserListForStationList(String stationList,int orgId) throws MDLDBException {
        String ulList = "";
        StringBuilder sb = new StringBuilder();

        String sql = "select distinct(ue.user_id) from  psm.user_election ue inner "
                + "join psm.election el on el.id=ue.election_id where ue.pollingstation_id in ("+stationList+") and date(el.election_date_start)=date(current_date) "
                + "and el.organization_id=? and ue.organization_id=?;";
        try (Connection conn = DatabaseConnectionManager.getConnection();
             PreparedStatement statement = conn.prepareStatement(sql)) {
            //statement.setString(1, stationList);
            statement.setInt(1, orgId);
            statement.setInt(2, orgId);
            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    sb.append(rs.getInt("user_id") + ",");
                }
            }
            ulList = sb.toString().replaceAll(",$", "");
        } catch (SQLException | MDLDBException e) {
            logger.error("Error : "+ e.getMessage());
            throw new MDLDBException("DB Exception " + e.getMessage());
        }
        return ulList;
    }

    public ArrayList<Integer> getActiveUserIdArrayForStationList(String stationList,int orgId) throws MDLDBException {
        ArrayList<Integer> ulist = new ArrayList<>();

        String sql = "select distinct(ue.user_id) from  psm.user_election ue inner "
                + "join psm.election el on el.id=ue.election_id where ue.pollingstation_id in (" + stationList + ") and date(el.election_date_start)=date(current_date) "
                + "and el.organization_id= ? and ue.organization_id= ?;";
        try (Connection conn = DatabaseConnectionManager.getConnection();
             PreparedStatement statement = conn.prepareStatement(sql)) {
            //statement.setString(1, stationList);
            statement.setInt(1, orgId);
            statement.setInt(2, orgId);
            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    ulist.add(rs.getInt("user_id"));
                }
            }

        } catch (SQLException | MDLDBException e) {
            logger.error("Error : "+ e.getMessage());
            throw new MDLDBException("DB Exception " + e.getMessage());
        }
        return ulist;
    }

}
