package com.moderndemocracy.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.anaeko.utils.jdbc.ResultExtractor;
import com.moderndemocracy.pojo.Issue;

public class IssueExtractor implements ResultExtractor<Issue> {

	public static final String SQL =
//			"SELECT U.first_name, U.last_name, S.name as stationName, PP.name as placeName, W.name as wardName, "
//			+ " I.id, I.reason, I.description, I.priority, I.created_on, I.resolution, I.status "
//			+ " FROM users U, polling_station S, polling_place PP, polling_district PD, ward W, issues I ";
	
			"SELECT S.name as stationName, PP.name as placeName, W.name as wardName, "
			+ " I.id, I.reason, I.description, I.priority, I.created_on, I.resolution, i.status "
			+ " FROM polling_station S, polling_place PP, polling_district PD, ward W, issues I ";
	
	Logger logger = LogManager.getLogger(IssueExtractor.class);

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.anaeko.utils.jdbc.ResultExtractor#extract(java.sql.ResultSet,
	 * int)
	 */
	@Override
	public Issue extract(ResultSet data, int index) throws SQLException {

		Issue extracted = new Issue();
		int i=1;
		
		//extracted.setUser(data.getString(i++)+" "+data.getString(i++));
		extracted.setStation(data.getString(i++));
		extracted.setPlace(data.getString(i++));
		extracted.setWard(data.getString(i++));
		extracted.setIssueId(data.getInt(i++));
		extracted.setReason(data.getString(i++));
		extracted.setDescription(data.getString(i++));
		extracted.setPriority(data.getString(i++));
		extracted.setCreatedOn(data.getTimestamp(i++));
		extracted.setResolution(data.getString(i++));
		extracted.setStatus(data.getBoolean(i++));

		return extracted;
	}

}
