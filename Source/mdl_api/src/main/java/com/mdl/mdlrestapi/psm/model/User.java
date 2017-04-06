package com.mdl.mdlrestapi.psm.model;

/**
 * Created with IntelliJ IDEA.
 * User: AnushaP
 * Date: 3/9/17
 * Time: 6:22 PM
 * To change this template use File | Settings | File Templates.
 */
public class User {
    private String username;
    private int roleId;
    private int status ;

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
}
