package com.mdl.mdlrestapi.psm.resource.dto;

import java.util.List;

public class GeoStatoinsResponse {
	
	private String response;
	private String ward;
	private String district;
	private String place;
	private String pollingstationname;
	private int stationid;
	private int runningtotal;
	private List<TimeHourlyDto> timehourly;
	

	public String getResponse() {
		return response;
	}
	public void setResponse(String response) {
		this.response = response;
	}
	public String getWard() {
		return ward;
	}
	public void setWard(String ward) {
		this.ward = ward;
	}
	public String getDistrict() {
		return district;
	}
	public void setDistrict(String district) {
		this.district = district;
	}
	public String getPlace() {
		return place;
	}
	public void setPlace(String place) {
		this.place = place;
	}
	public String getPollingstationname() {
		return pollingstationname;
	}
	public void setPollingstationname(String pollingstationname) {
		this.pollingstationname = pollingstationname;
	}
	public int getStationid() {
		return stationid;
	}
	public void setStationid(int stationid) {
		this.stationid = stationid;
	}
	public int getRunningtotal() {
		return runningtotal;
	}
	public void setRunningtotal(int runningtotal) {
		this.runningtotal = runningtotal;
	}
	public List<TimeHourlyDto> getTimehourly() {
		return timehourly;
	}
	public void setTimehourly(List<TimeHourlyDto> timehourly) {
		this.timehourly = timehourly;
	}	

}
