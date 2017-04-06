package com.moderndemocracy.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.anaeko.utils.jdbc.ResultExtractor;
import com.moderndemocracy.pojo.DashboardTotal;

public class DashboardTotalExtractor implements ResultExtractor<DashboardTotal> {

	public static final String SQL =
			"select count(1) as total ";
	
	
	Logger logger = LogManager.getLogger(DashboardTotalExtractor.class);

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.anaeko.utils.jdbc.ResultExtractor#extract(java.sql.ResultSet,
	 * int)
	 */
	@Override
	public DashboardTotal extract(ResultSet data, int index) throws SQLException {

		DashboardTotal extracted = new DashboardTotal();
		int i=1;
		
		extracted.setTotal(data.getInt(i++));
		
		return extracted;
	}

}
