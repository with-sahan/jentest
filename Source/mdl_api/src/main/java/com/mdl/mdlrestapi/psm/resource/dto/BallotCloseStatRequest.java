package com.mdl.mdlrestapi.psm.resource.dto;

/**
 * Created with IntelliJ IDEA.
 * User: AnushaP
 * Date: 2/23/17
 * Time: 1:01 PM
 * To change this template use File | Settings | File Templates.
 */
public class BallotCloseStatRequest {
    private String token;
    private int electionid;
    private int pollingstationid;

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public int getElectionid() {
        return electionid;
    }

    public void setElectionid(int electionid) {
        this.electionid = electionid;
    }

    public int getPollingstationid() {
        return pollingstationid;
    }

    public void setPollingstationid(int pollingstationid) {
        this.pollingstationid = pollingstationid;
    }
}
