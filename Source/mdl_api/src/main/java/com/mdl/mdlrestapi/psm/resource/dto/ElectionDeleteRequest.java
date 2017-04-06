package com.mdl.mdlrestapi.psm.resource.dto;

/**
 * Created with IntelliJ IDEA.
 * User: AnushaP
 * Date: 3/1/17
 * Time: 5:02 PM
 * To change this template use File | Settings | File Templates.
 */
public class ElectionDeleteRequest {
    private String token ;
    private int election_Id;

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public int getElection_Id() {
        return election_Id;
    }

    public void setElection_Id(int election_Id) {
        this.election_Id = election_Id;
    }
}
