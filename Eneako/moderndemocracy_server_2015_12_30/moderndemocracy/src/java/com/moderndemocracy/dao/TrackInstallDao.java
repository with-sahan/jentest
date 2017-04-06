package com.moderndemocracy.dao;

import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.anaeko.error.AnaekoRuntimeException;
import com.anaeko.utils.jdbc.CacheableUpdate;
import com.anaeko.utils.jdbc.ParameterDelegate;


public class TrackInstallDao {
	

	protected static final Logger logger = LogManager.getLogger(TrackInstallDao.class);

	/********/
	/* SQL */
	/******/
	private static final String SQL_INSERT_TRACK_INSTALL= "INSERT into TRACK_INSTALL (council_id,status) values (?,1)";

	private DataSource pool;

	/**
	 * Constructor.
	 * 
	 * @param pool
	 *            The datasource.
	 */
	public TrackInstallDao(DataSource pool) {
		if (null == pool)
			throw new AnaekoRuntimeException(
					"Cannot create a DAO without a database connection");
		this.pool = pool;
	}

	
	public boolean insert(final Integer councilId) throws SQLException {

		CacheableUpdate createQuery = new CacheableUpdate(pool);
		
		// Params for SQL
		SetTrackInstallInsertParams params = new SetTrackInstallInsertParams( councilId );
		
		logger.debug("About to insert track_install");
		int effected = createQuery.execute( SQL_INSERT_TRACK_INSTALL, params );
		
		if( effected > 0 ) {
			logger.debug("Track Install insertion success");
			return true;
		} else {
			logger.error("Track Install insertion failed");
			return false;
		}
	}
	
private final class SetTrackInstallInsertParams implements ParameterDelegate {
		
		Integer councilId;
        
        public SetTrackInstallInsertParams(Integer councilId) {
        	this.councilId = councilId;
        }

        @Override
        public void setParameters(PreparedStatement statement) throws SQLException {
        	statement.setInt(1, councilId);
        }
    }

}
