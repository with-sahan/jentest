package com.moderndemocracy.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.anaeko.utils.jdbc.ResultExtractor;
import com.moderndemocracy.pojo.NotificationList;

public class NotificationListExtractor implements ResultExtractor<NotificationList> {

	public static final String SQL = "SELECT N.id, N.text, N.station_id, N.created_on,N.url, "
									+ "PS.name, PP.name, PD.name, W.name "
									+ " FROM notifications N, polling_station PS, polling_place PP, polling_district PD, ward W ";

	Logger logger = LogManager.getLogger(NotificationListExtractor.class);

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.anaeko.utils.jdbc.ResultExtractor#extract(java.sql.ResultSet,
	 * int)
	 */
	@Override
	public NotificationList extract(ResultSet data, int index) throws SQLException {

		NotificationList extracted = new NotificationList();
		int i=1;
		
		extracted.setId(data.getInt(i++));
		extracted.setText(data.getString(i++));
		extracted.setStationId(data.getInt(i++));
		extracted.setCreatedOn(data.getTimestamp(i++));
                extracted.setUrl(data.getString(i++));
		extracted.setStationName(data.getString(i++));
		extracted.setPlaceName(data.getString(i++));
		extracted.setDistrictName(data.getString(i++));
		extracted.setWardName(data.getString(i++));
                
		
		return extracted;
	}

}
