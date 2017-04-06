package com.mdl.mdlrestapi.psm.resource.dto;

/**
 * Created with IntelliJ IDEA.
 * User: AnushaP
 * Date: 2/24/17
 * Time: 10:31 AM
 * To change this template use File | Settings | File Templates.
 */
public class CloseStationStatRequest {

    private String token;
    private int electionid;
    private int tot_ballots;
    private int tot_spoiled_replaced;
    private int tot_unused;
    private int  tot_tend_ballots;
    private int tot_tend_spoiled;
    private int tot_tend_unused;
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

    public int getTot_ballots() {
        return tot_ballots;
    }

    public void setTot_ballots(int tot_ballots) {
        this.tot_ballots = tot_ballots;
    }

    public int getTot_spoiled_replaced() {
        return tot_spoiled_replaced;
    }

    public void setTot_spoiled_replaced(int tot_spoiled_replaced) {
        this.tot_spoiled_replaced = tot_spoiled_replaced;
    }

    public int getTot_unused() {
        return tot_unused;
    }

    public void setTot_unused(int tot_unused) {
        this.tot_unused = tot_unused;
    }

    public int getTot_tend_ballots() {
        return tot_tend_ballots;
    }

    public void setTot_tend_ballots(int tot_tend_ballots) {
        this.tot_tend_ballots = tot_tend_ballots;
    }

    public int getTot_tend_spoiled() {
        return tot_tend_spoiled;
    }

    public void setTot_tend_spoiled(int tot_tend_spoiled) {
        this.tot_tend_spoiled = tot_tend_spoiled;
    }

    public int getTot_tend_unused() {
        return tot_tend_unused;
    }

    public void setTot_tend_unused(int tot_tend_unused) {
        this.tot_tend_unused = tot_tend_unused;
    }

    public int getPollingstationid() {
        return pollingstationid;
    }

    public void setPollingstationid(int pollingstationid) {
        this.pollingstationid = pollingstationid;
    }
}
