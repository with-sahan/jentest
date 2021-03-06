package com.moderndemocracy.pojo;

import java.sql.Timestamp;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.anaeko.utils.data.mime.json.DefaultJsonMarshaler;
import com.anaeko.utils.json.JsonMarshaler;
import com.anaeko.utils.json.ToJSON;
import com.moderndemocracy.json.NotificationMarshaler;

public class Notification implements ToJSON {

	protected static final Logger logger = LogManager.getLogger(Notification.class);

	public static final String ID		  = "id";
	public static final String TEXT       = "text";
	public static final String DATETIME   = "datetime";
	public static final String STATION_ID = "stationId";
	public static final String PRIVATE    = "private";
    public static final String URL    = "url";
	
	private int       notificationId;
	private String    text;
    private String    url;
	private int       stationId;
	private boolean   private_notification;
	
	private Timestamp createdOn;
	

	public int getNotificationId() {
		return notificationId;
	}

	public void setNotificationId(int notificationId) {
		this.notificationId = notificationId;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public int getStationId() {
		return stationId;
	}

	public void setStationId(int stationId) {
		this.stationId = stationId;
	}

	public boolean isPrivate_notification() {
		return private_notification;
	}

	public void setPrivate_notification(boolean private_notification) {
		this.private_notification = private_notification;
	}

	public Timestamp getCreatedOn() {
		return createdOn;
	}

	public void setCreatedOn(Timestamp createdOn) {
		this.createdOn = createdOn;
	}
	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	@Override
	public String toString() {
		return " Notification ["
				+ ", text=" + text
				+ ", createdOn=" + createdOn
                + ", url=" + url
				+ "] ";
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.anaeko.utils.json.ToJSON#createMarshaller()
	 */
	@Override
	public JsonMarshaler createMarshaller() {
		return new NotificationMarshaler();
	}

	public static final class Marshaler extends DefaultJsonMarshaler {
	}

}
