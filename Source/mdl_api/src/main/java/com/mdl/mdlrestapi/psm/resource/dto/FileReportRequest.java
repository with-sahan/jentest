package com.mdl.mdlrestapi.psm.resource.dto;

public class FileReportRequest {
	private String token;
	private int electionId;
	
	public String getToken() {
		return token;
	}
	public void setToken(String token) {
		this.token = token;
	}
	public int getElectionId() {
		return electionId;
	}
	public void setElectionId(int electionId) {
		this.electionId = electionId;
	}
	
	
}
