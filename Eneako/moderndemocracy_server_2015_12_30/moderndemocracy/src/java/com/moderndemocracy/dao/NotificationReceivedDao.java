package com.moderndemocracy.dao;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.anaeko.error.AnaekoRuntimeException;
import com.anaeko.utils.jdbc.CacheableQuery;
import com.anaeko.utils.jdbc.ParameterDelegate;
import com.moderndemocracy.pojo.NotificationReceived;

public class NotificationReceivedDao {
	

	protected static final Logger logger = LogManager.getLogger(NotificationReceivedDao.class);

	/********/
	/* SQL */
	/******/
	private static final String SQL_SELECT_NOTIFICATION_RECEIVED_BY_STATION_ID = 
			"   SELECT id, notification_id, station_id, user_id, status " 
			+ " FROM notifications_received NR "
			+ " WHERE notification_id=? and station_id=? "
			+ " ORDER BY id ";
	

	private DataSource pool;

	/**
	 * Constructor.
	 * 
	 * @param pool
	 *            The datasource.
	 */
	public NotificationReceivedDao(DataSource pool) {
		if (null == pool)
			throw new AnaekoRuntimeException("Cannot create a DAO without a database connection");
		this.pool = pool;
	}
	
	
	public NotificationReceived getNotificationReceivedByNotificationIdAndStationId(final int notificationId, final int stationId) throws SQLException {
		
		CacheableQuery<NotificationReceived> query = new CacheableQuery<NotificationReceived>(pool);
		
		logger.debug("NotificationReceivedDao.getNotificationReceivedByStationId - stationId = " + stationId);
	
		List<NotificationReceived> found = query.execute(SQL_SELECT_NOTIFICATION_RECEIVED_BY_STATION_ID,
				
				new NotificationReceivedExtractor(), new ParameterDelegate() {
					@Override
					public void setParameters(PreparedStatement statement)
							throws SQLException {
						statement.setInt(1, notificationId);
						statement.setInt(2, stationId);
						logger.debug("getNotificationReceivedByNotificationIdAndStationId SQL: " + statement.toString());
					}
				});
		
		if (found.isEmpty()) {
			logger.debug("NotificationReceivedDao.getNotificationReceivedByNotificationIdAndStationId - empty");
			return null;
		} else {
			return found.get(0);
		}
	}
}
