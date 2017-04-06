package com.mdl.mdlrestapi.psm.resource.dto;

/**
 * @Author	: Rushan
 * @Date	: Feb 26, 2017
 * @TIme	: 11:51:04 PM
 */
public class GpsRequest {

	private String token;
	private Float latitude;
	private Float longtitude;
	
	public String getToken() {
		return token;
	}
	public void setToken(String token) {
		this.token = token;
	}
	public double getLatitude() {
		return latitude;
	}
	public void setLatitude(Float latitude) {
		this.latitude = latitude;
	}
	public double getLongtitude() {
		return longtitude;
	}
	public void setLongtitude(Float longtitude) {
		this.longtitude = longtitude;
	}
}
