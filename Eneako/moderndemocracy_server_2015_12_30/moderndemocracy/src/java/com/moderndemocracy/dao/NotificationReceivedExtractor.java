package com.moderndemocracy.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.anaeko.utils.jdbc.ResultExtractor;
import com.moderndemocracy.pojo.NotificationReceived;

public class NotificationReceivedExtractor implements ResultExtractor<NotificationReceived> {

	public static final String SQL =
			"SELECT distinct NR.id, NR.notification_id, NR.station_id, NR.user_id, NR.status "
			+ " FROM notifications_received NR ";
	
	
	Logger logger = LogManager.getLogger(NotificationReceivedExtractor.class);

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.anaeko.utils.jdbc.ResultExtractor#extract(java.sql.ResultSet,
	 * int)
	 */
	@Override
	public NotificationReceived extract(ResultSet data, int index) throws SQLException {

		NotificationReceived extracted = new NotificationReceived();
		int i=1;
		
		extracted.setId(data.getInt(i++));
		extracted.setNotificationId(data.getInt(i++));
		extracted.setStationId(data.getInt(i++));
		extracted.setUserId(data.getInt(i++));
		extracted.setStatus(data.getInt(i++));

		return extracted;
	}

}
