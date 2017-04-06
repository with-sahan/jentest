package com.mdl.mdlrestapi.psm.resource.dto;

/**
 * Created by Thara on 3/2/2017.
 */
public class GetRoleByIdRequest {
    public String token;
    public int roleid;

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public int getRoleid() {
        return roleid;
    }

    public void setRoleid(int roleid) {
        this.roleid = roleid;
    }
}
