package com.mdl.mdlrestapi.psm.dao.impl;

import com.mdl.mdlrestapi.psm.dao.CommonDao;
import com.mdl.mdlrestapi.psm.dao.GeoHierarchyDao;
import com.mdl.mdlrestapi.psm.dao.StatisticDao;
import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.util.database.DatabaseConnectionManager;
import com.mdl.mdlrestapi.util.database.psm.entities.HierarchyValue;
import com.mdl.mdlrestapi.util.database.security.SecurityQuerryHandler;
import com.mdl.mdlrestapi.util.database.subscription.SubscriptionQuerryHandler;
import com.mdl.mdlrestapi.util.models.CloseStatsDto;
import com.mdl.mdlrestapi.util.models.CloseStatsSummeryDto;
import org.apache.log4j.Logger;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by lasantha on 3/8/2017.
 */
public class StatisticDaoImpl implements StatisticDao{

    private static final Logger logger = Logger.getLogger(StatisticDaoImpl.class);
    private CommonDao commonDao = new CommonDaoImpl();

    public ArrayList<CloseStatsSummeryDto> getAllCloseStatsSummery(String token, int electionId, int hierarchyId) throws MDLDBException {
        GeoHierarchyDao geoHierarchy = new GeoHierarchyDaoImpl();
        int orgId = SubscriptionQuerryHandler.getOrganizationId(token);
        ArrayList<CloseStatsSummeryDto> closeStatsDetails = new ArrayList<CloseStatsSummeryDto>();
        if (orgId > 0 && electionId > 0 && hierarchyId > 0) {
            List<HierarchyValue> hierarchyValues = geoHierarchy.findHierarchyValueByOrganizationId(orgId);
            int userId = SecurityQuerryHandler.getUserId(token, orgId);
            String stationList = commonDao.getPollingStationList(hierarchyId, orgId, userId).replaceAll(",$", "");
            String query = "select sum(ecs.tot_ballots) as sum_tot_ballots, "
                    + "sum(ecs.tot_spolied_issued) as sum_tot_spoiled_replaced, "
                    + "sum(ecs.tot_unused) as sum_tot_unused, "
                    + "sum(ecs.tot_tend_ballots) as sum_tot_tend_ballots, "
                    + "sum(ecs.tot_tend_spoiled) as sum_tot_tend_spoiled, "
                    + "sum(ecs.tot_tend_unused) as sum_tot_tend_unused, "
                    + "sum(ecs.tot_ballots2) as sum_tot_ballots2, "
                    + "sum(ecs.tot_spolied_issued2) as sum_tot_spoiled_replaced2, "
                    + "sum(ecs.tot_unused2) as sum_tot_unused2, "
                    + "sum(ecs.tot_tend_ballots2) as sum_tot_tend_ballots2, "
                    + "sum(ecs.tot_tend_spoiled2) as sum_tot_tend_spoiled2, "
                    + "sum(ecs.tot_tend_unused2) as sum_tot_tend_unused2, "
                    + "ecs.election_id as electionid, "
                    + "'success' as response from "
                    + "psm.election_close_stats ecs "
                    + "where ecs.organization_id=? and "
                    + "ecs.election_id = ? and "
                    + "ecs.polling_station_id in (" + stationList + ") "
//								+ " and "
//						+ "UNIX_TIMESTAMP(ecs.updatedon) > UNIX_TIMESTAMP(CURDATE()) "
                    + "group by ecs.election_id; ";

            try (Connection conn = DatabaseConnectionManager.getConnection();
                 PreparedStatement preparedStatement = conn.prepareStatement(query)) {
                preparedStatement.setInt(1, orgId);
                preparedStatement.setInt(2, electionId);
                try (ResultSet rs = preparedStatement.executeQuery()) {
                    while (rs.next()) {
                        CloseStatsSummeryDto csd = new CloseStatsSummeryDto();
                        HierarchyValue placeHierarchyValue = new HierarchyValue();
                        csd.sum_tot_tend_unused = rs.getString("sum_tot_tend_unused");
                        csd.sum_tot_unused = rs.getString("sum_tot_unused");
                        csd.sum_tot_tend_spoiled = rs.getString("sum_tot_tend_spoiled");
                        csd.sum_tot_tend_ballots = rs.getString("sum_tot_tend_ballots");
                        csd.sum_tot_ballots = rs.getString("sum_tot_ballots");
                        csd.sum_tot_spoiled_replaced = rs.getString("sum_tot_spoiled_replaced");
                        csd.sum_tot_tend_unused2 = rs.getString("sum_tot_tend_unused2");
                        csd.sum_tot_unused2 = rs.getString("sum_tot_unused2");
                        csd.sum_tot_tend_spoiled2 = rs.getString("sum_tot_tend_spoiled2");
                        csd.sum_tot_tend_ballots2 = rs.getString("sum_tot_tend_ballots2");
                        csd.sum_tot_ballots2 = rs.getString("sum_tot_ballots2");
                        csd.sum_tot_spoiled_replaced2 = rs.getString("sum_tot_spoiled_replaced2");
                        csd.electionid = rs.getString("electionid");
                        csd.response = rs.getString("response");

                        closeStatsDetails.add(csd);
                    }
                }
            } catch (SQLException | MDLDBException e) {
                logger.error("Error : "+ e.getMessage());
                throw new MDLDBException("DB Exception " + e.getMessage());
            }
        } else {
            logger.warn("orgid(" + orgId + ") or electionid(" + electionId + ")  is not defined");
        }
        return closeStatsDetails;
    }


