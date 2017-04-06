package com.mdl.mdlrestapi.psm.resource.dto;

/**
 * Created with IntelliJ IDEA.
 * User: AnushaP
 * Date: 2/22/17
 * Time: 11:21 PM
 * To change this template use File | Settings | File Templates.
 */
public class ElectionStatusRequest {

    private String token;
    private int stationid;
    private int electionid;


    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public int getStationid() {
        return stationid;
    }

    public void setStationid(int stationid) {
        this.stationid = stationid;
    }

    public int getElectionid() {
        return electionid;
    }

    public void setElectionid(int electionid) {
        this.electionid = electionid;
    }
}
