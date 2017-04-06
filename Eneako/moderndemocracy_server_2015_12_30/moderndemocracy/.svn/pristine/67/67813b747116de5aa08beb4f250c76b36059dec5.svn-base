package com.moderndemocracy.pojo;

import java.sql.Timestamp;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.anaeko.utils.data.mime.json.DefaultJsonMarshaler;
import com.anaeko.utils.json.JsonMarshaler;
import com.anaeko.utils.json.ToJSON;
import com.moderndemocracy.json.TrackingMarshaler;

public class Tracking implements ToJSON {

	protected static final Logger logger = LogManager.getLogger(Tracking.class);

	public static final String STATION = "station";
	public static final String WARD = "ward";
	public static final String LAT = "lat";
	public static final String LNG = "lng";
	public static final String STATUS = "status";
	public static final String DISPATCH_TIME = "dispatchTime";
	public static final String DELIVER_TIME = "deliverTime";
	public static final String ETA = "eta";
	public static final String BALLOT_BOX_NUMBER = "ballotBoxNumber";
	public static final String CREATED_ON = "createdOn";
	public static final String UPDATED_ON = "updatedOn";
	
	private String station;
	private String ward;
	private double lat;
	private double lng;
	private int status;
	private Timestamp dispatchTime;
	private Timestamp deliverTime;
	private Timestamp eta;
	private String ballotBoxNo;
	private Timestamp createdOn;
	private Timestamp updatedOn;
	

	public String getStation() {
		return station;
	}

	public void setStation(String station) {
		this.station = station;
	}

	public String getWard() {
		return ward;
	}

	public void setWard(String ward) {
		this.ward = ward;
	}

	public double getLat() {
		return lat;
	}

	public void setLat(double lat) {
		this.lat = lat;
	}

	public double getLng() {
		return lng;
	}

	public void setLng(double lng) {
		this.lng = lng;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getBallotBoxNo() {
		return ballotBoxNo;
	}

	public void setBallotBoxNo(String ballotBoxNo) {
		this.ballotBoxNo = ballotBoxNo;
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
		return " Tracking ["
				+ ", station=" + station
				+ ", lat=" + lat
				+ ", lng=" + lng
				+ ", status=" + status
				+ ", createdOn=" + createdOn
				+ ", updatedOn=" + updatedOn
				+ "] ";
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.anaeko.utils.json.ToJSON#createMarshaller()
	 */
	@Override
	public JsonMarshaler createMarshaller() {
		return new TrackingMarshaler();
	}

	public Timestamp getDispatchTime() {
		return dispatchTime;
	}

	public void setDispatchTime(Timestamp dispatchTime) {
		this.dispatchTime = dispatchTime;
	}

	public Timestamp getDeliverTime() {
		return deliverTime;
	}

	public void setDeliverTime(Timestamp deliverTime) {
		this.deliverTime = deliverTime;
	}

	public Timestamp getEta() {
		return eta;
	}

	public void setEta(Timestamp eta) {
		this.eta = eta;
	}

	public static final class Marshaler extends DefaultJsonMarshaler {
	}

}
