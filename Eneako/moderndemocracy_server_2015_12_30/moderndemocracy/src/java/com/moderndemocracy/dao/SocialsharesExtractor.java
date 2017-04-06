package com.moderndemocracy.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.anaeko.utils.jdbc.ResultExtractor;
import com.moderndemocracy.pojo.Socialshares;

public class SocialsharesExtractor implements ResultExtractor<Socialshares> {

	public static final String SQL_SELECT_BY_FEED_1 = "select distinct(title), count(1) from ";
	
	public static final String SQL1 = "select track_socialnetwork.feed, feed.title, track_socialnetwork.social_network, count(1) " +
										"from track_socialnetwork, feed_";
	public static final String SQL2 = " feed, users " +
										"where " +
										"track_socialnetwork.feed_id=feed.id and " +
										"track_socialnetwork.feed=? and track_socialnetwork.council_id=? and " +
										"track_socialnetwork.created_on >= ? and " +
										"track_socialnetwork.created_on <= ? and " +
										"track_socialnetwork.user_id = users.id and users.role_id=1 " +
										"group by feed,title,social_network " +
										"order by feed,title,social_network";
	
	public static String SQL_REGISTER = "select track_socialnetwork.feed, 'Register To Vote' as title, track_socialnetwork.social_network, count(1) " +
										"from track_socialnetwork, users " +
										"where " +
										"track_socialnetwork.feed=? and track_socialnetwork.council_id=? and " +
										"track_socialnetwork.created_on >= ? and " +
										"track_socialnetwork.created_on <= ? and " +
										"track_socialnetwork.user_id = users.id and users.role_id=1 " +
										"group by feed,social_network " +
										"order by feed,social_network";
	
	
	Logger logger = LogManager.getLogger(SocialsharesExtractor.class);

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.anaeko.utils.jdbc.ResultExtractor#extract(java.sql.ResultSet,
	 * int)
	 */
	@Override
	public Socialshares extract(ResultSet data, int index) throws SQLException {

		Socialshares extracted = new Socialshares();
		int i=1;
		
		extracted.setFeed(data.getString(i++));
		extracted.setTitle(data.getString(i++));
		extracted.setSocialNetwork(data.getString(i++));
		extracted.setTotal(data.getInt(i++));

		return extracted;
	}

}
