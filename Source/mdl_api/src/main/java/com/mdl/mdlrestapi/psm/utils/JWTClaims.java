package com.mdl.mdlrestapi.psm.utils;

import java.util.Date;

/**
 * Created with IntelliJ IDEA.
 * User: AnushaP
 * Date: 2/17/17
 * Time: 12:06 PM
 * To change this template use File | Settings | File Templates.
 */
public class JWTClaims {
    private String issuer;
    private String subject;
    private long expiration;
    private String name;
    private String organization;
    private int roleId;

    public String getIssuer() {
        return issuer;
    }

    public void setIssuer(String issuer) {
        this.issuer = issuer;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public long getExpiration() {
        return expiration;
    }

    public void setExpiration(long expiration) {
        this.expiration = expiration;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getOrganization() {
        return organization;
    }

    public void setOrganization(String organization) {
        this.organization = organization;
    }

    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }
}
