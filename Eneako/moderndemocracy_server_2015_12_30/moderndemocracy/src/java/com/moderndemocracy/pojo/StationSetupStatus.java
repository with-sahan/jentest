package com.moderndemocracy.pojo;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.anaeko.utils.data.mime.json.DefaultJsonMarshaler;
import com.anaeko.utils.json.JsonMarshaler;
import com.anaeko.utils.json.ToJSON;
import com.moderndemocracy.json.StationSetupStatusMarshaler;

public class StationSetupStatus implements ToJSON {

	protected static final Logger logger = LogManager.getLogger(StationSetupStatus.class);

	public static final String ID = "id";
	//public static final String STATION_ID = "stationId";
	public static final String TEXT = "text";
	public static final String ORDER_ID = "orderId";
	public static final String STATION_SETUP_LIST_ID = "stationSetupListId";
	public static final String STATUS = "status";
	
	private int id;
	//private int stationId;
	private String text;
	private int orderId;
	private int stationSetupListId;
	private boolean status;

	
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

//	public int getStationId() {
//		return stationId;
//	}
//
//	public void setStationId(int stationId) {
//		this.stationId = stationId;
//	}

	public int getStationSetupListId() {
		return stationSetupListId;
	}

	public void setStationSetupListId(int stationSetupListId) {
		this.stationSetupListId = stationSetupListId;
	}

	public boolean getStatus() {
		return status;
	}

	public void setStatus(boolean status) {
		this.status = status;
	}
	
	
	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public int getOrderId() {
		return orderId;
	}

	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}
	
	

		/*
	 * (non-Javadoc)
	 * 
	 * @see com.anaeko.utils.json.ToJSON#createMarshaller()
	 */
	@Override
	public JsonMarshaler createMarshaller() {
		return new StationSetupStatusMarshaler();
	}

	public static final class Marshaler extends DefaultJsonMarshaler {
	}

}
