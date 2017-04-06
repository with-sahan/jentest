package com.mdl.mdlrestapi.psm.resource.dto;

/**
 * Created by Thara on 3/2/2017.
 */
public class PasswordUpdateRequest {
    public String token;
    public int userid;
    public String newpass;
    public String adminpass;

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

    public String getNewpass() {
        return newpass;
    }

    public void setNewpass(String newpass) {
        this.newpass = newpass;
    }

    public String getAdminpass() {
        return adminpass;
    }

    public void setAdminpass(String adminpass) {
        this.adminpass = adminpass;
    }
}
