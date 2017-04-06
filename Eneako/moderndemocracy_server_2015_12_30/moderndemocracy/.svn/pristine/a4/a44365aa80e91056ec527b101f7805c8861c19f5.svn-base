package com.moderndemocracy.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.anaeko.utils.jdbc.ResultExtractor;
import com.moderndemocracy.pojo.Notification;

public class NotificationExtractor implements ResultExtractor<Notification> {

	public static final String SQL =
			"SELECT distinct N.id, N.text, N.station_id, N.created_on,N.url "
			+ " FROM notifications N ";
	
	
	Logger logger = LogManager.getLogger(NotificationExtractor.class);

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.anaeko.utils.jdbc.ResultExtractor#extract(java.sql.ResultSet,
	 * int)
	 */
	@Override
	public Notification extract(ResultSet data, int index) throws SQLException {

		Notification extracted = new Notification();
		int i=1;
		
		extracted.setNotificationId(data.getInt(i++));
		extracted.setText(data.getString(i++));
		extracted.setStationId(data.getInt(i++));
		
		extracted.setCreatedOn(data.getTimestamp(i++));
        extracted.setUrl(data.getString(i++));

		return extracted;
	}

}
