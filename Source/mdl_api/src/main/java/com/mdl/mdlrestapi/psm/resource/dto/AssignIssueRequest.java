package com.mdl.mdlrestapi.psm.resource.dto;

/**
 * Created by Thara on 3/12/2017.
 */
public class AssignIssueRequest {
    private String token;
    private int issueId;
    private int userId;

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public int getIssueId() {
        return issueId;
    }

    public void setIssueId(int issueId) {
        this.issueId = issueId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }
}