    private String getPollingStationList(int orgId) throws MDLDBException {
        StringBuilder sb = new StringBuilder();

        //first get all the polling stations under this hierarchy
        //add all the polling station ids
        String query0 = "SELECT id FROM psm.polling_station where organization_id=?;";
        if (orgId > 0) {
            try (Connection conn = DatabaseConnectionManager.getConnection();
                PreparedStatement statement1 = conn.prepareStatement(query0)) {
                statement1.setInt(1, orgId);
                try (ResultSet rs1 = statement1.executeQuery(query0)) {
                    while (rs1.next()) {
                        sb.append(rs1.getInt("id") + ",");
                    }
                }
            } catch (SQLException | MDLDBException e) {
                logger.error("Error : "+ e.getMessage());
                throw new MDLDBException("DB Exception " + e.getMessage());
            }
        } else {
            logger.warn("orgid(" + orgId + ")  is not defined");
        }
        return sb.toString();
    }

    public ArrayList<CloseStatsDto> getAllCloseStats(String token, int electionId, int hierarchyId) throws MDLDBException {
        GeoHierarchyDao geoHierarchy = new GeoHierarchyDaoImpl();
        int orgId = SubscriptionQuerryHandler.getOrganizationId(token);
        ArrayList<CloseStatsDto> closeStatsDetails = new ArrayList<CloseStatsDto>();

        if (orgId > 0 && electionId > 0 && hierarchyId > 0) {
            List<HierarchyValue> hierarchyValues = geoHierarchy.findHierarchyValueByOrganizationId(orgId);
            int userId = SecurityQuerryHandler.getUserId(token, orgId);

            String stationList = commonDao.getPollingStationList(hierarchyId, orgId, userId).replaceAll(",$", "");

            String query = "select ecs.tot_ballots,ecs.tot_spolied_issued as tot_spoiled_replaced, "
                    + "ecs.tot_unused,ecs.tot_tend_ballots, "
                    + "ecs.tot_tend_spoiled,ecs.tot_tend_unused, "
                    + "ecs.tot_ballots2,ecs.tot_spolied_issued2 as tot_spoiled_replaced2, "
                    + "ecs.tot_unused2,ecs.tot_tend_ballots2, "
                    + "ecs.tot_tend_spoiled2,ecs.tot_tend_unused2, "
                    + "el.election_name as electionname, "
                    + "ps.name as pollingstation, el.Id as electionid, "
                    + "hv.value as pollingstation_place, "
                    + "hv.parent_id as parent_id, "
                    + "hv.id as hierarchy_value_id, "
                    + "'success' as response "
                    + "from psm.election_close_stats ecs "
                    + "inner join psm.election el on el.id=election_id "
                    + "inner join psm.polling_station ps on ps.id=polling_station_id "
                    + "inner join psm.hierarchy_value hv on ps.hierarchy_value_id=hv.id "
                    + "where ecs.organization_id=? and ps.id in (" + stationList + ") "            //TODO give stationList as a param
                    + "and el.id=? ";
//						+ "and UNIX_TIMESTAMP(ecs.updatedon) > UNIX_TIMESTAMP(CURDATE()) ; ";

            try (Connection conn = DatabaseConnectionManager.getConnection();
                 PreparedStatement preparedStatement = conn.prepareStatement(query)) {
                preparedStatement.setInt(1, orgId);
                preparedStatement.setInt(2, electionId);
                try (ResultSet rs = preparedStatement.executeQuery()) {

                    while (rs.next()) {
                        CloseStatsDto csd = new CloseStatsDto();
                        HierarchyValue placeHierarchyValue = new HierarchyValue();
                        csd.tot_ballots = rs.getString("tot_ballots");
                        csd.tot_ballots2 = rs.getString("tot_ballots2");
                        csd.tot_spoiled_replaced = rs.getString("tot_spoiled_replaced");
                        csd.tot_spoiled_replaced2 = rs.getString("tot_spoiled_replaced2");
                        csd.tot_unused = rs.getString("tot_unused");
                        csd.tot_unused2 = rs.getString("tot_unused2");
                        csd.tot_tend_ballots = rs.getString("tot_tend_ballots");
                        csd.tot_tend_ballots2 = rs.getString("tot_tend_ballots2");
                        csd.tot_tend_spoiled = rs.getString("tot_tend_spoiled");
                        csd.tot_tend_spoiled2 = rs.getString("tot_tend_spoiled2");
                        csd.tot_tend_unused = rs.getString("tot_tend_unused");
                        csd.tot_tend_unused2 = rs.getString("tot_tend_unused2");
                        csd.electionname = rs.getString("electionname");
                        csd.pollingstation = rs.getString("pollingstation");
                        csd.electionid = rs.getString("electionid");
                        csd.pollingstation_place = rs.getString("pollingstation_place");
                        csd.parent_id = rs.getString("parent_id");
                        csd.hierarchy_value_id = rs.getString("hierarchy_value_id");
                        csd.response = rs.getString("response");


                        placeHierarchyValue.setParentId(rs.getInt("parent_id"));
                        placeHierarchyValue.setValue(csd.pollingstation_place);
                        List<HierarchyValue> temp = geoHierarchy.traverse(hierarchyValues, placeHierarchyValue);
                        if (temp.size() == 3) {
                            csd.pollingstation_ward = temp.get(0).getValue();
                            csd.pollingstation_district = temp.get(1).getValue();
                            for (HierarchyValue hv : hierarchyValues) {
                                if (hv.getId().intValue() == temp.get(0).getParentId().intValue()) {
                                    csd.pollingstation_council = hv.getValue();
                                    break;
                                }
                            }
                        }
                        closeStatsDetails.add(csd);
                    }
                }
            } catch (SQLException | MDLDBException e) {
                logger.error("Error : "+ e.getMessage());
                throw new MDLDBException("DB Exception " + e.getMessage());
            }
        } else {
            logger.warn("orgid(" + orgId + ") or electionid(" + electionId + ")  is not defined");
        }
        return closeStatsDetails;
    }

