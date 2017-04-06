package com.moderndemocracy.pojo;

import java.sql.Timestamp;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.anaeko.utils.data.mime.json.DefaultJsonMarshaler;
import com.anaeko.utils.json.JsonMarshaler;
import com.anaeko.utils.json.ToJSON;
import com.moderndemocracy.json.NotificationListMarshaler;

public class NotificationList implements ToJSON {

	protected static final Logger logger = LogManager.getLogger(NotificationList.class);

	public static final String ID = "id";
	public static final String TEXT = "text";
	public static final String STATION_ID = "stationId";
	
	public static final String STATION_NAME  = "stationName";
	public static final String PLACE_NAME    = "placeName";
	public static final String DISTRICT_NAME = "districtName";
	public static final String WARD_NAME     = "wardName";
	
	public static final String STATUS = "status";
	
	public static final String CREATED_ON = "createdOn";
        public static final String URL = "url";
	
	private int id;
	private String text;
	private int stationId;
	
	private String stationName;
	private String placeName;
	private String districtName;
	private String wardName;
	
	private String status;
        private String url;
	
	private Timestamp createdOn;


	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
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
	
	public String getStationName() {
		return stationName;
	}

	public void setStationName(String stationName) {
		this.stationName = stationName;
	}

	public String getPlaceName() {
		return placeName;
	}

	public void setPlaceName(String placeName) {
		this.placeName = placeName;
	}

	public String getDistrictName() {
		return districtName;
	}

	public void setDistrictName(String districtName) {
		this.districtName = districtName;
	}

	public String getWardName() {
		return wardName;
	}

	public void setWardName(String wardName) {
		this.wardName = wardName;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
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
		return "NotificationList [id=" + id + ", text=" + text + ", stationId="
				+ stationId + ", url="+ url + "]";
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.anaeko.utils.json.ToJSON#createMarshaller()
	 */
	@Override
	public JsonMarshaler createMarshaller() {
		return new NotificationListMarshaler();
	}

	public static final class Marshaler extends DefaultJsonMarshaler {
	}

}
