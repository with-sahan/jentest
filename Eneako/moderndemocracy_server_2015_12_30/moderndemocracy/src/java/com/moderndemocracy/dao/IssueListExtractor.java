package com.moderndemocracy.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.anaeko.utils.jdbc.ResultExtractor;
import com.moderndemocracy.pojo.IssueList;

public class IssueListExtractor implements ResultExtractor<IssueList> {

	public static final String SQL = "SELECT I.id, I.text, I.order_id, I.email, I.status "
									+ " FROM issue_list I ";

	Logger logger = LogManager.getLogger(IssueListExtractor.class);

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.anaeko.utils.jdbc.ResultExtractor#extract(java.sql.ResultSet,
	 * int)
	 */
	@Override
	public IssueList extract(ResultSet data, int index) throws SQLException {

		IssueList extracted = new IssueList();
		int i=1;
		extracted.setId(data.getInt(i++));
		extracted.setText(data.getString(i++));
		extracted.setOrderId(data.getInt(i++));
		extracted.setEmail(data.getString(i++));
		extracted.setStatus(data.getBoolean(i++));

		return extracted;
	}

}
