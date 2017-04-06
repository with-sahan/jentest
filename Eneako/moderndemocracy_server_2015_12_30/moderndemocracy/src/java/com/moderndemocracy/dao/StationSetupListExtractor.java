package com.moderndemocracy.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.anaeko.utils.jdbc.ResultExtractor;
import com.moderndemocracy.pojo.StationSetupList;

public class StationSetupListExtractor implements ResultExtractor<StationSetupList> {

	public static final String SQL = "SELECT S.id, S.text, S.order_id, S.status "
									+ " FROM station_setup_list S ";

	Logger logger = LogManager.getLogger(StationSetupListExtractor.class);

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.anaeko.utils.jdbc.ResultExtractor#extract(java.sql.ResultSet,
	 * int)
	 */
	@Override
	public StationSetupList extract(ResultSet data, int index) throws SQLException {

		StationSetupList extracted = new StationSetupList();
		int i=1;
		extracted.setId(data.getInt(i++));
		extracted.setText(data.getString(i++));
		extracted.setOrderId(data.getInt(i++));
		extracted.setStatus(data.getBoolean(i++));

		return extracted;
	}

}
