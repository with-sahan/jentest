package com.mdl.mdlrestapi.psm.model;

import java.sql.Timestamp;

/**
 * Created with IntelliJ IDEA.
 * User: AnushaP
 * Date: 2/16/17
 * Time: 2:17 PM
 * To change this template use File | Settings | File Templates.
 */
public class JWTAccessToken {

    private int id;
    private String userName;
    private String organizationCode;
    private String token;
    private int status;
    private Timestamp timeCreated;
    private int validity;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getOrganizationCode() {
        return organizationCode;
    }

    public void setOrganizationCode(String organizationCode) {
        this.organizationCode = organizationCode;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public Timestamp getTimeCreated() {
        return timeCreated;
    }

    public void setTimeCreated(Timestamp timeCreated) {
        this.timeCreated = timeCreated;
    }

    public int getValidity() {
        return validity;
    }

    public void setValidity(int validity) {
        this.validity = validity;
    }
}
