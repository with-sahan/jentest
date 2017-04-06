package com.moderndemocracy.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.anaeko.utils.jdbc.ResultExtractor;
import com.moderndemocracy.pojo.District;

public class DistrictExtractor implements ResultExtractor<District> {

	public static final String SQL =
			"select PD.id, PD.name, PD.polling_ward_id "
			+ " FROM polling_district PD ";
	
	
	Logger logger = LogManager.getLogger(DistrictExtractor.class);

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.anaeko.utils.jdbc.ResultExtractor#extract(java.sql.ResultSet,
	 * int)
	 */
	@Override
	public District extract(ResultSet data, int index) throws SQLException {

		District extracted = new District();
		int i=1;
		
		extracted.setDistrictId(data.getInt(i++));
		extracted.setDistrictName(data.getString(i++));
		extracted.setWardId(data.getInt(i++));
		
		return extracted;
	}

}
