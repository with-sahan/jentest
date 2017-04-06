package com.mdl.mdlrestapi.psm.model;

/**
 * Created with IntelliJ IDEA.
 * User: AnushaP
 * Date: 2/19/17
 * Time: 10:46 PM
 * To change this template use File | Settings | File Templates.
 */
public enum JWTTokenStatus {
    ACTIVE(0), INACTIVE(1);
    private int code;

    private JWTTokenStatus(int code) {
        code = code;
    }

    public int getCode() {
        return code;
    }
}
