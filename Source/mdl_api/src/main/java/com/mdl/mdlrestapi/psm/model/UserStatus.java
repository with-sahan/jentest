package com.mdl.mdlrestapi.psm.model;

/**
 * Created with IntelliJ IDEA.
 * User: AnushaP
 * Date: 3/13/17
 * Time: 12:12 PM
 * To change this template use File | Settings | File Templates.
 */
public enum UserStatus {
    ACTIVE(0), INACTIVE(1);
    private int code;

    private UserStatus(int code) {
        code = code;
    }

    public int getCode() {
        return code;
    }
}
