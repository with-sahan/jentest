package com.mdl.mdlrestapi.psm.model;

import java.io.Serializable;

public class OpenStationButtonStatus implements Serializable{

	public OpenStationButtonStatus(){
		
	}
	
	private int status;
	private String response;
	
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getResponse() {
		return response;
	}
	public void setResponse(String response) {
		this.response = response;
	}
	
	
}

