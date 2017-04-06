package com.mdl.mdlrestapi.psm.resource.dto;

/**
 * Created with IntelliJ IDEA.
 * User: AnushaP
 * Date: 2/23/17
 * Time: 12:31 AM
 * To change this template use File | Settings | File Templates.
 */
public class PostPollingActivityRequest {
    private String token;
    private  int polling_station_id;
    private int electionid;

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public int getPolling_station_id() {
        return polling_station_id;
    }

    public void setPolling_station_id(int polling_station_id) {
        this.polling_station_id = polling_station_id;
    }

    public int getElectionid() {
        return electionid;
    }

    public void setElectionid(int electionid) {
        this.electionid = electionid;
    }
}
