package com.moderndemocracy.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.anaeko.utils.jdbc.ResultExtractor;
import com.moderndemocracy.pojo.DashboardGender;

public class DashboardGenderExtractor implements ResultExtractor<DashboardGender> {

	public static final String SQL =
			"select count(1) as total ";
	
	
	Logger logger = LogManager.getLogger(DashboardGenderExtractor.class);

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.anaeko.utils.jdbc.ResultExtractor#extract(java.sql.ResultSet,
	 * int)
	 */
	@Override
	public DashboardGender extract(ResultSet data, int index) throws SQLException {

		DashboardGender extracted = new DashboardGender();
		int i=1;
		
		extracted.setTotal(data.getInt(i++));
		
		return extracted;
	}

}
