package com.moderndemocracy.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.anaeko.utils.jdbc.ResultExtractor;
import com.moderndemocracy.pojo.Ward;

public class WardsExtractor implements ResultExtractor<Ward> {

	public static final String SQL =
			"select distinct W.id, W.name as wardName "
			+ "from ward W ";
	
	
	Logger logger = LogManager.getLogger(WardsExtractor.class);

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.anaeko.utils.jdbc.ResultExtractor#extract(java.sql.ResultSet,
	 * int)
	 */
	@Override
	public Ward extract(ResultSet data, int index) throws SQLException {

		Ward extracted = new Ward();
		int i=1;
		
		extracted.setId(data.getInt(i++));
		extracted.setWardName(data.getString(i++));

		return extracted;
	}

}
