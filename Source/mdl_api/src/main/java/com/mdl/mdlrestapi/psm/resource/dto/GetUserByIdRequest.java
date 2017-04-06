package com.mdl.mdlrestapi.psm.resource.dto;

/**
 * Created by Thara on 3/1/2017.
 */
public class GetUserByIdRequest {
    public String token;
    public int userid;

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public int getUserid() {
        return userid;
    }

    public void setUserid(int userid) {
        this.userid = userid;
    }
}
