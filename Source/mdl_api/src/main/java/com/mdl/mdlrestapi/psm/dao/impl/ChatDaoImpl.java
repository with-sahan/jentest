package com.mdl.mdlrestapi.psm.dao.impl;

import com.mdl.mdlrestapi.psm.dao.ChatDao;
import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.util.database.DatabaseConnectionManager;
import com.mdl.mdlrestapi.util.database.security.SecurityQuerryHandler;
import com.mdl.mdlrestapi.util.database.subscription.SubscriptionQuerryHandler;
import org.apache.log4j.Logger;

import java.sql.*;

/**
 * Created by lasantha on 3/13/2017.
 */
public class ChatDaoImpl implements ChatDao{
    private static final Logger logger = Logger.getLogger(ChatDaoImpl.class);

    public int saveToDbChat(String uploadedFileLocation, String issueid, String pollingstationid, String chatmessage,
                             String token) throws MDLDBException {
        int organizationid = SubscriptionQuerryHandler.getOrganizationId(token);
        int userid = SecurityQuerryHandler.getUserId(token, organizationid);

        if (!pollingstationid.equals("-1")) {
            // message will be sent only for a single polling station
            String singleStationInsert = "insert into psm.chat"
                    + "(userid, issueid, organizationid, pollingstationid, chatmessage, attachtment_url, createdon )"
                    + "values(?,?,?,?,?,?,CURRENT_TIMESTAMP);";

            try (Connection conn = DatabaseConnectionManager.getConnection();
                PreparedStatement preparedStatement = conn.prepareStatement(singleStationInsert)){
                preparedStatement.setInt(1, userid);
                preparedStatement.setString(2, issueid);
                preparedStatement.setInt(3, organizationid);
                preparedStatement.setString(4, pollingstationid);
                preparedStatement.setString(5, chatmessage);
                preparedStatement.setString(6, uploadedFileLocation);
                //preparedStatement2.setString(7, now());

                int insertCount = preparedStatement.executeUpdate();
                if (insertCount == 1) {
                    if(logger.isDebugEnabled()){
                    logger.debug("successfully saved to DB Chat, token :" + token);
                    }

                    try(Statement s2 = conn.createStatement();
                    ResultSet rs1 = s2.executeQuery("SELECT LAST_INSERT_ID() as id;")){
                        while (rs1.next()) {
                            return rs1.getInt("id");
                        }
                    }
                }
            } catch (SQLException | MDLDBException e ) {
                logger.error("Error : "+ e.getMessage());
                throw new MDLDBException("DB Exception " + e.getMessage());
            }
        }
        if(logger.isDebugEnabled()){
        logger.debug("Fail saving to DB Chat, token :" + token);
        }
        return -1;
    }

}
