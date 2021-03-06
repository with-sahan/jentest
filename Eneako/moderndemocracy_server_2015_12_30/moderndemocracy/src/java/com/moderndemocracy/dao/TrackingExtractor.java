package com.moderndemocracy.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.anaeko.utils.jdbc.ResultExtractor;
import com.moderndemocracy.pojo.Tracking;

public class TrackingExtractor implements ResultExtractor<Tracking> {

	public static final String SQL =
			"SELECT S.name as stationName, W.name as wardName, T.lat, T.lng, T.status, T.created_on, T.updated_on, S.dispatch_time as dispatchTime, S.deliver_time as deliverTime, S.eta as eta, S.ballot_box_no "
			+ " FROM tracking T, polling_station S, polling_place PP, polling_district PD, ward W ";
	
	
	Logger logger = LogManager.getLogger(TrackingExtractor.class);

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.anaeko.utils.jdbc.ResultExtractor#extract(java.sql.ResultSet,
	 * int)
	 */
	@Override
	public Tracking extract(ResultSet data, int index) throws SQLException {

		Tracking extracted = new Tracking();
		int i=1;
		
		extracted.setStation(data.getString(i++));
		extracted.setWard(data.getString(i++));
		extracted.setLat(data.getDouble(i++));
		extracted.setLng(data.getDouble(i++));
		extracted.setStatus(data.getInt(i++));
		extracted.setCreatedOn(data.getTimestamp(i++));
		extracted.setUpdatedOn(data.getTimestamp(i++));
		extracted.setDispatchTime(data.getTimestamp(i++));
		extracted.setDeliverTime(data.getTimestamp(i++));
		extracted.setEta(data.getTimestamp(i++));

		extracted.setBallotBoxNo(data.getString(i++));

		return extracted;
	}

}
