package com.moderndemocracy.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.anaeko.utils.jdbc.ResultExtractor;
import com.moderndemocracy.pojo.Candidates;

public class CandidatesExtractor implements ResultExtractor<Candidates> {

	public static final String SQL =
			//"select id, title, summary, content, public_url, title_image, flag_image, party_name, created_on"
			//+ " FROM feed_candidates";
			"select fc.id, w.name, fc.title, fc.summary, fc.content, fc.public_url, fc.title_image, fc.flag_image, fc.party_name, fc.created_on "
			+ "FROM feed_candidates fc, council c, ward w ";
	
	
	Logger logger = LogManager.getLogger(CandidatesExtractor.class);

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.anaeko.utils.jdbc.ResultExtractor#extract(java.sql.ResultSet,
	 * int)
	 */
	@Override
	public Candidates extract(ResultSet data, int index) throws SQLException {

		Candidates extracted = new Candidates();
		int i=1;
		
		extracted.setId(data.getInt(i++));
		extracted.setWardName(data.getString(i++));
		extracted.setTitle(data.getString(i++));
		extracted.setSummary(data.getString(i++));
		extracted.setContent(data.getString(i++));
		extracted.setPublicUrl(data.getString(i++));
		extracted.setTitleImage(data.getString(i++));
		extracted.setFlagImage(data.getString(i++));
		extracted.setPartyName(data.getString(i++));
		extracted.setCreated(data.getTimestamp(i++));
		
		return extracted;
	}

}
