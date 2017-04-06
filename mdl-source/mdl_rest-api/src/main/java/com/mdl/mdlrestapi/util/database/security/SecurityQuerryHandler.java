package com.mdl.mdlrestapi.util.database.security;

import java.sql.Array;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import com.mdl.mdlrestapi.util.database.DatabaseConnectionManager;
import com.mdl.mdlrestapi.util.database.security.entities.Role;
import com.mdl.mdlrestapi.util.database.security.entities.User;
import com.mdl.mdlrestapi.util.database.subscription.SubscriptionQuerryHandler;

public class SecurityQuerryHandler {
	private static final Logger logger = Logger.getLogger(SecurityQuerryHandler.class);

	/**
	 * @param token
	 * @return
	 * @throws SQLException
	 */
	public static int getUserId(String token,int orgid) throws Exception {
		int userid = -1;
		String[] splited = token.split("\\|");
		String username = splited[0];
		if (username != null && username.length() > 0) {
			String query = "SELECT id FROM security.user where username='"+username+"' and organization_id="+orgid;
			ResultSet rs = null;
			Statement statement = null;
			Connection conn = null;
			try {
				conn = DatabaseConnectionManager.getConnection();
				statement = conn.createStatement();
				rs = statement.executeQuery(query);
				while (rs.next()) {
					userid = rs.getInt("id");
				}
				//e.printStackTrace();
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
		return userid;
	}

	public static boolean isPSIUser(String token) throws Exception{
		String[] splited = token.split("\\|");
		String username = splited[0];
		int orgId = SubscriptionQuerryHandler.getOrganizationId(token);
		int userRoeId = SecurityQuerryHandler.getRoleIdByUserNameAndOrganizationId(username, orgId);
		int pollingStationInspectorRoleId = SecurityQuerryHandler.getPollingStationInspectorRoleIdByOrganizationId(orgId);

		if (userRoeId == pollingStationInspectorRoleId) {
			return true;
		}
		return false;
	}

	public static int getRoleIdByUserNameAndOrganizationId(String userName, int organizationId) throws Exception {
		int roleId = -1;
		if (userName != null && userName.length() > 0 && organizationId > 0) {
			String query = "SELECT ur.role_id FROM security.user as u inner join security.user_role as ur on u.id=ur.user_id and u.organization_id=ur.organization_id where u.username=? and u.organization_id=?";
			ResultSet rs = null;
			PreparedStatement statement = null;
			Connection conn = null;
			try {
				conn = DatabaseConnectionManager.getConnection();
				statement = conn.prepareStatement(query);
				statement.setString(1, userName);
				statement.setInt(2, organizationId);
				rs = statement.executeQuery();
				while (rs.next()) {
					roleId = rs.getInt("role_id");
				}
			} finally {
				if (rs != null) {
					rs.close();
				}
				if (statement != null) {
					statement.close();
				}
				if (conn != null) {
					conn.close();
				}
			}
		}
		return roleId;
	}
public static List<User> getUsersByUserId(String userIdList, int orgId) throws Exception{
	List<User> users = new ArrayList<User>();
	if(orgId > 0 && userIdList != null && userIdList.length() > 0){
		ResultSet rs = null;
		PreparedStatement ps = null;
		Connection conn = null;
		String query = "SELECT * FROM security.user  where FIND_IN_SET(id, ?) and organization_id=?";
		try{
			conn= DatabaseConnectionManager.getConnection();
			ps = conn.prepareStatement(query);
			ps.setString(1, userIdList);
			ps.setInt(2, orgId);

			rs = ps.executeQuery();
			while(rs.next()){
				User user = new User();
				user.setId(rs.getInt("id"));
				user.setFirstName(rs.getString("firstName"));
				user.setLastName(rs.getString("lastName"));
				user.setEmail("email");
				user.setOrganizationId(rs.getInt("organization_id"));
				users.add(user);
			}
		}finally{
			if(rs != null){
				rs.close();
			}
			if(ps != null){
				ps.close();
			}
			if(conn != null){
				conn.close();
			}
		}
	}

	return users;
}

	public static List<User> getUsersByRoles(String roleList, int orgId) throws Exception {
		List<User> users = new ArrayList<User>();
		if (orgId > 0 && roleList != null && roleList.length() > 0) {
			ResultSet rs = null;
			PreparedStatement ps = null;
			Connection conn = null;
			String query = "SELECT u.* FROM security.role  r inner join security.user_role ur on ur.role_id = r.id inner join security.user u on u.id= ur.user_id where FIND_IN_SET(r.name, ?) and r.organization_id=?";
			try{
				conn= DatabaseConnectionManager.getConnection();
				ps = conn.prepareStatement(query);
				ps.setString(1, roleList);
				ps.setInt(2, orgId);

				rs = ps.executeQuery();
				while(rs.next()){
					User user = new User();
					user.setId(rs.getInt("id"));
					user.setFirstName(rs.getString("firstName"));
					user.setLastName(rs.getString("lastName"));
					user.setEmail("email");
					user.setOrganizationId(rs.getInt("organization_id"));
					users.add(user);
				}
			}finally{
				if(rs != null){
					rs.close();
				}
				if(ps != null){
					ps.close();
				}
				if(conn != null){
					conn.close();
				}
			}
		}

		return users;
	}


	public static int getPollingStationInspectorRoleIdByOrganizationId(int orgId) throws Exception{
		int roleId = -1;
		if(orgId > 0){
			String query = "SELECT id FROM security.role where name='Polling Station Inspector' and organization_id="+orgId;
			ResultSet rs = null;
			Statement statement = null;
			Connection conn = null;
			try {
				conn = DatabaseConnectionManager.getConnection();
				statement = conn.createStatement();
				rs = statement.executeQuery(query);
				while (rs.next()) {
					roleId = rs.getInt("id");
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
		return roleId;
	}

	/**
	 * If List<String> roleList is empty or null, which is giving all roles related to that organization as the output
	 * If List<String> roleList is not empty or not null, which is giving all roles related to that organization and roleList as the output
	 * @param orgId
	 * @return
	 * @throws Exception
	 */
	public static List<Role> getAllRolesByOrganizationId(int orgId, String [] roleList) throws Exception{
		List<Role> roles = new ArrayList<Role>();
		if(orgId > 0){
			String query = "";

			if (roleList == null || roleList.length <= 0){
				query = "SELECT * FROM security.role where organization_id=?";
			} else {
				int lengthOfRoleList = roleList.length;
				query = "SELECT * FROM security.role where organization_id=? and name in (";

				for (int i=0; i<lengthOfRoleList; i++) {
					if (i==(lengthOfRoleList-1)) {
						query = query.concat("?)");
					} else {
						query = query.concat("?,");
					}
				}
			}

			ResultSet rs = null;
			PreparedStatement statement = null;
			Connection conn = null;
			try {
				conn = DatabaseConnectionManager.getConnection();
				statement = conn.prepareStatement(query);
				statement.setInt(1, orgId);

				for (int i=0; i<roleList.length; i++) {
					statement.setString(i+2, roleList[i]);
				}

				rs = statement.executeQuery();
				while (rs.next()) {
					Role role = new Role();
					role.setId(rs.getInt("id"));
					role.setName(rs.getString("name"));
					role.setOrganizationId(rs.getInt("organization_id"));
					roles.add(role);
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
		return roles;
	}

	/**
	 * If List<String> userNames is empty or null, which is giving all users related to that organization as the output
	 * If List<String> userNames is not empty or not null, which is giving all users related to that organization and userNames as the output
	 * @param orgId
	 * @return
	 * @throws Exception
	 */
	public static List<User> getUsersByUserNames(int orgId, List<String> userNames) throws Exception{
		List<User> users = new ArrayList<User>();
		if(orgId > 0){
			String query = "";

			if (userNames == null || userNames.isEmpty()) {
				query = "SELECT * FROM security.user where organization_id=?";
			} else {
				int lengthOfUserNames = userNames.size();
				query = "SELECT * FROM security.user where organization_id=? and username in (";

				for (int i=0; i<lengthOfUserNames; i++) {
					if (i==(lengthOfUserNames-1)) {
						query = query.concat("?)");
					} else {
						query = query.concat("?,");
					}
				}
			}

			ResultSet rs = null;
			PreparedStatement statement = null;
			Connection conn = null;
			try {
				conn = DatabaseConnectionManager.getConnection();
				statement = conn.prepareStatement(query);
				statement.setInt(1, orgId);

				for (int i=0; i<userNames.size(); i++) {
					statement.setString(i+2, userNames.get(i));
				}

				rs = statement.executeQuery();
				while (rs.next()) {
					User user = new User();
					user.setId(rs.getInt("id"));
					user.setFirstName(rs.getString("firstName"));
					user.setLastName(rs.getString("lastName"));
					user.setEmail("email");
					user.setOrganizationId(rs.getInt("organization_id"));
					users.add(user);
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
		return users;

	}
}
