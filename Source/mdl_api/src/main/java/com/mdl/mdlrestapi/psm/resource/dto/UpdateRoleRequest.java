package com.mdl.mdlrestapi.psm.resource.dto;

/**
 * Created by Thara on 3/2/2017.
 */
public class UpdateRoleRequest {
    public String token;
    public int roleid;
    public String rolename;
    public String description;

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

    public String getRolename() {
        return rolename;
    }

    public void setRolename(String rolename) {
        this.rolename = rolename;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
