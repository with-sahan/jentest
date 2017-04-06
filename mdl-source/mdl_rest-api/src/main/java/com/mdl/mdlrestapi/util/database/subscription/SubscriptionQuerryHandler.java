package com.mdl.mdlrestapi.util.database.subscription;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.apache.log4j.Logger;

import com.mdl.mdlrestapi.util.database.DatabaseConnectionManager;

public class SubscriptionQuerryHandler {
	private static final Logger logger = Logger.getLogger(SubscriptionQuerryHandler.class);
	/**
	 * Querry subscription database , organization table by given token
	 * @param token
	 * @return
	 * @throws SQLException
	 */
	public static int getOrganizationId(String token) throws Exception {
		int orgId = -1;
		String[] splited = token.split("\\|");
		String orgname = splited[1];
		if (orgname != null && orgname.length() > 0) {
			String query = "SELECT id FROM subscription.organization where code='" + orgname + "'";
			ResultSet rs = null;
			Statement statement = null;
			Connection conn = null;
			try {
				conn = DatabaseConnectionManager.getConnection();
				statement = conn.createStatement();
				rs = statement.executeQuery(query);
				while (rs.next()) {
					orgId = rs.getInt("id");
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
		return orgId;
	}
}
