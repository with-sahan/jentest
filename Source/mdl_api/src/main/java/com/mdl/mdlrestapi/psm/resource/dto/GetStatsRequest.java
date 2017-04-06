package com.mdl.mdlrestapi.psm.resource.dto;

/**
 * Created by Thara on 3/10/2017.
 */
public class GetStatsRequest {
    public String token;
    public int electionId;

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
