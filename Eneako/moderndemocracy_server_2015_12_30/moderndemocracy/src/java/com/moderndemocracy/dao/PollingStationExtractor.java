package com.moderndemocracy.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.anaeko.utils.jdbc.ResultExtractor;
import com.moderndemocracy.pojo.PollingStation;

public class PollingStationExtractor implements ResultExtractor<PollingStation> {

//	public static final String SQL =
//			"select PS.id, PS.name"
//			+ " FROM polling_station PS";

	public static final String SQL =
			"select PS.id, PS.name, PP.name as placeName, PD.name districtName, W.name as wardName, "
			+ "C.title as councilName, SS.status as status"
			+ " FROM polling_station PS, polling_place PP, polling_district PD, ward W, council C, station_setup_status SS";


	Logger logger = LogManager.getLogger(PollingStationExtractor.class);

	/*
	 * (non-Javadoc)
	 *
	 * @see com.anaeko.utils.jdbc.ResultExtractor#extract(java.sql.ResultSet,
	 * int)
	 */
	@Override
	public PollingStation extract(ResultSet data, int index) throws SQLException {

		PollingStation extracted = new PollingStation();
		int i=1;

		extracted.setId(data.getInt(i++));
		extracted.setName(data.getString(i++));

		extracted.setPlaceName(data.getString(i++));
		extracted.setDistrictName(data.getString(i++));
		extracted.setWardName(data.getString(i++));
		extracted.setCouncilName(data.getString(i++));
		extracted.setStatus(data.getBoolean(i++));

		return extracted;
	}

}
