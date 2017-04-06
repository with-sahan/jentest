package com.mdl.mdlrestapi.psm.resource.dto;

/**
 * Created by lasantha on 3/1/2017.
 */
public class IssueDescriptionRequest {
    private String token;
    private int issueid;
    private String description;

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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
