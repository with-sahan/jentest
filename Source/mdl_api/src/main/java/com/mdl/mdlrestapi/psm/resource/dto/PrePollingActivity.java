package com.mdl.mdlrestapi.psm.resource.dto;

/**
 * Created with IntelliJ IDEA.
 * User: AnushaP
 * Date: 2/22/17
 * Time: 10:57 PM
 * To change this template use File | Settings | File Templates.
 */
public class PrePollingActivity {



    private String token;
    private int electionid ;
    private int pollingstationid;
    private int activityid ;
    private int status;

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

    public int getActivityid() {
        return activityid;
    }

    public void setActivityid(int activityid) {
        this.activityid = activityid;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
}
