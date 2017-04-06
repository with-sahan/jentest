package com.mdl.mdlrestapi.psm.resource.dto;

/**
 * Created by Thara on 3/10/2017.
 */
public class ElectionResponse {
    private int id;
    private String electionName;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getElectionName() {
        return electionName;
    }

    public void setElectionName(String electionName) {
        this.electionName = electionName;
    }
}
