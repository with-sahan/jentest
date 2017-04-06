package com.moderndemocracy.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.anaeko.utils.jdbc.ResultExtractor;
import com.moderndemocracy.pojo.Place;

public class PlaceExtractor implements ResultExtractor<Place> {

	public static final String SQL =
			"select PP.id, PP.name, PP.polling_district_id "
			+ " FROM polling_place PP ";
	
	
	Logger logger = LogManager.getLogger(PlaceExtractor.class);

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.anaeko.utils.jdbc.ResultExtractor#extract(java.sql.ResultSet,
	 * int)
	 */
	@Override
	public Place extract(ResultSet data, int index) throws SQLException {

		Place extracted = new Place();
		int i=1;
		
		extracted.setId(data.getInt(i++));
		extracted.setPlaceName(data.getString(i++));
		extracted.setDistrictId(data.getInt(i++));
		
		return extracted;
	}

}
