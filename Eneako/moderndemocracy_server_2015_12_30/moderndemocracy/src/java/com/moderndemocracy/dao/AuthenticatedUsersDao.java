package com.moderndemocracy.dao;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import com.anaeko.service.dao.auth.DefaultUsers;
import com.anaeko.utils.jdbc.CacheableQuery;
import com.anaeko.utils.jdbc.ParameterDelegate;
import com.moderndemocracy.pojo.AuthenticatedUser;

/**
 * Custom User Auth DAO class, which uses a custom UserExtractor to return
 * additional fields from the database.
 */

public class AuthenticatedUsersDao extends DefaultUsers {

	/** User by ID query. */
	private static final String SQL_SELECT_USER_BY_ID = AuthenticatedUsersExtractor.SQL
			+ "WHERE U.id = ? and U.role_id=R.id and U.station_id=PS.id and PS.polling_place_id = PP.id and PP.polling_district_id = PD.id and PD.polling_ward_id = W.id and U.council_id=C.id "
			+ "LIMIT 1;";

	/** User by session ID query. */
	private static final String SQL_SELECT_USER_BY_SESSION = AuthenticatedUsersExtractor.SQL
			+ "WHERE U.id in (SELECT PS.user_id FROM sessions S WHERE S.id = ? LIMIT 1) and U.role_id=R.id and U.station_id=PS.id and PS.polling_place_id = PP.id and PP.polling_district_id = PD.id and PD.polling_ward_id = W.id and U.council_id=C.id "
			+ "LIMIT 1";

	/** User by login name query. */
	private static final String SQL_SELECT_USER_BY_NAME = AuthenticatedUsersExtractor.SQL
			+ "WHERE U.login_name = ? and U.role_id=R.id and U.station_id=PS.id and PS.polling_place_id = PP.id and PP.polling_district_id = PD.id and PD.polling_ward_id = W.id and U.council_id=C.id and U.status=1 " 
			+ "LIMIT 1";
	
	
//			+ "WHERE U.login_name = ? and "
//			+ "U.role_id=R.id and "
//			+ "U.station_id=PS.id and "
//			+ "U.council_id=C.id "
//			+ "LIMIT 1";

	/**
	 * Constructor.
	 * 
	 * @param pool
	 *            The datasource.
	 */
	public AuthenticatedUsersDao(DataSource pool) {
		super(pool);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.anaeko.service.dao.auth.Users#getByLoginName(java.lang.String)
	 */
	@Override
	public AuthenticatedUser getByLoginName(final String name)
			throws SQLException {
		CacheableQuery<AuthenticatedUser> query = new CacheableQuery<AuthenticatedUser>(
				dataSource);

		List<AuthenticatedUser> found = query.execute(SQL_SELECT_USER_BY_NAME,
				new AuthenticatedUsersExtractor(), new ParameterDelegate() {
					@Override
					public void setParameters(PreparedStatement statement)
							throws SQLException {
						statement.setString(1, name);
					}
				});

		if (found.isEmpty()) {
			return null;
		} else {
			return found.get(0);
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.anaeko.service.dao.auth.Users#getById(int)
	 */
	@Override
	public AuthenticatedUser getById(final int userId) throws SQLException {
		CacheableQuery<AuthenticatedUser> query = new CacheableQuery<AuthenticatedUser>(
				dataSource);

		List<AuthenticatedUser> found = query.execute(SQL_SELECT_USER_BY_ID,
				new AuthenticatedUsersExtractor(), new ParameterDelegate() {
					@Override
					public void setParameters(PreparedStatement statement)
							throws SQLException {
						statement.setInt(1, userId);
					}
				});

		if (found.isEmpty()) {
			return null;
		} else {
			return found.get(0);
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.anaeko.service.dao.auth.Users#getBySessionId(java.lang.String)
	 */
	@Override
	public AuthenticatedUser getBySessionId(final String sessionId)
			throws SQLException {
		CacheableQuery<AuthenticatedUser> query = new CacheableQuery<AuthenticatedUser>(
				dataSource);

		List<AuthenticatedUser> found = query.execute(
				SQL_SELECT_USER_BY_SESSION, new AuthenticatedUsersExtractor(),
				new ParameterDelegate() {
					@Override
					public void setParameters(PreparedStatement statement)
							throws SQLException {
						statement.setString(1, sessionId);
					}
				});

		if (found.isEmpty()) {
			return null;
		} else {
			return found.get(0);
		}
	}
}