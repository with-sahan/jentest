package com.mdl.mdlrestapi.psm.resource.dto;

/**
 * Created by lasantha on 4/3/2017.
 */
public class TenderedVotesRequest {

    private String token;
    private int pollingstationid;
    private int eid;
    private String votername;
    private int electornumber;
    private int ismarked;
    private int tvid;

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public int getPollingstationid() {
        return pollingstationid;
    }

    public void setPollingstationid(int pollingstationid) {
        this.pollingstationid = pollingstationid;
    }

    public int getEid() {
        return eid;
    }

    public void setEid(int eid) {
        this.eid = eid;
    }

    public String getVotername() {
        return votername;
    }

    public void setVotername(String votername) {
        this.votername = votername;
    }

    public int getElectornumber() {
        return electornumber;
    }

    public void setElectornumber(int electornumber) {
        this.electornumber = electornumber;
    }

    public int getIsmarked() {
        return ismarked;
    }

    public void setIsmarked(int ismarked) {
        this.ismarked = ismarked;
    }

    public int getTvid() {
        return tvid;
    }

    public void setTvid(int tvid) {
        this.tvid = tvid;
    }
}
