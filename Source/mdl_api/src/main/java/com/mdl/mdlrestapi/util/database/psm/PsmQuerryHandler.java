package com.mdl.mdlrestapi.util.database.psm;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.psm.utils.QueryUtil;
import org.apache.log4j.Logger;

import com.mdl.mdlrestapi.util.database.DatabaseConnectionManager;
import com.mdl.mdlrestapi.util.database.psm.entities.PollingStation;
import com.mdl.mdlrestapi.util.database.security.entities.User;

public class PsmQuerryHandler {

    private static final Logger logger = Logger.getLogger(PsmQuerryHandler.class);

    /**
     * Filter polling station by userid
     *
     * @param userId
     * @return
     * @throws SQLException
     */
    public static List<PollingStation> findPollingStationIdListByUserId1(int userId) throws MDLDBException {
        List<PollingStation> pollingStationList = new ArrayList<PollingStation>();
        if (userId > 0) {
            String query = "SELECT ps.* FROM psm.user_election as ue inner join psm.polling_station_election as pse on ue.election_id = pse.election_id inner join psm.polling_station as ps on pse.polling_station_id = ps.id where ue.user_id=?;";
            try (Connection conn = DatabaseConnectionManager.getConnection();
                 PreparedStatement statement = conn.prepareStatement(query)) {
                statement.setInt(1, userId);
                try (ResultSet rs = statement.executeQuery()) {
                    while (rs.next()) {
                        PollingStation ps = new PollingStation();
                        ps.setId(rs.getInt("id"));
                        ps.setHierarchyValueId(rs.getInt("hierarchy_value_id"));
                        pollingStationList.add(ps);
                    }
                }
            } catch (Exception e) {
                throw new MDLDBException("DB Exception " + e.getMessage());
            }
        }
        return pollingStationList;
    }

    /**
     * Insert entry into issue_tracking table
     *
     * @param issueId
     * @param userId
     * @param chatIdValue
     * @return
     * @throws Exception
     */
    public static boolean createIssueTrackingNotification(int issueId, int userId, int chatIdValue) throws
            MDLDBException {
        if (issueId > 0 && userId > 0) {
            String query = "";
            try (Connection conn = DatabaseConnectionManager.getConnection()) {
                if (chatIdValue > 0) {
                    query = "INSERT INTO psm.issue_tracking (issue_id,user_id,watched,chat_id) values (?,?,?,?)";
                } else {
                    query = "INSERT INTO psm.issue_tracking (issue_id,user_id,watched) values (?,?,?)";
                }
                try (PreparedStatement ps = conn.prepareStatement(query)) {
                    if (chatIdValue > 0) {
                        ps.setInt(1, issueId);
                        ps.setInt(2, userId);
                        ps.setInt(3, 0);
                        ps.setInt(4, chatIdValue);
                    } else {
                        ps.setInt(1, issueId);
                        ps.setInt(2, userId);
                        ps.setInt(3, 0);
                    }
                    ps.executeUpdate();
                }
                return true;
            } catch (Exception e) {
                throw new MDLDBException("DB Exception " + e.getMessage());
            }
        }
        return false;
    }

    public static List<PollingStation> findPollingStationIdListByUserId(int userId) throws MDLDBException {
        List<PollingStation> pollingStationList = new ArrayList<PollingStation>();
        if (userId > 0) {
            String query = "SELECT ps.* FROM psm.user_election ue  inner join psm.polling_station ps on ue.pollingstation_id = ps.id where ue.user_id=?";
            try (Connection conn = DatabaseConnectionManager.getConnection();
                 PreparedStatement statement = conn.prepareStatement(query)) {
                statement.setInt(1, userId);
                try (ResultSet rs = statement.executeQuery()) {
                    while (rs.next()) {
                        PollingStation ps = new PollingStation();
                        ps.setId(rs.getInt("id"));
                        ps.setHierarchyValueId(rs.getInt("hierarchy_value_id"));
                        pollingStationList.add(ps);
                    }
                }
            } catch (Exception e) {
                throw new MDLDBException("DB Exception " + e.getMessage());
            }
        }
        return pollingStationList;
    }

    public static User getAssignedUserToIssue(int issueId) throws MDLDBException {
        if (issueId > 0) {
            String query = "SELECT u.* FROM psm.issue_assignment ia inner join security.user u on u.id=ia.user_id  where ia.issue_id=?";
            try (Connection conn = DatabaseConnectionManager.getConnection();
                 PreparedStatement ps = conn.prepareStatement(query)) {
                ps.setInt(1, issueId);
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        User user = new User();
                        user.setId(rs.getInt("id"));
                        user.setFirstName(rs.getString("firstName"));
                        user.setLastName(rs.getString("lastName"));
                        user.setEmail("email");
                        user.setOrganizationId(rs.getInt("organization_id"));
                        return user;
                    }
                }
            } catch (Exception e) {
                throw new MDLDBException("DB Exception " + e.getMessage());
            }
        }
        return null;
    }

    public static String getIssueStatus(int stationId, int orgId) throws MDLDBException {
        int solveCount = 0;
        int total = 0;
        String issueStatus;
        logger.debug("Parameters for getIssueStatus : ststionId " + stationId + " orgId :" + orgId);
        String query = QueryUtil.GET_ISSUE_COUNT;
        try (Connection conn = DatabaseConnectionManager.getConnection();
             PreparedStatement preparedStatement = conn.prepareStatement(query)) {
            preparedStatement.setInt(1, orgId);
            preparedStatement.setInt(2, stationId);
            try (ResultSet resultset = preparedStatement.executeQuery()) {
                while (resultset.next()) {
                    solveCount = resultset.getInt(QueryUtil.ISSUE_COUNT);
                }
            }
            query = QueryUtil.GET_ALL_ISSUE_COUNT;
            try (PreparedStatement preparedStatement1 = conn.prepareStatement(query)) {
                preparedStatement1.setInt(1, orgId);
                preparedStatement1.setInt(2, stationId);
                try (ResultSet resultset = preparedStatement1.executeQuery()) {
                    while (resultset.next()) {
                        total = resultset.getInt(QueryUtil.ISSUE_COUNT);
                    }
                    issueStatus = (total - solveCount) + "/" + total;
                }
            }
        } catch (Exception e) {
            throw new MDLDBException("DB Exception " + e.getMessage());
        }
        return issueStatus;
    }
}
