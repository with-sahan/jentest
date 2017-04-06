package com.moderndemocracy.pojo;

import java.sql.Timestamp;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.anaeko.utils.data.mime.json.DefaultJsonMarshaler;
import com.anaeko.utils.json.JsonMarshaler;
import com.anaeko.utils.json.ToJSON;
import com.moderndemocracy.json.IssueMarshaler;

public class Issue implements ToJSON {

	protected static final Logger logger = LogManager.getLogger(Issue.class);

	public static final String ISSUE_ID    = "id";
	public static final String REASON      = "reason";
	public static final String DESCRIPTION = "description";
	public static final String PRIORITY    = "priority";
	public static final String STATION     = "station";
	public static final String PLACE       = "place";
	public static final String USER        = "user";
	public static final String WARD        = "ward";
	public static final String STATUS      = "status";
	public static final String RESOLUTION  = "resolution";
	public static final String CREATED_ON  = "createdOn";
	
	private int       issueId;
	private String    reason;
	private String    description;
	private String    priority;
	private String    station;
	private String    place;
	private String    user;
	private String    ward;
	private Boolean   status;
	private String    resolution;
	private Timestamp createdOn;
	
	
	public int getIssueId() {
		return issueId;
	}

	public void setIssueId(int issueId) {
		this.issueId = issueId;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getPriority() {
		return priority;
	}

	public void setPriority(String priority) {
		this.priority = priority;
	}

	public String getStation() {
		return station;
	}

	public void setStation(String station) {
		this.station = station;
	}

	public String getPlace() {
		return place;
	}

	public void setPlace(String place) {
		this.place = place;
	}

	public String getUser() {
		return user;
	}

	public void setUser(String user) {
		this.user = user;
	}
	
	public String getWard() {
		return ward;
	}

	public void setWard(String ward) {
		this.ward = ward;
	}

	public Boolean getStatus() {
		return status;
	}

	public void setStatus(Boolean status) {
		this.status = status;
	}

	public String getResolution() {
		return resolution;
	}

	public void setResolution(String resolution) {
		this.resolution = resolution;
	}

	public Timestamp getCreatedOn() {
		return createdOn;
	}

	public void setCreatedOn(Timestamp createdOn) {
		this.createdOn = createdOn;
	}
	

	@Override
	public String toString() {
		return " Issue ["
				+ ", reason=" + reason
				+ ", description=" + description
				+ ", priority=" + priority
				+ ", station=" + station
				+ ", user=" + user
				+ "] ";
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.anaeko.utils.json.ToJSON#createMarshaller()
	 */
	@Override
	public JsonMarshaler createMarshaller() {
		return new IssueMarshaler();
	}

	public static final class Marshaler extends DefaultJsonMarshaler {
	}

}
