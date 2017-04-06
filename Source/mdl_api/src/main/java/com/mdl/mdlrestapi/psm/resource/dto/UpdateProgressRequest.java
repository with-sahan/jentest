package com.mdl.mdlrestapi.psm.resource.dto;

/**
 * Created with IntelliJ IDEA.
 * User: AnushaP
 * Date: 3/2/17
 * Time: 11:02 PM
 * To change this template use File | Settings | File Templates.
 */
public class UpdateProgressRequest {
    private String token;
    private int electionid;
    private int pollingstationid;
    private int ballotpapers;
    private int postalpacks;
    private int postalpackscollected;

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

    public int getBallotpapers() {
        return ballotpapers;
    }

    public void setBallotpapers(int ballotpapers) {
        this.ballotpapers = ballotpapers;
    }

    public int getPostalpacks() {
        return postalpacks;
    }

    public void setPostalpacks(int postalpacks) {
        this.postalpacks = postalpacks;
    }

    public int getPostalpackscollected() {
        return postalpackscollected;
    }

    public void setPostalpackscollected(int postalpackscollected) {
        this.postalpackscollected = postalpackscollected;
    }
}
