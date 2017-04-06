package com.mdl.mdlrestapi.psm.dao.impl;

import com.mdl.mdlrestapi.psm.dao.ElectionDao;
import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.psm.resource.ElectionResource;
import com.mdl.mdlrestapi.util.SimpleRequest;
import com.mdl.mdlrestapi.util.database.DatabaseConnectionManager;
import com.mdl.mdlrestapi.util.database.subscription.SubscriptionQuerryHandler;
import com.mdl.mdlrestapi.util.models.ActivationDayRequest;
import org.apache.log4j.Logger;
import org.json.JSONObject;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Properties;

/**
 * Created by lasantha on 3/13/2017.
 */
public class ElectionDaoImpl implements ElectionDao{

    private static final Logger logger = Logger.getLogger(ElectionDaoImpl.class);
    private static final int BEFORE = 0;
    private static final int ON = 1;
    private static final int AFTER = 2;
    static Properties props = new Properties();


    public JSONObject resetTenantData(SimpleRequest request) throws MDLDBException{
        JSONObject responseobj = new JSONObject();
        String query = "call psm.resetelection_2(?)";
        String response = null;
        try (Connection conn = DatabaseConnectionManager.getConnection()) {

            int orgid = SubscriptionQuerryHandler.getOrganizationId(request.token);
            if (orgid > 0) {
                try (PreparedStatement statement1 = conn.prepareStatement(query)) {
                    statement1.setInt(1, orgid);
                    try (ResultSet rs1 = statement1.executeQuery()) {

                        while (rs1.next()) {
                            response = rs1.getString("response");
                        }
                    }
                }
            }
        } catch (SQLException | MDLDBException e) {
            logger.error("Error : "+ e.getMessage());
            throw new MDLDBException("DB Exception " + e.getMessage());
        }
        responseobj.put("response", response);
        return responseobj;
    }

    public JSONObject updateActivatedDay(ActivationDayRequest request) throws MDLDBException{
        JSONObject responseobj = new JSONObject();
        StringBuilder sb = new StringBuilder("update subscription.organization set activationday=");

        switch (request.activationstatus.toLowerCase()) {
            case "pre":
                sb.append("(CURDATE() + INTERVAL 1 DAY) where id=?");
                break;
            case "current":
                sb.append("CURDATE() where id=?");
                break;
            case "post":
                sb.append("(CURDATE() - INTERVAL 1 DAY) where id=?");
                break;
            default:
                sb.append("activationday where id=?");
                break;
        }

        String response = null;
        int orgid = SubscriptionQuerryHandler.getOrganizationId(request.token);
        if (orgid > 0) {
            try (Connection conn = DatabaseConnectionManager.getConnection();
                 PreparedStatement statement1 = conn.prepareStatement(sb.toString())) {
                statement1.setInt(1, orgid);
                int result = statement1.executeUpdate();

                if (result > 0) {
                    response = "success";
                } else {
                    response = "error";
                }
            } catch (SQLException | MDLDBException e) {
                logger.error("Error : "+ e.getMessage());
                throw new MDLDBException("DB Exception " + e.getMessage());
            }

        } else {
            response = "error";
            logger.error("Error : "+ response);
            throw new MDLDBException("organization id is invalid");
        }

        responseobj.put("response", response);
        return responseobj;
    }

    public JSONObject getActivatedDay(SimpleRequest request) throws MDLDBException{
        JSONObject responseobj = new JSONObject();
        String query0 = "select current_date() as today, psm.getactivationdate(?) as activationday";
        String edatestr = null;
        String resultdatestr = null;
        Date resultdate = null;
        Date edate = null;
        int status = -1;

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//			edatestr = props.getProperty("electiondate"); //this is disabled during activation development time.
        try (Connection conn = DatabaseConnectionManager.getConnection()) {

            int orgid = SubscriptionQuerryHandler.getOrganizationId(request.token);
            if (orgid > 0) {
                try (PreparedStatement preparedStatement = conn.prepareStatement(query0)) {
                    preparedStatement.setInt(1, orgid);
                    try (ResultSet rs1 = preparedStatement.executeQuery()) {

                        while (rs1.next()) {
                            resultdatestr = rs1.getString("today");
                            edatestr = rs1.getString("activationday"); // should remove after the development
                        }
                    }
                }
                resultdate = sdf.parse(resultdatestr);
                edate = sdf.parse(edatestr);

                if (resultdate.compareTo(edate) < 0) {
                    status = BEFORE;
                } else if (resultdate.compareTo(edate) == 0) {
                    status = ON;
                } else if (resultdate.compareTo(edate) > 0) {
                    status = AFTER;
                } else status = -1;
            }
        } catch (SQLException | MDLDBException | ParseException e) {
            logger.error("Error : "+ e.getMessage());
            throw new MDLDBException("DB Exception " + e.getMessage());
        }
        responseobj.put("edate", edate);
        responseobj.put("currentdate", resultdate);
        responseobj.put("status", status);
        responseobj.put("response", "success");
        return responseobj;
    }
}
