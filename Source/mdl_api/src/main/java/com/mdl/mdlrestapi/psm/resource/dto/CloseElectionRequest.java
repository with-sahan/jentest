package com.mdl.mdlrestapi.psm.resource.dto;

public class CloseElectionRequest {
	private String token;
    private  int pollingstationid;
    private int electionid;
    private int electionstatus;

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public int getPollingstationid() {
        return pollingstationid;
    }

    public void setPollingstationid(int polling_station_id) {
        this.pollingstationid = polling_station_id;
    }

    public int getElectionid() {
        return electionid;
    }

    public void setElectionid(int electionid) {
        this.electionid = electionid;
    }
    
    public int getElectionstatus() {
        return electionstatus;
    }

    public void setElectionstatus(int electionid) {
        this.electionstatus = electionid;
    }
}
