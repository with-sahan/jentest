package com.mdl.mdlrestapi.psm.resource.dto;

/**
 * Created by lasantha on 3/2/2017.
 */
public class PsiCheckListRequest {
    private String token;
    private int place_id;

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public int getPlace_id() {
        return place_id;
    }

    public void setPlace_id(int place_id) {
        this.place_id = place_id;
    }
}
