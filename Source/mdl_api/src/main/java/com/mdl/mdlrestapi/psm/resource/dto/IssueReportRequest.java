package com.mdl.mdlrestapi.psm.resource.dto;

/**
 * Created with IntelliJ IDEA.
 * User: AnushaP
 * Date: 2/24/17
 * Time: 9:00 PM
 * To change this template use File | Settings | File Templates.
 */
public class IssueReportRequest {

    private String token;
    private int electionid;
    private int pollingstationid;
    private int issueid;
    private String description;
    private int priority;

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

    public int getPriority() {
        return priority;
    }

    public void setPriority(int priority) {
        this.priority = priority;
    }
}
