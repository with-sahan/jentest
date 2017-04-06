package com.mdl.mdlrestapi.util.database.psm;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import com.mdl.mdlrestapi.util.database.DatabaseConnectionManager;
import com.mdl.mdlrestapi.util.database.psm.entities.PollingStation;
import com.mdl.mdlrestapi.util.database.security.entities.User;

public class PsmQuerryHandler {

	private static final Logger logger = Logger.getLogger(PsmQuerryHandler.class);

	/**
	 * Filter polling station by userid
	 * @param userId
	 * @return
	 * @throws SQLException
	 */
	public static List<PollingStation> findPollingStationIdListByUserId1(int userId) throws Exception{
		List<PollingStation> pollingStationList = new ArrayList<PollingStation>();
		if(userId > 0){
			String query = "SELECT ps.* FROM psm.user_election as ue inner join psm.polling_station_election as pse on ue.election_id = pse.election_id inner join psm.polling_station as ps on pse.polling_station_id = ps.id where ue.user_id="+userId;
			ResultSet rs = null;
			Statement statement = null;
			Connection conn = null;
			try {
				conn = DatabaseConnectionManager.getConnection();
				statement = conn.createStatement();
				rs = statement.executeQuery(query);
				while (rs.next()) {
					PollingStation ps = new PollingStation();
					ps.setId(rs.getInt("id"));
					ps.setHierarchyValueId(rs.getInt("hierarchy_value_id"));
					pollingStationList.add(ps);
				}
			} finally {

				if (rs != null) {
					rs.close();
				}
				if (statement != null) {
					statement.close();
				}
				if(conn != null){
					conn.close();
				}
			}
		}
		return pollingStationList;

	}

	/**
	 * Insert entry into issue_tracking table
	 * @param issueId
	 * @param userId
	 * @param chatIdValue
	 * @return
	 * @throws Exception
	 */
	public static boolean createIssueTrackingNotification(int issueId, int userId, int chatIdValue) throws Exception {
		if (issueId > 0 && userId > 0) {

			PreparedStatement ps = null;
			Connection conn = null;
			try {
				conn = DatabaseConnectionManager.getConnection();
				if (chatIdValue > 0) {

					String query = "INSERT INTO psm.issue_tracking (issue_id,user_id,watched,chat_id) values (?,?,?,?)";
					ps = conn.prepareStatement(query);
					ps.setInt(4, chatIdValue);
				} else {
					String query = "INSERT INTO psm.issue_tracking (issue_id,user_id,watched) values (?,?,?)";
					ps = conn.prepareStatement(query);
				}

				ps.setInt(1, issueId);
				ps.setInt(2, userId);
				ps.setInt(3, 0);

				ps.executeUpdate();
				return true;
			} finally {
				if (ps != null) {
					ps.close();
				}
				if (conn != null) {
					conn.close();
				}
			}
		}

		return false;
	}

	public static List<PollingStation> findPollingStationIdListByUserId(int userId) throws Exception{
		List<PollingStation> pollingStationList = new ArrayList<PollingStation>();
		if(userId > 0){
			String query = "SELECT ps.* FROM psm.user_election ue  inner join psm.polling_station ps on ue.pollingstation_id = ps.id where ue.user_id="+userId;
			ResultSet rs = null;
			Statement statement = null;
			Connection conn = null;
			try {
				conn = DatabaseConnectionManager.getConnection();
				statement = conn.createStatement();
				rs = statement.executeQuery(query);
				while (rs.next()) {
					PollingStation ps = new PollingStation();
					ps.setId(rs.getInt("id"));
					ps.setHierarchyValueId(rs.getInt("hierarchy_value_id"));
					pollingStationList.add(ps);
				}
			} finally {

				if (rs != null) {
					rs.close();
				}
				if (statement != null) {
					statement.close();
				}
				if(conn != null){
					conn.close();
				}
			}
		}

		return pollingStationList;
	}

	public static User getAssignedUserToIssue(int issueId) throws Exception{
		if(issueId > 0){
			ResultSet rs = null;
			PreparedStatement ps = null;
			Connection conn = null;

			try{
				String query = "SELECT u.* FROM psm.issue_assignment ia inner join security.user u on u.id=ia.user_id  where ia.issue_id=?";

				conn = DatabaseConnectionManager.getConnection();
				ps = conn.prepareStatement(query);
				ps.setInt(1, issueId);
				rs = ps.executeQuery(query);
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
			finally{
				if(rs != null ){
					rs.close();
				}
				if(ps != null ){
					ps.close();
				}
				if(conn != null ){
					conn.close();
				}
			}

		}
			return null;
	}

}
