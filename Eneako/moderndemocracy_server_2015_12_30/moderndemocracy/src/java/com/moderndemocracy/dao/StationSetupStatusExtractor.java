package com.moderndemocracy.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.anaeko.utils.jdbc.ResultExtractor;
import com.moderndemocracy.pojo.StationSetupStatus;

public class StationSetupStatusExtractor implements ResultExtractor<StationSetupStatus> {

	public static final String SQL = "SELECT SSS.id, SSL.text, SSL.order_id, SSS.status, SSS.station_setup_list_id"
									+ " FROM station_setup_status SSS, station_setup_list SSL ";

	Logger logger = LogManager.getLogger(StationSetupStatusExtractor.class);

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.anaeko.utils.jdbc.ResultExtractor#extract(java.sql.ResultSet,
	 * int)
	 */
	@Override
	public StationSetupStatus extract(ResultSet data, int index) throws SQLException {

		StationSetupStatus extracted = new StationSetupStatus();
		int i=1;
		
		extracted.setId(data.getInt(i++));
		extracted.setText(data.getString(i++));
		extracted.setOrderId(data.getInt(i++));
		extracted.setStatus(data.getBoolean(i++));
		extracted.setStationSetupListId(data.getInt(i++));

		return extracted;
	}

}
