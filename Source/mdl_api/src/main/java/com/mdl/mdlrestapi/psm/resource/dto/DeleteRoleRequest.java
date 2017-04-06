package com.mdl.mdlrestapi.psm.resource.dto;

/**
 * Created by Thara on 3/2/2017.
 */
public class DeleteRoleRequest {
    public String token;
    public int oldroleid;
    public int newroleid;

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public int getOldroleid() {
        return oldroleid;
    }

    public void setOldroleid(int oldroleid) {
        this.oldroleid = oldroleid;
    }

    public int getNewroleid() {
        return newroleid;
    }

    public void setNewroleid(int newroleid) {
        this.newroleid = newroleid;
    }
}
