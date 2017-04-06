package com.moderndemocracy.dao;

import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.anaeko.error.AnaekoRuntimeException;
import com.anaeko.utils.jdbc.CacheableUpdate;
import com.anaeko.utils.jdbc.ParameterDelegate;

/**
 * Custom User DAO class, which uses a custom UserExtractor to return additional
 * fields from the database.
 */

public class TrackSocialNetworkDao {
	

	protected static final Logger logger = LogManager.getLogger(TrackSocialNetworkDao.class);

	/********/
	/* SQL */
	/******/
	private static final String SQL_INSERT_TRACK_SOCIALNETWORK = 
			"INSERT into TRACK_SOCIALNETWORK (user_id, council_id, social_network, feed, feed_id) values (?,?,?,?,?)";

	private DataSource pool;

	/**
	 * Constructor.
	 * 
	 * @param pool
	 *            The datasource.
	 */
	public TrackSocialNetworkDao(DataSource pool) {
		if (null == pool)
			throw new AnaekoRuntimeException(
					"Cannot create a DAO without a database connection");
		this.pool = pool;
	}

	
	public boolean insert( 
			final Integer userId,
			final Integer councilId,
			final String socialNetwork,
			final String feed,
			final Integer feedId) throws SQLException {

		CacheableUpdate createQuery = new CacheableUpdate(pool);
		
		// Params for SQL
		SetTrackSocialNetworkInsertParams params = new SetTrackSocialNetworkInsertParams( userId, councilId, socialNetwork, feed, feedId );
		
		logger.debug("About to insert track_socialnetwork");
		int effected = createQuery.execute( SQL_INSERT_TRACK_SOCIALNETWORK, params );
		
		if( effected > 0 ) {
			logger.debug("Track Social Network insertion success");
			return true;
		} else {
			logger.error("Track Social Network insertion failed");
			return false;
		}
	}
	
	private final class SetTrackSocialNetworkInsertParams implements ParameterDelegate {
		
		Integer userId;
		Integer councilId;
		String socialNetwork;
		String feed;
		Integer feedId;
        
        public SetTrackSocialNetworkInsertParams(Integer userId, Integer councilId, String socialNetwork, String feed, Integer feedId) {
        	this.userId = userId;
        	this.councilId = councilId;
        	this.socialNetwork = socialNetwork.toLowerCase();
        	this.feed = feed.toLowerCase().toLowerCase();
        	this.feedId = feedId;
        }

        @Override
        public void setParameters(PreparedStatement statement) throws SQLException {
        	statement.setInt(1, userId);
        	statement.setInt(2, councilId);
        	statement.setString(3, socialNetwork);
        	statement.setString(4, feed);
        	statement.setInt(5, feedId);
        }
    }

}
