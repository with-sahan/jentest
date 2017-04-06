package com.moderndemocracy.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.anaeko.utils.jdbc.ResultExtractor;
import com.moderndemocracy.pojo.News;

public class NewsExtractor implements ResultExtractor<News> {

	public static final String SQL =
			"select id, title, summary, content, public_url, title_image, content_image, display_date"
			+ " FROM feed_news";
	
	
	Logger logger = LogManager.getLogger(NewsExtractor.class);

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.anaeko.utils.jdbc.ResultExtractor#extract(java.sql.ResultSet,
	 * int)
	 */
	@Override
	public News extract(ResultSet data, int index) throws SQLException {

		News extracted = new News();
		int i=1;
		
		extracted.setId(data.getInt(i++));
		extracted.setTitle(data.getString(i++));
		extracted.setSummary(data.getString(i++));
		extracted.setContent(data.getString(i++));
		extracted.setPublicUrl(data.getString(i++));
		extracted.setTitleImage(data.getString(i++));
		extracted.setContentImage(data.getString(i++));
		extracted.setCreated(data.getTimestamp(i++));
		
		return extracted;
	}

}
