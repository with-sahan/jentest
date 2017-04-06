package com.mdl.mdlrestapi.psm.resource.dto;

public class IssueNotificationRequest {
	
    private String token;
    private int issuenotificationid;

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public int getIssuenotificationid() {
        return issuenotificationid;
    }

    public void setIssuenotificationid(int issuenotificationid) {
        this.issuenotificationid = issuenotificationid;
    }

}
