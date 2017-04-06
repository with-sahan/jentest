package com.moderndemocracy.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.anaeko.utils.jdbc.ResultExtractor;
import com.moderndemocracy.pojo.User;

public class UsersExtractor implements ResultExtractor<User> {

	public static final String SQL = 
			"SELECT u.id, u.council_id, u.first_name, u.last_name, u.login_name, u.station_id, u.council_id, u.role_id "
			+ " FROM users u ";

	Logger logger = LogManager.getLogger(UsersExtractor.class);

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.anaeko.utils.jdbc.ResultExtractor#extract(java.sql.ResultSet,
	 * int)
	 */
	@Override
	public User extract(ResultSet data, int index) throws SQLException {

		User extracted = new User();
		int i=1;
		extracted.setId(data.getInt(i++));
		extracted.setCouncilId(data.getInt(i++));
		extracted.setFirstName(data.getString(i++));
		extracted.setLastName(data.getString(i++));
		extracted.setLoginName(data.getString(i++));
		extracted.setStationId(data.getInt(i++));
		extracted.setCouncilId(data.getInt(i++));
		extracted.setRoleId(data.getInt(i++));
		return extracted;
	}

}
