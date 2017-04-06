package com.mdl.mdlrestapi.psm.resource.dto;

/**
 * Created with IntelliJ IDEA.
 * User: AnushaP
 * Date: 3/1/17
 * Time: 9:58 PM
 * To change this template use File | Settings | File Templates.
 */
public class ElectionFileUploadStatusRequest {
    private int eid ;
    private String token;

    public int getEid() {
        return eid;
    }

    public void setEid(int eid) {
        this.eid = eid;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }
}
