package com.mdl.mdlrestapi.psm.dao.impl;

import com.mdl.mdlrestapi.psm.dao.PSMDashBoardDao;
import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.psm.resource.dto.ElectionResponse;
import com.mdl.mdlrestapi.psm.resource.dto.GetStatsRequest;
import com.mdl.mdlrestapi.psm.resource.dto.GetStatsResponse;
import com.mdl.mdlrestapi.psm.resource.dto.TokenRequest;
import com.mdl.mdlrestapi.psm.utils.QueryUtil;
import com.mdl.mdlrestapi.util.SimpleRequest;
import com.mdl.mdlrestapi.util.database.DatabaseConnectionManager;
import com.mdl.mdlrestapi.util.database.psm.PsmQuerryHandler;
import com.mdl.mdlrestapi.util.database.security.SecurityQuerryHandler;
import com.mdl.mdlrestapi.util.database.subscription.SubscriptionQuerryHandler;
import com.mdl.mdlrestapi.util.models.ElectionDto;
import com.mdl.mdlrestapi.util.models.PsmDashboardNotification;
import com.mdl.mdlrestapi.util.models.PsmDashboardStationData;
import com.mdl.mdlrestapi.util.models.UpdatePrePollingActivityRequest;
import org.apache.log4j.Logger;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Thara on 3/7/2017.
 */
public class PSMDashBoardDaoImlp implements PSMDashBoardDao {
    private static final Logger logger = Logger.getLogger(PSMDashBoardDaoImlp.class);
    SecurityQuerryHandler securityQuerryHandler=new SecurityQuerryHandler();

    @Override
    public GetStatsResponse getStats(GetStatsRequest request) throws MDLDBException {
        GetStatsResponse getStatsResponse = new GetStatsResponse();
        getStatsResponse.dashboardNotifications = new ArrayList<>();
        getStatsResponse.dashboardData = new ArrayList<>();
        int orgid;
        int userid;
        int totturnout = 0;
        int turnout;

        orgid = SubscriptionQuerryHandler.getOrganizationId(request.token);
        userid = securityQuerryHandler.getUserId(request.token, orgid);
        String query = QueryUtil.GET_PSM_TOTAL_TURNOUTS;
        try (Connection conn = DatabaseConnectionManager.getConnection();
             PreparedStatement preparedStatement = conn.prepareStatement(query)) {
            preparedStatement.setInt(1, request.electionId);
            preparedStatement.setInt(2, request.electionId);
            preparedStatement.setInt(3, userid);
            try (ResultSet resultset = preparedStatement.executeQuery()) {
                while (resultset.next()) {
                    totturnout = resultset.getInt(QueryUtil.PSM_POLLING_STATION_ELECTION_TURNOUTS);
                }
            }
            query = QueryUtil.GET_PSM_BALLOT_DETAILS;
            try (PreparedStatement preparedStatement1 = conn.prepareStatement(query)) {
                preparedStatement1.setInt(1, request.electionId);
                preparedStatement1.setInt(2, request.electionId);
                preparedStatement1.setInt(3, orgid);
                preparedStatement1.setInt(4, userid);

                try (ResultSet resultset = preparedStatement1.executeQuery()) {
                    while (resultset.next()) {
                        turnout = resultset.getInt(QueryUtil.PSM_BALLOT_DETAILS_BALLOTPAPERS);
                        getStatsResponse.ballotPapers = resultset.getInt(QueryUtil.PSM_BALLOT_DETAILS_BALLOTPAPERS);
                        getStatsResponse.postalPacks = resultset.getInt(QueryUtil.PSM_BALLOT_DETAILS_POSTALRECEIVED);
                        getStatsResponse.percentage = ((totturnout == 0) ? 0 : (double) 100.0 * (((double) turnout) / ((double) totturnout)));
                    }
                }
            }
            /**/
            query = QueryUtil.GET_PSM_BALLOT_DETAILS_BY_STATION;
            try (PreparedStatement preparedStatement2 = conn.prepareStatement(query)) {
                preparedStatement2.setInt(1, request.electionId);
                preparedStatement2.setInt(2, userid);
                preparedStatement2.setInt(3, request.electionId);
                preparedStatement2.setInt(4, orgid);
                preparedStatement2.setInt(5, orgid);

                try (ResultSet resultset = preparedStatement2.executeQuery()) {
                    while (resultset.next()) {
                        PsmDashboardStationData dbd = new PsmDashboardStationData();
                        dbd.ballotPapersIssued = resultset.getInt(QueryUtil.PSM_BALLOT_DETAILS_BALLOTPAPERS);
                        dbd.postalPackesCollected = resultset.getInt(QueryUtil.PSM_BALLOT_DETAILS_POSTALCOLLECTED);
                        dbd.postalPackesRecevied = resultset.getInt(QueryUtil.PSM_BALLOT_DETAILS_POSTALRECEIVED);
                        dbd.stationName = resultset.getString(QueryUtil.PSM_BALLOT_DETAILS_POLLINGSTATION);
                        dbd.status = resultset.getInt(QueryUtil.PSM_BALLOT_DETAILS_STATIONSTATUS);
                        dbd.issueStatus = PsmQuerryHandler.getIssueStatus(resultset.getInt(QueryUtil.ID), orgid);
                        getStatsResponse.dashboardData.add(dbd);
                    }
                }
            }

            /**/
            query = QueryUtil.UPDATE_TOP_NOTIFICATION;
            try (PreparedStatement preparedStatement3 = conn.prepareStatement(query)) {
                preparedStatement3.setInt(1, userid);
                preparedStatement3.setInt(2, orgid);

                try (ResultSet resultset = preparedStatement3.executeQuery()) {
                    while (resultset.next()) {
                        PsmDashboardNotification dbd = new PsmDashboardNotification();
                        dbd.id = resultset.getInt(QueryUtil.ID);
                        dbd.message = resultset.getString(QueryUtil.MESSAGE);
                        dbd.messageTime = resultset.getTimestamp(QueryUtil.MESSAGETIME).toString();
                        if (resultset.getInt(QueryUtil.PRIVATEMESSAGE) == 0) {
                            dbd.messageType = QueryUtil.GLOBAL;
                        } else {
                            dbd.messageType = QueryUtil.PRIVATE;
                        }
                        getStatsResponse.dashboardNotifications.add(dbd);
                    }
                }
            }
        } catch (SQLException | MDLDBException e) {
            logger.error("Error : "+ e.getMessage());
            throw new MDLDBException("DB Exception " + e.getMessage());
        }
        return getStatsResponse;
    }

