package com.moderndemocracy.pojo;

import java.sql.Timestamp;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.anaeko.utils.data.mime.json.DefaultJsonMarshaler;
import com.anaeko.utils.json.JsonMarshaler;
import com.anaeko.utils.json.ToJSON;
import com.moderndemocracy.json.SettingsMarshaler;

public class Settings implements ToJSON {

	protected static final Logger logger = LogManager.getLogger(Settings.class);

	public static final String ID = "id";
	
	public static final String TABS = "tabs";
	public static final String DEFAULT_TAB = "defaultTab";
	public static final String DEFAULT_SHARE_URL = "defaultShareURL";
	public static final String REGISTRATION_DEADLINE = "registrationDeadline";
	public static final String MIN_BUILD_NUMBER = "minBuildNumber";
	public static final String UPGRADE_MESSAGE = "upgradeMessage";
	public static final String FACEBOOK_APP_ID = "facebookAppId";
	public static final String DEFAULT_NEWS_TITLE_IMAGE = "defaultNewsTitleImage";
	public static final String DEFAULT_NEWS_CONTENT_IMAGE = "defaultNewsContentImage";
	public static final String DEFAULT_EVENTS_TITLE_IMAGE = "defaultEventsTitleImage";
	public static final String DEFAULT_EVENTS_CONTENT_IMAGE = "defaultEventsContentImage";
	public static final String DEFAULT_CANDIDATES_TITLE_IMAGE = "defaultCandidatesTitleImage";
	
	public static final String IOS_APP_STORE_URL = "iosAppStoreUrl";
	public static final String ANDROID_GOOGLE_PLAY_STORE_URL = "androidGooglePlayStoreUrl";
	
	public static final String CREATED_ON = "createdOn";
	public static final String UPDATED_ON = "updatedOn";
	
	private int id;
	private String tabs;
	private String defaultShareUrl;
	private Timestamp registrationDeadline;
	private String minBuildNumber;
	private String upgradeMessage;
	private String facebookAppId;
	private String defaultNewsTitleImage;
	private String defaultNewsContentImage;
	private String defaultEventsTitleImage;
	private String defaultEventsContentImage;
	private String defaultCandidatesTitleImage;
	private String iosAppStoreUrl;
	private String androidGooglePlayStoreUrl;
	private Timestamp createdOn;
	private Timestamp updatedOn;
	

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTabs() {
		return tabs;
	}

	public void setTabs(String tabs) {
		this.tabs = tabs;
	}

	public String getDefaultShareUrl() {
		return defaultShareUrl;
	}

	public void setDefaultShareUrl(String defaultShareUrl) {
		this.defaultShareUrl = defaultShareUrl;
	}

	public Timestamp getRegistrationDeadline() {
		return registrationDeadline;
	}

	public void setRegistrationDeadline(Timestamp registrationDeadline) {
		this.registrationDeadline = registrationDeadline;
	}

	public String getMinBuildNumber() {
		return minBuildNumber;
	}

	public void setMinBuildNumber(String minBuildNumber) {
		this.minBuildNumber = minBuildNumber;
	}

	public String getUpgradeMessage() {
		return upgradeMessage;
	}

	public void setUpgradeMessage(String upgradeMessage) {
		this.upgradeMessage = upgradeMessage;
	}

	public String getFacebookAppId() {
		return facebookAppId;
	}

	public void setFacebookAppId(String facebookAppId) {
		this.facebookAppId = facebookAppId;
	}

	public String getDefaultNewsTitleImage() {
		return defaultNewsTitleImage;
	}

	public void setDefaultNewsTitleImage(String defaultNewsTitleImage) {
		this.defaultNewsTitleImage = defaultNewsTitleImage;
	}

	public String getDefaultNewsContentImage() {
		return defaultNewsContentImage;
	}

	public void setDefaultNewsContentImage(String defaultNewsContentImage) {
		this.defaultNewsContentImage = defaultNewsContentImage;
	}

	public String getDefaultEventsTitleImage() {
		return defaultEventsTitleImage;
	}

	public void setDefaultEventsTitleImage(String defaultEventsTitleImage) {
		this.defaultEventsTitleImage = defaultEventsTitleImage;
	}

	public String getDefaultEventsContentImage() {
		return defaultEventsContentImage;
	}

	public void setDefaultEventsContentImage(String defaultEventsContentImage) {
		this.defaultEventsContentImage = defaultEventsContentImage;
	}

	public String getDefaultCandidatesTitleImage() {
		return defaultCandidatesTitleImage;
	}

	public void setDefaultCandidatesTitleImage(String defaultCandidatesTitleImage) {
		this.defaultCandidatesTitleImage = defaultCandidatesTitleImage;
	}

	public String getIosAppStoreUrl() {
		return iosAppStoreUrl;
	}

	public void setIosAppStoreUrl(String iosAppStoreUrl) {
		this.iosAppStoreUrl = iosAppStoreUrl;
	}

	public String getAndroidGooglePlayStoreUrl() {
		return androidGooglePlayStoreUrl;
	}

	public void setAndroidGooglePlayStoreUrl(String androidGooglePlayStoreUrl) {
		this.androidGooglePlayStoreUrl = androidGooglePlayStoreUrl;
	}

	public Timestamp getCreatedOn() {
		return createdOn;
	}

	public void setCreatedOn(Timestamp createdOn) {
		this.createdOn = createdOn;
	}

	public Timestamp getUpdatedOn() {
		return updatedOn;
	}

	public void setUpdatedOn(Timestamp updatedOn) {
		this.updatedOn = updatedOn;
	}

	@Override
	public String toString() {
		
		return " Settings [ "
				
				+ "id=" + id
				+ ", tabs=" + tabs
				+ ", registrationDeadline=" + registrationDeadline
				+ ", buildNumber=" + minBuildNumber
				+ ", facebookAppId=" + facebookAppId
				+ ", defaultNewsTitleImage=" + defaultNewsTitleImage
				+ ", defaultNewsContentImage=" + defaultNewsContentImage
				+ ", defaultEventsTitleImage=" + defaultEventsTitleImage
				+ ", defaultEventsContentImage=" + defaultEventsContentImage
				+ ", iosAppStoreUrl=" + iosAppStoreUrl
				+ ", androidGooglePlayStoreUrl=" + androidGooglePlayStoreUrl
				+ ", createdOn=" + createdOn
				+ ", updatedOn=" + updatedOn
				+ " ] ";
	}
	

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.anaeko.utils.json.ToJSON#createMarshaller()
	 */
	@Override
	public JsonMarshaler createMarshaller() {
		return new SettingsMarshaler();
	}

	public static final class Marshaler extends DefaultJsonMarshaler {
	}

}
