package com.mdl.mdlrestapi.psm.resource.dto;

/**
 * Created by lasantha on 3/1/2017.
 */
public class UserIssueRequest {
    private String token;
    private int issueid;

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public int getIssueid() {
        return issueid;
    }

    public void setIssueid(int issueid) {
        this.issueid = issueid;
    }
}
