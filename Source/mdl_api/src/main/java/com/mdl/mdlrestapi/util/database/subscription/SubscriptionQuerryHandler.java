package com.mdl.mdlrestapi.util.database.subscription;

import java.sql.*;

import com.mdl.mdlrestapi.psm.exception.MDLDBException;
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
	public static int getOrganizationId(String token) throws MDLDBException {
		int orgId = -1;
		String[] splited = token.split("\\|");
		String orgname = splited[1];
		if (orgname != null && orgname.length() > 0) {
			String query = "SELECT id FROM subscription.organization where code=?";
			try (
				Connection conn = DatabaseConnectionManager.getConnection();
				PreparedStatement preparedStatement = conn.prepareStatement(query)){
				preparedStatement.setString(1, orgname);
				try(ResultSet rs = preparedStatement.executeQuery()){
					while (rs.next()) {
						orgId = rs.getInt("id");
					}
				}
			} catch(Exception e) {
				throw new MDLDBException("DB Exception " + e.getMessage());
			}
		}
		return orgId;
	}
}