    public String updateAllCloseStats(String token, int electionId) throws MDLDBException {
        int orgId = SubscriptionQuerryHandler.getOrganizationId(token);

        if (orgId > 0 && electionId > 0) {
            String stationList = getPollingStationList(orgId).replaceAll(",$", "");
            String query = "update psm.election_close_stats set csv_export=1, "
                    + "csv_exporting_time=current_timestamp "
                    + "where organization_id=? and polling_station_id in (" + stationList + ") "
                    + "and election_id=?";

            try (Connection conn = DatabaseConnectionManager.getConnection();
                 PreparedStatement preparedStatement = conn.prepareStatement(query)) {
                preparedStatement.setInt(1, orgId);
                preparedStatement.setInt(2, electionId);
                preparedStatement.executeUpdate();
                return "success";
            } catch (SQLException | MDLDBException e) {
                logger.error("Error : "+ e.getMessage());
                throw new MDLDBException("DB Exception " + e.getMessage());
            }
        } else {
            logger.warn("orgid(" + orgId + ") or electionid(" + electionId + ")  is not defined");
        }
        return "success";
    }

    public ArrayList<CloseStatsDto> getUnexportedAllCloseStats(String token, int electionId, int hierarchyId) throws MDLDBException {
        GeoHierarchyDao geoHierarchy = new GeoHierarchyDaoImpl();
        int orgId = SubscriptionQuerryHandler.getOrganizationId(token);
        ArrayList<CloseStatsDto> closeStatsDetails = new ArrayList<CloseStatsDto>();

        if (orgId > 0 && electionId > 0 && hierarchyId > 0) {
            List<HierarchyValue> hierarchyValues = geoHierarchy.findHierarchyValueByOrganizationId(orgId);
            int userId = SecurityQuerryHandler.getUserId(token, orgId);
            String stationList = commonDao.getPollingStationList(hierarchyId, orgId, userId).replaceAll(",$", "");
            String query = "select ecs.tot_ballots,ecs.tot_spolied_issued as tot_spoiled_replaced, "
                    + "ecs.tot_unused,ecs.tot_tend_ballots, "
                    + "ecs.tot_tend_spoiled,ecs.tot_tend_unused, "
                    + "ecs.tot_ballots2,ecs.tot_spolied_issued2 as tot_spoiled_replaced2, "
                    + "ecs.tot_unused2,ecs.tot_tend_ballots2, "
                    + "ecs.tot_tend_spoiled2,ecs.tot_tend_unused2, "
                    + "el.election_name as electionname, "
                    + "ps.name as pollingstation, el.Id as electionid, "
                    + "hv.value as pollingstation_place, "
                    + "hv.parent_id as parent_id, "
                    + "hv.id as hierarchy_value_id, "
                    + "'success' as response "
                    + "from psm.election_close_stats ecs "
                    + "inner join psm.election el on el.id=election_id "
                    + "inner join psm.polling_station ps on ps.id=polling_station_id "
                    + "inner join psm.hierarchy_value hv on ps.hierarchy_value_id=hv.id "
                    + "where ecs.organization_id=? and ps.id in (" + stationList + ") "            //TODO give stationList as a param
                    + "and el.id=? "
                    + "and ecs.csv_export=0 ";
//						+ "and UNIX_TIMESTAMP(ecs.updatedon) > UNIX_TIMESTAMP(CURDATE()) ; ";
            try (Connection conn = DatabaseConnectionManager.getConnection();
                 PreparedStatement preparedStatement = conn.prepareStatement(query)) {
                preparedStatement.setInt(1, orgId);
                preparedStatement.setInt(2, electionId);
                try (ResultSet rs = preparedStatement.executeQuery()) {
                    while (rs.next()) {
                        CloseStatsDto csd = new CloseStatsDto();
                        HierarchyValue placeHierarchyValue = new HierarchyValue();
                        csd.tot_ballots = rs.getString("tot_ballots");
                        csd.tot_ballots2 = rs.getString("tot_ballots2");
                        csd.tot_spoiled_replaced = rs.getString("tot_spoiled_replaced");
                        csd.tot_spoiled_replaced2 = rs.getString("tot_spoiled_replaced2");
                        csd.tot_unused = rs.getString("tot_unused");
                        csd.tot_unused2 = rs.getString("tot_unused2");
                        csd.tot_tend_ballots = rs.getString("tot_tend_ballots");
                        csd.tot_tend_ballots2 = rs.getString("tot_tend_ballots2");
                        csd.tot_tend_spoiled = rs.getString("tot_tend_spoiled");
                        csd.tot_tend_spoiled2 = rs.getString("tot_tend_spoiled2");
                        csd.tot_tend_unused = rs.getString("tot_tend_unused");
                        csd.tot_tend_unused2 = rs.getString("tot_tend_unused2");
                        csd.electionname = rs.getString("electionname");
                        csd.pollingstation = rs.getString("pollingstation");
                        csd.electionid = rs.getString("electionid");
                        csd.pollingstation_place = rs.getString("pollingstation_place");
                        csd.parent_id = rs.getString("parent_id");
                        csd.hierarchy_value_id = rs.getString("hierarchy_value_id");
                        csd.response = rs.getString("response");

                        placeHierarchyValue.setParentId(rs.getInt("parent_id"));
                        placeHierarchyValue.setValue(csd.pollingstation_place);
                        List<HierarchyValue> temp = geoHierarchy.traverse(hierarchyValues, placeHierarchyValue);
                        if (temp.size() == 3) {
                            csd.pollingstation_ward = temp.get(0).getValue();
                            csd.pollingstation_district = temp.get(1).getValue();
                            for (HierarchyValue hv : hierarchyValues) {
                                if (hv.getId().intValue() == temp.get(0).getParentId().intValue()) {
                                    csd.pollingstation_council = hv.getValue();
                                    break;
                                }
                            }
                        }
                        closeStatsDetails.add(csd);
                    }
                }
            } catch (SQLException | MDLDBException e) {
                logger.error("Error : "+ e.getMessage());
                throw new MDLDBException("DB Exception " + e.getMessage());
            }
        } else {
            logger.warn("orgid(" + orgId + ") or electionid(" + electionId + ")  is not defined");
        }
        return closeStatsDetails;
    }
}
