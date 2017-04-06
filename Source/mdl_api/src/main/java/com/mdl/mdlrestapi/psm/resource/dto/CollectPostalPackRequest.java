package com.mdl.mdlrestapi.psm.resource.dto;

public class CollectPostalPackRequest {
	private String token;
    private  int pollingstationid;
    private int electionid;
    private String person_name;

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
    
    public String getperson_name()
    {
    	return person_name;
    }
    
    public void setperson_name(String personName)
    {
    	person_name = personName;
    }
    
}
