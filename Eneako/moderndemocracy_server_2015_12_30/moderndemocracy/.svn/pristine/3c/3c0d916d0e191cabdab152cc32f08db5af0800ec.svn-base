package com.moderndemocracy.dao;

import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.anaeko.error.AnaekoRuntimeException;
import com.anaeko.utils.jdbc.CacheableUpdate;
import com.anaeko.utils.jdbc.ParameterDelegate;


public class TrackRegisterDao {
	

	protected static final Logger logger = LogManager.getLogger(TrackRegisterDao.class);

	/********/
	/* SQL */
	/******/
	private static final String SQL_INSERT_TRACK_REGISTER= "INSERT into TRACK_REGISTER (user_id,council_id) values (?,?)";

	private DataSource pool;

	/**
	 * Constructor.
	 * 
	 * @param pool
	 *            The datasource.
	 */
	public TrackRegisterDao(DataSource pool) {
		if (null == pool)
			throw new AnaekoRuntimeException(
					"Cannot create a DAO without a database connection");
		this.pool = pool;
	}

	
	public boolean insert( 
			final Integer userId,
			final Integer councilId) throws SQLException {

		CacheableUpdate createQuery = new CacheableUpdate(pool);
		
		// Params for SQL
		SetTrackRegisterInsertParams params = new SetTrackRegisterInsertParams( userId, councilId );
		
		logger.debug("About to insert track_register");
		int effected = createQuery.execute( SQL_INSERT_TRACK_REGISTER, params );
		
		if( effected > 0 ) {
			logger.debug("Track Register insertion success");
			return true;
		} else {
			logger.error("Track Register insertion failed");
			return false;
		}
	}
	
	private final class SetTrackRegisterInsertParams implements ParameterDelegate {
		
		Integer userId;
		Integer councilId;
        
        public SetTrackRegisterInsertParams(Integer userId, Integer councilId) {
        	this.userId = userId;
        	this.councilId = councilId;
        }

        @Override
        public void setParameters(PreparedStatement statement) throws SQLException {
        	statement.setInt(1, userId);
        	statement.setInt(2, councilId);
        }
    }

}
