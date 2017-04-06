package com.mdl.mdlrestapi.psm.dao.impl;

import com.mdl.mdlrestapi.psm.dao.CommonDao;
import com.mdl.mdlrestapi.psm.dao.TrackProgressDao;
import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.psm.resource.dto.SpeedDto;
import com.mdl.mdlrestapi.util.database.DatabaseConnectionManager;
import com.mdl.mdlrestapi.util.database.security.SecurityQuerryHandler;
import com.mdl.mdlrestapi.util.database.subscription.SubscriptionQuerryHandler;
import com.mdl.mdlrestapi.util.models.TrackingDto;
import com.mdl.mdlrestapi.util.models.TrackingListDto;
import com.mdl.mdlrestapi.util.models.TrackingResult;
import org.apache.log4j.Logger;

import java.sql.*;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by lasantha on 3/8/2017.
 */
public class TrackProgressDaoImpl implements TrackProgressDao {
    private static final Logger logger = Logger.getLogger(TrackProgressDaoImpl.class);
    private final int R = 6371; // Radious of the earth
    CommonDao commonDao = new CommonDaoImpl();

//    public ArrayList<TrackingDto> getFilterResults(String token, int hierarchyId) throws MDLDBException {
//        int orgid = 0;
//        ArrayList<TrackingDto> trackingDtoArrayList = new ArrayList<TrackingDto>();
//        //get the organization id
//        if (logger.isDebugEnabled()) {
//            logger.debug("Got Parameters for GetFilterResults : token :" + token + " hierarchy Id :" + hierarchyId);
//        }
//        orgid = SubscriptionQuerryHandler.getOrganizationId(token);
//        //Prepare the polling station list based on the hierarchy
//        String stationList = getPollingStationList(hierarchyId, orgid).replaceAll(",$", "");
//
//        String blrQry = "select track.pollingstationid as stationid, "
//                + "psm.getarrivaltime(track.id) as arrivaltime, "
//                + "td.ballot_box_number, "
//                + "IFNULL(track.longtitude,0) as longtitude, "
//                + "IFNULL(track.latitude, 0) as latitude, "
//                + "cc.name as counting_center_id, "
//                + "track.status as status, "
//                + "IFNULL(cc.latitude, 0) as destination_latitude, "
//                + "IFNULL(cc.longitude,0) as destination_longtitude, "
//                + "p.name as polling_station, "
//                + "'success' as response "
//                + "from psm.tracking track "
//                + "inner join "
//                + "( "
//                + "select "
//                + "MAX(t.id) as trackingid "
//                + ",GROUP_CONCAT(pse.ballot_box_number) as ballot_box_number "
//                + "from "
//                + "psm.tracking t inner join psm.polling_station_election pse "
//                + "on pse.polling_station_id = t.pollingstationid and pse.election_id = t.election_id and pse.organization_id = t.organization_id "
//                + "inner join psm.election e on pse.election_id = e.id and pse.organization_id = t.organization_id "
//                + "where t.organization_id = ? "
//                + "and date(e.election_date_start)=date(current_date) and pse.polling_station_id in (" + stationList + ") "
//                + "GROUP BY t.pollingstationid "
//                + ") td on track.id = td.trackingid "
//                + "INNER JOIN psm.polling_station_election_counting psec on "
//                + "psec.polling_station_id = track.pollingstationid and psec.election_id = track.election_id and psec.organization_id = track.organization_id "
//                + "inner join psm.counting_center cc on psec.counting_center_id = cc.id and psec.organization_id = cc.organization_id "
//                + "inner join psm.polling_station p on psec.polling_station_id = p.id "
//                + "order by p.id;";
//
//        try (Connection conn = DatabaseConnectionManager.getConnection();
//             PreparedStatement statement = conn.prepareStatement(blrQry)) {
//            statement.setInt(1, orgid);
//            //statement.setString(2, stationList);
//            try (ResultSet rs = statement.executeQuery()) {
//                while (rs.next()) {
//                    TrackingDto entry = new TrackingDto();
//                    entry.response = rs.getString("response");
//                    entry.ballot_box_number = rs.getString("ballot_box_number");
//                    entry.stationid = rs.getString("stationid");
//                    entry.destination_latitude = rs.getString("destination_latitude");
//                    entry.polling_station = rs.getString("polling_station");
//                    entry.counting_center_id = rs.getString("counting_center_id");
//                    entry.longtitude = rs.getString("longtitude");
//                    entry.destination_longtitude = rs.getString("destination_longtitude");
//                    entry.latitude = rs.getString("latitude");
//                    entry.arrivaltime = rs.getString("arrivaltime");
//                    entry.status = rs.getString("status");
//                    trackingDtoArrayList.add(entry);
//                    //ird.result.entry.add(entry);
//                }
//            }
//        } catch (SQLException | MDLDBException e) {
//            logger.error("Error : " + e.getMessage());
//            throw new MDLDBException("DB Exception " + e.getMessage());
//        }
//        return trackingDtoArrayList;
//    }
//
//    private String getPollingStationList(int hierarchyId, int orgId) throws MDLDBException {
//        StringBuilder sb = new StringBuilder();
//        int selHrc = 0;
//        //first get all the polling stations under this hierarchy
//        String query1 = "SELECT id FROM psm.polling_station where hierarchy_value_id=? and organization_id=?;";
//        try (Connection conn = DatabaseConnectionManager.getConnection();
//             //add all the polling station ids
//             PreparedStatement statement1 = conn.prepareStatement(query1)) {
//            statement1.setInt(1, hierarchyId);
//            statement1.setInt(2, orgId);
//            try (ResultSet rs1 = statement1.executeQuery()) {
//                while (rs1.next()) {
//                    sb.append(rs1.getInt("id") + ",");
//                }
//            }
//            //now check child hierarchies for this hierachy and recurse
//            String query2 = "SELECT id FROM psm.hierarchy_value where parent_id=? and organization_id=?;";
//            try (PreparedStatement statement2 = conn.prepareStatement(query2)) {
//                statement2.setInt(1, hierarchyId);
//                statement2.setInt(2, orgId);
//                try (ResultSet rs2 = statement2.executeQuery()) {
//                    while (rs2.next()) {
//                        selHrc = rs2.getInt("id");
//                        sb.append(getPollingStationList(selHrc, orgId));
//                    }
//                }
//            }
//        } catch (SQLException | MDLDBException e) {
//            logger.error("Error : " + e.getMessage());
//            throw new MDLDBException("DB Exception " + e.getMessage());
//        }
//        return sb.toString();
//    }


