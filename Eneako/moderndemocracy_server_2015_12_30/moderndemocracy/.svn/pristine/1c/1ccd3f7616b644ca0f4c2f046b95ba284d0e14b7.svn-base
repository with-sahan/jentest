package com.moderndemocracy.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.anaeko.utils.jdbc.ResultExtractor;
import com.moderndemocracy.pojo.Registers;

public class RegistersExtractor implements ResultExtractor<Registers> {

	public static final String SQL =
			"select id, title, summary, content, created_on"
			+ " FROM feed_registers";
	
	
	Logger logger = LogManager.getLogger(RegistersExtractor.class);

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.anaeko.utils.jdbc.ResultExtractor#extract(java.sql.ResultSet,
	 * int)
	 */
	@Override
	public Registers extract(ResultSet data, int index) throws SQLException {

		Registers extracted = new Registers();
		int i=1;
		
		extracted.setId(data.getInt(i++));
		extracted.setTitle(data.getString(i++));
		extracted.setSummary(data.getString(i++));
		extracted.setContent(data.getString(i++));
		extracted.setCreated(data.getTimestamp(i++));
		
		return extracted;
	}

}
