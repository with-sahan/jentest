package com.moderndemocracy.dao;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.anaeko.error.AnaekoRuntimeException;
import com.anaeko.utils.jdbc.CacheableQuery;
import com.anaeko.utils.jdbc.CacheableUpdate;
import com.anaeko.utils.jdbc.ParameterDelegate;
import com.moderndemocracy.pojo.User;

/**
 * Custom User DAO class, which uses a custom UserExtractor to return additional
 * fields from the database.
 */

public class UsersDao {
	

	protected static final Logger logger = LogManager.getLogger(UsersDao.class);

	/********/
	/* SQL */
	/******/
	private static final String SQL_INSERT_USER = "INSERT into USERS (council_id, login_name, secret, age, birthday, gender) values (?,?,?,?,?,?)";

	private static final String SQL_UPDATE_PLATFORM_AND_BUILD_NUMBER = "update users set client_platform=?, client_build_number=? where id=?";
	
	private static final String SQL_UPDATE_STATION_ID = "update users set station_id=? where id=?";
	
	private static final String SQL_SELECT_USER_BY_ID = UsersExtractor.SQL + "WHERE U.id = ? " + "LIMIT 1";	
	private static final String SQL_SELECT_USER_BY_EMAIL = UsersExtractor.SQL + "WHERE U.login_name = ? " + "LIMIT 1";
	private static final String SQL_SELECT_USER_BY_FACEBOOKID = UsersExtractor.SQL + "WHERE U.facebook_id = ? " + "LIMIT 1";
	
	
	private DataSource pool;

	/**
	 * Constructor.
	 * 
	 * @param pool
	 *            The datasource.
	 */
	public UsersDao(DataSource pool) {
		if (null == pool)
			throw new AnaekoRuntimeException(
					"Cannot create a DAO without a database connection");
		this.pool = pool;
	}

	
	/**
	 * Get User by Id
	 * 
	 * @param userId
	 * @return
	 * @throws SQLException
	 */
	public User getById(final int id) throws SQLException {
		CacheableQuery<User> query = new CacheableQuery<User>(pool);

		List<User> found = query.execute(SQL_SELECT_USER_BY_ID,
				new UsersExtractor(), new ParameterDelegate() {
					@Override
					public void setParameters(PreparedStatement statement)
							throws SQLException {
						statement.setInt(1, id);
					}
				});

		if (found.isEmpty()) {
			return null;
		} else {
			return found.get(0);
		}
	}
	
	/**
	 * Get User by Email
	 * 
	 * @param email
	 * @return
	 * @throws SQLException
	 */
	public User getByEmail(final String email) throws SQLException {
		CacheableQuery<User> query = new CacheableQuery<User>(pool);

		List<User> found = query.execute(SQL_SELECT_USER_BY_EMAIL,
				new UsersExtractor(), new ParameterDelegate() {
					@Override
					public void setParameters(PreparedStatement statement)
							throws SQLException {
						statement.setString(1, email);
					}
				});

		if (found.isEmpty()) {
			return null;
		} else {
			return found.get(0);
		}
	}
	
	/**
	 * Get User by FacebookId
	 * 
	 * @param facebookId
	 * @return
	 * @throws SQLException
	 */
	public User getByFacebookId(final String facebookId) throws SQLException {
		CacheableQuery<User> query = new CacheableQuery<User>(pool);

		List<User> found = query.execute(SQL_SELECT_USER_BY_FACEBOOKID,
				new UsersExtractor(), new ParameterDelegate() {
					@Override
					public void setParameters(PreparedStatement statement)
							throws SQLException {
						statement.setString(1, facebookId);
					}
				});

		if (found.isEmpty()) {
			return null;
		} else {
			return found.get(0);
		}
	}
	
	public boolean updatePlatformAndBuildNumber(
			final Integer userId,
			final String platform,
			final String buildNumber) throws SQLException {
		
		CacheableUpdate createQuery = new CacheableUpdate(pool);
		
		// Params for SQL
		SetUpdatePlatformAndBuildNumberParams params = new SetUpdatePlatformAndBuildNumberParams( userId, platform, buildNumber );
		
		logger.debug("About to perform UpdatePlatformAndBuildNumber users");
		int effected = createQuery.execute( SQL_UPDATE_PLATFORM_AND_BUILD_NUMBER, params );
		
		if( effected > 0 ) {
			logger.debug("UpdatePlatformAndBuildNumber success");
			return true;
		} else {
			logger.error("UpdatePlatformAndBuildNumber fail");
			return false;
		}
	}
	
	private final class SetUpdatePlatformAndBuildNumberParams implements ParameterDelegate {
		
		Integer userId;
		String  platform;
		String  buildNumber;
        
        public SetUpdatePlatformAndBuildNumberParams(Integer userId, String platform, String buildNumber) {
        	this.userId = userId;
        	this.platform = platform;
        	this.buildNumber = buildNumber;
        }

        @Override
        public void setParameters(PreparedStatement statement) throws SQLException {
        	statement.setString(1, platform);
        	statement.setString(2, buildNumber);     
            statement.setInt(3, userId);
        }
    }
	
	public boolean updateStationId(
			final Integer userId,
			final Integer stationId) throws SQLException {
		
		CacheableUpdate createQuery = new CacheableUpdate(pool);
		
		// Params for SQL
		SetUpdateStationIdParams params = new SetUpdateStationIdParams( userId, stationId );
		
		logger.debug("About to perform UpdateStationId on users");
		int effected = createQuery.execute( SQL_UPDATE_STATION_ID, params );
		
		if( effected > 0 ) {
			logger.debug("UpdateStationId success");
			return true;
		} else {
			logger.error("UpdateStationId fail");
			return false;
		}
	}
	
	private final class SetUpdateStationIdParams implements ParameterDelegate {
		
		Integer userId;
		Integer stationId;
        
        public SetUpdateStationIdParams(Integer userId, Integer stationId) {
        	this.userId = userId;
        	this.stationId = stationId;
        }

        @Override
        public void setParameters(PreparedStatement statement) throws SQLException {
        	statement.setInt(1, stationId);    
            statement.setInt(2, userId);
        }
    }
	
	
	public boolean insert( 
			final Integer councilId,
			final String loginName,
			final String password,
			final Integer age,
			final String birthday,
			final String gender ) throws SQLException {

		CacheableUpdate createQuery = new CacheableUpdate(pool);
		
		// Params for SQL
		SetUserInsertParams params = new SetUserInsertParams( councilId, loginName, password, age, birthday, gender );
		
		logger.debug("About to insert progress update");
		int effected = createQuery.execute( SQL_INSERT_USER, params );
		
		if( effected > 0 ) {
			logger.debug("Insert success");
			return true;
		} else {
			logger.error("Insert fail");
			return false;
		}
	}
	
	private final class SetUserInsertParams implements ParameterDelegate {
		
		Integer councilId;
		String  loginName;
		String  password;
        Integer age;
        String  birthday;
        String  gender;
        
        public SetUserInsertParams(Integer councilId, String loginName, String password, Integer age, String birthday, String gender) {
        	this.councilId = councilId;
        	this.loginName = loginName;
        	this.password = password;
            this.age = age;
            this.birthday = birthday;
            this.gender = gender;
        }

        @Override
        public void setParameters(PreparedStatement statement) throws SQLException {
        	statement.setInt(1, councilId);
        	statement.setString(2, loginName);     
            statement.setString(3, password);
            statement.setInt(4, age);
            statement.setString(5, birthday);
            statement.setString(6, gender);
        }
    }

}
