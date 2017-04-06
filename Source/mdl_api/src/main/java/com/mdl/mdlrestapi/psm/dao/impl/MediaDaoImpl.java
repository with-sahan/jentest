package com.mdl.mdlrestapi.psm.dao.impl;

import com.mdl.mdlrestapi.psm.dao.MediaDao;
import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.psm.service.MediaService;
import com.mdl.mdlrestapi.util.database.DatabaseConnectionManager;
import com.mdl.mdlrestapi.util.database.subscription.SubscriptionQuerryHandler;
import org.apache.log4j.Logger;

import java.sql.*;

/**
 * Created by lasantha on 3/9/2017.
 */
public class MediaDaoImpl implements MediaDao {
    private static final Logger logger = Logger.getLogger(MediaDaoImpl.class);

    @Override
    public void saveToDbCamera(String uploadedFileLocation, String stationId, String token) throws MDLDBException {
        int resultvalue;
        int orgid = SubscriptionQuerryHandler.getOrganizationId(token);
        String query1 = "select el.id as electionid from psm.election el inner join psm.polling_station_election pse "
                + "on pse.election_id=el.id where date(election_date_start)=date(current_date) and "
                + "el.organization_id=? and pse.organization_id=?  and pse.polling_station_id=?";
        try (Connection conn = DatabaseConnectionManager.getConnection();
             PreparedStatement preparedStatement1 = conn.prepareStatement(query1)) {
            preparedStatement1.setInt(1, orgid);
            preparedStatement1.setInt(2, orgid);
            preparedStatement1.setString(3, stationId);
            try (ResultSet rs1 = preparedStatement1.executeQuery()) {

                while (rs1.next()) {
                    int eid = rs1.getInt("electionid");
                    String query2 = "insert into psm.station_photo"
                            + "(organization_id, station_id,election_id,image_url,createdon ) values(?,?,?,?,CURRENT_TIMESTAMP)";

                    try (PreparedStatement preparedStatement2 = conn.prepareStatement(query2)) {
                        preparedStatement2.setInt(1, orgid);
                        preparedStatement2.setInt(2, Integer.parseInt(stationId));
                        preparedStatement2.setInt(3, eid);
                        preparedStatement2.setString(4, uploadedFileLocation);
                        //preparedStatement2.setString(5, now());

                        resultvalue = preparedStatement2.executeUpdate();
                        if (resultvalue != 1)
                            logger.warn("Upload Failed!");
                    }
                }
            }
        } catch (SQLException | MDLDBException e) {
            logger.error("Error : "+ e.getMessage());
            throw new MDLDBException("DB Exception " + e.getMessage());
        }
    }

    @Override
    public void saveToDbNotification(String uploadedFileLocation, String notification_id, String token)
            throws MDLDBException {
        int resultvalue;
        int orgid = SubscriptionQuerryHandler.getOrganizationId(token);
        if(logger.isDebugEnabled()){
        logger.debug("Parameters for 'saveToDbNotification': uploadedFileLocation: " + uploadedFileLocation
                + " notification_id :" + notification_id + " token");
        }
        String query = "update psm.notification set attachtment_url =? where id =? and organization_id=?";
        try (Connection conn = DatabaseConnectionManager.getConnection();
             PreparedStatement preparedStatement1 = conn.prepareStatement(query)) {
            preparedStatement1.setString(1, uploadedFileLocation);
            preparedStatement1.setString(2, notification_id);
            preparedStatement1.setInt(3, orgid);
            resultvalue = preparedStatement1.executeUpdate();
            if (resultvalue != 1) {
                if(logger.isDebugEnabled()){
                logger.debug("Upload Failed!");
                }
            }
        } catch (SQLException | MDLDBException e) {
            logger.error("Error : "+ e.getMessage());
            throw new MDLDBException("DB Exception " + e.getMessage());
        }
    }

    //get the csv structure id
    public int getCsvStructureId(String token) throws MDLDBException {
        int res = 0;
        //stored procedure calling statement
        String callString = "{call psm.getcsvstructureid(?)}";
        try (Connection conn = DatabaseConnectionManager.getConnection();
             CallableStatement cs = conn.prepareCall(callString)) {
            // Adding items to arrayList
            cs.setString(1, token);
            try (ResultSet rs = cs.executeQuery()) {
                while (rs.next()) {
                    res = rs.getInt("csvstructureid");
                }
            }
        } catch (SQLException | MDLDBException e) {
            logger.error("Error : "+ e.getMessage());
            throw new MDLDBException("DB Exception " + e.getMessage());
        }
        return res;
    }
}
