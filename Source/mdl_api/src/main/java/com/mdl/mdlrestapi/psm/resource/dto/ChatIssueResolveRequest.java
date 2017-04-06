package com.mdl.mdlrestapi.psm.resource.dto;

/**
 * Created with IntelliJ IDEA.
 * User: AnushaP
 * Date: 2/24/17
 * Time: 8:07 PM
 * To change this template use File | Settings | File Templates.
 */
public class ChatIssueResolveRequest {
   private String token;
   private int  issueid;
   private int issuestatus;
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

    public int getIssuestatus() {
        return issuestatus;
    }

    public void setIssuestatus(int issuestatus) {
        this.issuestatus = issuestatus;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
