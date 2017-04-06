package com.moderndemocracy.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.anaeko.utils.jdbc.ResultExtractor;
import com.moderndemocracy.pojo.Settings;

public class SettingsExtractor implements ResultExtractor<Settings> {

	public static final String SQL =
			"select id, tabs, default_share_url, registration_deadline, min_client_build_no, upgrade_message,"
			+ " facebook_app_id, default_news_title_image, default_news_content_image,"
			+ " default_events_title_image, default_events_content_image, default_candidates_title_image, ios_app_store_url, android_google_play_store_url, created_on, updated_on"
			+ " FROM settings";
	
	
	Logger logger = LogManager.getLogger(SettingsExtractor.class);

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.anaeko.utils.jdbc.ResultExtractor#extract(java.sql.ResultSet,
	 * int)
	 */
	@Override
	public Settings extract(ResultSet data, int index) throws SQLException {

		Settings extracted = new Settings();
		int i=1;
		
		extracted.setId(data.getInt(i++));
		
		extracted.setTabs(data.getString(i++));
		extracted.setDefaultShareUrl(data.getString(i++));
		extracted.setRegistrationDeadline(data.getTimestamp(i++));
		extracted.setMinBuildNumber(data.getString(i++));
		extracted.setUpgradeMessage(data.getString(i++));
		extracted.setFacebookAppId(data.getString(i++));
		extracted.setDefaultNewsTitleImage(data.getString(i++));
		extracted.setDefaultNewsContentImage(data.getString(i++));
		extracted.setDefaultEventsTitleImage(data.getString(i++));
		extracted.setDefaultEventsContentImage(data.getString(i++));
		extracted.setDefaultCandidatesTitleImage(data.getString(i++));
		extracted.setIosAppStoreUrl(data.getString(i++));
		extracted.setAndroidGooglePlayStoreUrl(data.getString(i++));
		
		extracted.setCreatedOn(data.getTimestamp(i++));
		extracted.setUpdatedOn(data.getTimestamp(i++));
		
		return extracted;
	}

}