    //Add New Feature for gps tracking

    public ArrayList<TrackingDto> getFilterResults(String token, int hierarchyId) throws MDLDBException {
        int orgid, userid = 0;
        ArrayList<TrackingDto> trackingDtoArrayList = new ArrayList<TrackingDto>();

        //get the organization id
        logger.info("Got Parameters for GetFilterResults : token :" + token + " hierarchy Id :" + hierarchyId);
        orgid = SubscriptionQuerryHandler.getOrganizationId(token);
        userid = SecurityQuerryHandler.getUserId(token, orgid);
        //preapre the polling station list based on the hierarchy
        String stationList = commonDao.getPollingStationList(hierarchyId, orgid, userid).replaceAll(",$", "");

        String blrQry = "select td.tid as trackid,track.pollingstationid as stationid, "
                + "psm.getarrivaltime(track.id) as arrivaltime, "
                + "td.ballot_box_number, "
                + "IFNULL(track.longtitude,0) as longtitude, "
                + "IFNULL(track.latitude, 0) as latitude, "
                + "cc.name as counting_center_id, "
                + "track.status as status, "
                + "track.begin_lat as begin_latitude, "
                + "track.begin_long as begin_longtitude, "
                + "TIMESTAMPDIFF(SECOND,track.dispatch_time,track.updated_time) as timespentseconds, "
                + "IFNULL(cc.latitude, 0) as destination_latitude, "
                + "IFNULL(cc.longitude,0) as destination_longtitude, "
                + "p.name as polling_station, "
                + "'success' as response "
                + "from psm.tracking track "
                + "inner join "
                + "( "
                + "select  tdd.tracking_id as tid, "
                + "MAX(t.id) as trackingid "
//					+ ",GROUP_CONCAT(pse.ballot_box_number) as ballot_box_number "			//TO DO
                + ",pse.ballot_box_number as ballot_box_number "
                + "from "
                + "psm.tracking t inner join psm.polling_station_election pse "
                + "on pse.polling_station_id = t.pollingstationid and pse.election_id = t.election_id and pse.organization_id = t.organization_id "
                + "inner join psm.election e on pse.election_id = e.id and pse.organization_id = t.organization_id "
                + "inner join psm.tracking_data tdd on tdd.tracking_id=t.id "
                + "where t.organization_id =? "
                + " and pse.polling_station_id in (" + stationList + " ) "
                + "GROUP BY t.pollingstationid "
                + ") td on track.id = td.trackingid "
                + "INNER JOIN psm.polling_station_election_counting psec on "
                + "psec.polling_station_id = track.pollingstationid and psec.election_id = track.election_id and psec.organization_id = track.organization_id "
                + "inner join psm.counting_center cc on psec.counting_center_id = cc.id and psec.organization_id = cc.organization_id "
                + "inner join psm.polling_station p on psec.polling_station_id = p.id "
                + "order by p.id;";

        //System.out.println(blrQry);
        try (Connection conn = DatabaseConnectionManager.getConnection();
            PreparedStatement statement = conn.prepareStatement(blrQry)) {
            statement.setInt(1, orgid);

            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    TrackingDto entry = new TrackingDto();
                    entry.average_speed = getAverageSpeed(rs.getInt("trackid"));
                    entry.response = rs.getString("response");
                    entry.ballot_box_number = rs.getString("ballot_box_number");
                    entry.stationid = rs.getString("stationid");
                    entry.destination_latitude = rs.getString("destination_latitude");
                    entry.polling_station = rs.getString("polling_station");
                    entry.counting_center_id = rs.getString("counting_center_id");
                    entry.longtitude = rs.getString("longtitude");
                    entry.destination_longtitude = rs.getString("destination_longtitude");
                    entry.latitude = rs.getString("latitude");
                    entry.arrivaltime = rs.getString("arrivaltime");
                    entry.begin_latitude = rs.getString("begin_latitude");
                    entry.begin_longtitude = rs.getString("begin_longtitude");
                    entry.timespentseconds = rs.getString("timespentseconds");
                    entry.status = rs.getString("status");
                    trackingDtoArrayList.add(entry);
                }
            }
        } catch (SQLException | MDLDBException  e) {
            logger.error("Error : " + e.getMessage());
            throw new MDLDBException("DB Exception " + e.getMessage());
        }
        return trackingDtoArrayList;
    }


    private String getAverageSpeed(int tid) throws MDLDBException {
        ArrayList<SpeedDto> spList = null;
        String query = "select * from psm.tracking_data where tracking_id=? order by id desc limit 10;";
        try (Connection conn = DatabaseConnectionManager.getConnection();
             PreparedStatement statement = conn.prepareStatement(query)) {
            statement.setInt(1, tid);
            try (ResultSet rs = statement.executeQuery()) {
                spList = new ArrayList<>();
                while (rs.next()) {
                    SpeedDto sdto = new SpeedDto();
                    sdto.id = rs.getInt("id");
                    sdto.latitude = rs.getString("latitude");
                    sdto.longtitude = rs.getString("longitude");
                    sdto.updatedtime = rs.getString("updateon");
                    spList.add(sdto);
                }
            }
            return calculateMeanSpeed(spList) + "";
        } catch (SQLException | MDLDBException e) {
            logger.error("Error : " + e.getMessage());
            throw new MDLDBException("DB Exception " + e.getMessage());
        }

    }


    private double calculateMeanSpeed(ArrayList<SpeedDto> spList) throws MDLDBException {
        double mSpeed = 0;
        if (spList.size() < 2) {
            return 0;
        } else {
            for (int i = 0, j = 1; j < spList.size(); i++, j++) {
                double distance = getDistance(spList.get(i).latitude, spList.get(j).latitude, spList.get(i).longtitude, spList.get(j).longtitude);
                int time = getTimeSeconds(spList.get(i).updatedtime, spList.get(j).updatedtime);
                if (time > 1) {
                    mSpeed = mSpeed + (distance / time);
                }
            }
            return mSpeed / spList.size();
        }
    }

    private double getDistance(String slat1, String slat2, String slon1, String slon2) {
        Double lat1 = Double.parseDouble(slat1);
        Double lat2 = Double.parseDouble(slat2);
        Double lon1 = Double.parseDouble(slon1);
        Double lon2 = Double.parseDouble(slon2);
        Double latDistance = toRad(lat2 - lat1);
        Double lonDistance = toRad(lon2 - lon1);
        Double a = Math.sin(latDistance / 2) * Math.sin(latDistance / 2) +
                Math.cos(toRad(lat1)) * Math.cos(toRad(lat2)) *
                        Math.sin(lonDistance / 2) * Math.sin(lonDistance / 2);
        Double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
        return R * c;
    }

    private static Double toRad(Double value) {
        return value * Math.PI / 180;
    }

    private int getTimeSeconds(String time1, String time2) throws MDLDBException {
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        java.util.Date date1 = null;
        try {
            date1 = format.parse(time1);
        java.util.Date date2 = format.parse(time2);
        long difference = date1.getTime() - date2.getTime();
            return (int) (difference / 1000);
        } catch (ParseException  e) {
            logger.error("Error : " + e.getMessage());
            throw new MDLDBException("DB Exception " + e.getMessage());
        }
    }

}
