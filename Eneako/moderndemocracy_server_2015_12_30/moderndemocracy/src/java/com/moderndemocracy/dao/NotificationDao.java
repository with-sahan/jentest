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
import com.moderndemocracy.pojo.Notification;

public class NotificationDao {
	

	protected static final Logger logger = LogManager.getLogger(NotificationDao.class);


	/********/
	/* SQL */
	/******/
	private static final String SQL_INSERT_NEW_NOTIFICATION = 
			"INSERT into notifications (user_id, council_id, station_id, text,url) "
			+ " VALUES (?,?,?,?,?)";

	private static final String SQL_SELECT_NOTIFICATION_BY_STATION_ID = 
			"SELECT N.id, N.text, N.station_id, N.created_on, N.url "
			+ " FROM notifications N "
			+ " WHERE (station_id=? or station_id=0) and "
			+ " council_id=? and "
			+ " id NOT IN "
			+ " (SELECT R.notification_id "
			+ " FROM notifications_received R "
			+ " WHERE (R.station_id=?))";
	
	private static final String SQL_INSERT_NOTIFICATION_RECEIVED =
			"INSERT into notifications_received (notification_id, station_id, user_id) "
			+ "VALUES (?,?,?) ";
	
	private static final String SQL_UPDATE_NOTIFICATION_STATUS = 
			"UPDATE notifications_received set status=? "
			+ "where notification_id=? and station_id=? ";
	

	private DataSource pool;

	/**
	 * Constructor.
	 * 
	 * @param pool
	 *            The datasource.
	 */
	public NotificationDao(DataSource pool) {
		if (null == pool)
			throw new AnaekoRuntimeException("Cannot create a DAO without a database connection");
		this.pool = pool;
	}

	/**
	 * Insert New Notification
	 * 
	 * @return
	 * @throws SQLException
	 */
	public boolean insert( DataSource source, int userId, int councilId, int toStationId, String text, String url ) 
			throws SQLException {

		CacheableUpdate createQuery = new CacheableUpdate(pool);
		
		// Params for SQL
		SetNotificationInsertParams params = new SetNotificationInsertParams( userId, councilId, toStationId, text,url );
		
		logger.debug("About to insert new notification");
		int effected = createQuery.execute( SQL_INSERT_NEW_NOTIFICATION, params );
		
		if( effected > 0 ) {
			logger.debug("Successfully inserted new notification");
			return true;
		} else {
			logger.error("Failed to insert new notification");
			return false;
		}
	}
	
	
	/**
	 * Get Notification By StationId
	 * 
	 * @param stationId
	 * @return
	 * @throws SQLException
	 */
	public List<Notification> getByStationId(final int stationId, final int userId, final int councilId) throws SQLException {
		
		CacheableQuery<Notification> query = new CacheableQuery<Notification>(pool);
		
		logger.debug("NotificationDao.getByStationId - stationId = " + stationId + " userId = " + userId);
	
		List<Notification> found = query.execute(SQL_SELECT_NOTIFICATION_BY_STATION_ID,
				
				new NotificationExtractor(), new ParameterDelegate() {
					@Override
					public void setParameters(PreparedStatement statement)
							throws SQLException {
						statement.setInt(1, stationId);
						statement.setInt(2, councilId);
						statement.setInt(3, stationId);
						logger.debug("NotificationDao.getByStationId SQL: " + statement.toString());
					}
				});
		
		if (found.isEmpty()) {
			logger.debug("NotificationDao.getByStationId - empty");
			return found;
		} else {
			logger.debug("NotificationDao.getByStationId - " + found.size());
			return found;
		}
	}
	
	public boolean updateNotificationReceived( DataSource source, int notificationId, int stationId, int userId ) 
			throws SQLException {

		CacheableUpdate createQuery = new CacheableUpdate(pool);
		
		// Params for SQL
		SetNotificationReceivedUpdateParams params = new SetNotificationReceivedUpdateParams( notificationId, stationId, userId );
		
		logger.debug("About to update notification received");
		int effected = createQuery.execute( SQL_INSERT_NOTIFICATION_RECEIVED, params );
		
		if( effected > 0 ) {
			logger.debug("Successfully updated notification received");
			return true;
		} else {
			logger.error("Failed to updated notification received");
			return false;
		}
	}
	
	public boolean updateStatus( DataSource source, Integer notificationId, Integer stationId, Integer  status ) 
			throws SQLException {

		CacheableUpdate createQuery = new CacheableUpdate(pool);
		
		// Params for SQL
		SetNotificationUpdateStatusParams params = new SetNotificationUpdateStatusParams( notificationId, stationId, status );
		
		logger.debug("About to update Notification "+notificationId+" status - params = "+status);
		int effected = createQuery.execute( SQL_UPDATE_NOTIFICATION_STATUS, params );
		
		if( effected > 0 ) {
			logger.debug("Successfully updated notification "+notificationId+" status to "+status);
			return true;
		} else {
			logger.error("Failed to update notification "+notificationId+" status to "+status);
			return false;
		}
	}
	
	
	
	/***************/
	/* SET PARAMS */
	/*************/
	
	private final class SetNotificationInsertParams implements ParameterDelegate {
		
		int userId;
		int councilId;
		int toStationId;
		String text;
        String url;
        
        public SetNotificationInsertParams(int userId, int councilId, int toStationId, String text, String url) {
        	this.userId= userId;
        	this.councilId=councilId;
        	this.toStationId=toStationId;
        	this.text = text;
            this.url = url;
        }

        @Override
        public void setParameters(PreparedStatement statement) throws SQLException {
        	statement.setInt(1, userId);
        	statement.setInt(2, councilId);
        	statement.setInt(3, toStationId);
            statement.setString(4, text);
            statement.setString(5, url);
        }
    }
	
	private final class SetNotificationReceivedUpdateParams implements ParameterDelegate {
		
		int notificationId;
		int stationId;
		int userId;
        
        public SetNotificationReceivedUpdateParams(int notificationId, int stationId, int userId) {
        	this.notificationId = notificationId;
        	this.stationId=stationId;
        	this.userId=userId;
        }

        @Override
        public void setParameters(PreparedStatement statement) throws SQLException {
        	statement.setInt(1, notificationId);
            statement.setInt(2, stationId);
            statement.setInt(3, userId);
            logger.debug("SetNotificationREceievedUpdate statement: " + statement.toString());
        }
    }
	
	private final class SetNotificationUpdateStatusParams implements ParameterDelegate {
		
		int notificationId;
		int stationId;
		int status;
        
        public SetNotificationUpdateStatusParams(int notificationId, int stationId, int status) {
        	this.notificationId = notificationId;
        	this.stationId=stationId;
        	this.status=status;
        }

        @Override
        public void setParameters(PreparedStatement statement) throws SQLException {
        	statement.setInt(1, status);
        	statement.setInt(2, notificationId);
            statement.setInt(3, stationId);
            logger.debug("SetNotificationUpdateStatus statement: " + statement.toString());
        }
    }
	
}
