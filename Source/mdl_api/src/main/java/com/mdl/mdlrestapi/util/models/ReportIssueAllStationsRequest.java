package com.mdl.mdlrestapi.util.models;

public class ReportIssueAllStationsRequest {
	
	public String token;
	public int pollingstation_id_list [];
	public int electionid;
	public int issue_list_id;
	public String description;
	public int priority;
	
	public String getToken() {
		return token;
	}
	public void setToken(String token) {
		this.token = token;
	}
	public int[] getPollingstation_id_list() {
		return pollingstation_id_list;
	}
	public void setPollingstation_id_list(int[] pollingstation_id_list) {
		this.pollingstation_id_list = pollingstation_id_list;
	}
	public int getElectionid() {
		return electionid;
	}
	public void setElectionid(int electionid) {
		this.electionid = electionid;
	}
	public int getIssue_list_id() {
		return issue_list_id;
	}
	public void setIssue_list_id(int issue_list_id) {
		this.issue_list_id = issue_list_id;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public int getPriority() {
		return priority;
	}
	public void setPriority(int priority) {
		this.priority = priority;
	}
}
