package com.moderndemocracy.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.anaeko.utils.jdbc.ResultExtractor;
import com.moderndemocracy.pojo.ProgressUpdate;

public class ProgressUpdateExtractor implements ResultExtractor<ProgressUpdate> {

	public static final String SQL = "SELECT ballot_papers_issued, postal_packs_received, postal_packs_awaiting_collection "
										+ "FROM polling_station ";

	Logger logger = LogManager.getLogger(ProgressUpdateExtractor.class);

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.anaeko.utils.jdbc.ResultExtractor#extract(java.sql.ResultSet,
	 * int)
	 */
	@Override
	public ProgressUpdate extract(ResultSet data, int index) throws SQLException {

		ProgressUpdate extracted = new ProgressUpdate();
		int i=1;
		
		extracted.setPapersIssued(data.getInt(i++));
		extracted.setPostalPacksReceived(data.getInt(i++));
		extracted.setPostalPacksAwaitingCollection(data.getInt(i++));

		return extracted;
	}

}
