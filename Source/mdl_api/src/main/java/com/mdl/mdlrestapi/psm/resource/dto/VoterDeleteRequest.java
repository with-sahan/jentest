package com.mdl.mdlrestapi.psm.resource.dto;

/**
 * Created with IntelliJ IDEA.
 * User: AnushaP
 * Date: 2/24/17
 * Time: 11:08 PM
 * To change this template use File | Settings | File Templates.
 */
public class VoterDeleteRequest {
    private String token;
    private int voter_list_id;

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public int getVoter_list_id() {
        return voter_list_id;
    }

    public void setVoter_list_id(int voter_list_id) {
        this.voter_list_id = voter_list_id;
    }
}
