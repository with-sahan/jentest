package com.moderndemocracy.pojo;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.anaeko.utils.data.mime.json.DefaultJsonMarshaler;
import com.anaeko.utils.json.JsonMarshaler;
import com.anaeko.utils.json.ToJSON;
import com.moderndemocracy.json.NotificationReceivedMarshaler;

public class NotificationReceived implements ToJSON {

	protected static final Logger logger = LogManager.getLogger(NotificationReceived.class);

	public static final String ID = "id";
	public static final String NOTIFICATION_ID = "notificationId";
	public static final String STATION_ID = "stationId";
	public static final String USER_ID = "userId";
	public static final String STATUS = "status";
	
	private Integer id;
	private Integer notificationId;
	private Integer stationId;
	private Integer userId;
	private Integer status;
	

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getNotificationId() {
		return notificationId;
	}

	public void setNotificationId(Integer notificationId) {
		this.notificationId = notificationId;
	}

	public Integer getStationId() {
		return stationId;
	}

	public void setStationId(Integer stationId) {
		this.stationId = stationId;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	@Override
	public String toString() {
		return " NotificationRetrieved ["
				+ ", notificationId=" + notificationId
				+ ", stationId=" + stationId
				+ ", userId=" + userId
				+ ", status=" + status
				+ "] ";
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.anaeko.utils.json.ToJSON#createMarshaller()
	 */
	@Override
	public JsonMarshaler createMarshaller() {
		return new NotificationReceivedMarshaler();
	}

	public static final class Marshaler extends DefaultJsonMarshaler {
	}

}