    @Override
    public ArrayList<ElectionResponse> getElectionList(TokenRequest request) throws MDLDBException {
        ArrayList<ElectionResponse> electionList = new ArrayList<ElectionResponse>();
        int orgid;
        int userid;
        orgid = SubscriptionQuerryHandler.getOrganizationId(request.getToken());
        userid = securityQuerryHandler.getUserId(request.getToken(), orgid);
        if (userid <= 0 || orgid <= 0) {
            logger.warn("userId :" + userid + " and orgid " + orgid);
            return electionList;
        }
        String query = QueryUtil.GET_ELECTION_DETAILS;
        try (Connection conn = DatabaseConnectionManager.getConnection();
             PreparedStatement preparedStatement = conn.prepareStatement(query)) {
            preparedStatement.setInt(1, userid);
            preparedStatement.setInt(2, orgid);
            preparedStatement.setInt(3, orgid);
            try (ResultSet resultset = preparedStatement.executeQuery()) {
                while (resultset.next()) {
                    ElectionResponse dto = new ElectionResponse();
                    dto.setElectionName(resultset.getString(QueryUtil.ELECTION_NAME));
                    dto.setId(resultset.getInt(QueryUtil.ID));
                    electionList.add(dto);
                }
            }
        } catch (SQLException | MDLDBException e) {
            logger.error("Error : "+ e.getMessage());
            throw new MDLDBException("DB Exception " + e.getMessage());
        }
        return electionList;
    }

    @Override
    public String updatePrePollingActivity(List<UpdatePrePollingActivityRequest> updateList) throws MDLDBException {
        String respStatus = "";
        try (Connection conn = DatabaseConnectionManager.getConnection()) {
            String callString = "{call psm.updateprepollactivity(?,?,?,?)}";
            List<UpdatePrePollingActivityRequest> toBeUpdated = new ArrayList<UpdatePrePollingActivityRequest>();
            String query = "SELECT iscompleted from psm.open_close_election where polling_station_id=? and list_id=?";
            for (UpdatePrePollingActivityRequest updateActivity : updateList) {
                try (PreparedStatement preparedStatement = conn.prepareStatement(query)) {
                    preparedStatement.setInt(1, updateActivity.pollingstation_id);
                    preparedStatement.setInt(2, updateActivity.activity_id);
                    try (ResultSet rs1 = preparedStatement.executeQuery();) {
                        while (rs1.next()) {
                            Integer result = rs1.getInt("iscompleted");
                            if (result != updateActivity.status) {
                                toBeUpdated.add(updateActivity);
                            }
                        }
                    }
                }
            }
            try (CallableStatement cs = conn.prepareCall(callString)) {
                for (UpdatePrePollingActivityRequest updateActivity : updateList) {
                    String token = updateActivity.token;
                    String pollingstation_id = Integer.toString(updateActivity.pollingstation_id);
                    String activity_id = Integer.toString(updateActivity.activity_id);
                    String status = Integer.toString(updateActivity.status);

                    cs.setString(1, token);
                    cs.setString(2, pollingstation_id);
                    cs.setString(3, activity_id);
                    cs.setString(4, status);

                    try (ResultSet rs2 = cs.executeQuery();) {
                        if (rs2 == null) {
                            respStatus = "failed";
                        } else {
                            boolean allSuccess = true;
                            while (rs2.next()) {
                                String res = rs2.getString("response");
                                if (res.equals("unauthorized")) {
                                    respStatus = "failed";
                                    allSuccess = false;
                                    break;
                                }
                                if (!res.equals("success")) {
                                    allSuccess = false;
                                    respStatus = res;
                                    break;
                                }
                            }
                            if (allSuccess) {
                                respStatus = "success";
                            }
                        }
                    }
                }
            }
        } catch (SQLException | MDLDBException e) {
            logger.error("Error : "+ e.getMessage());
            throw new MDLDBException("DB Exception " + e.getMessage());
        }
        return respStatus;
    }
}
