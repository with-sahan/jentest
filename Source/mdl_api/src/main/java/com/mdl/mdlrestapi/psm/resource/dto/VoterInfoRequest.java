package com.mdl.mdlrestapi.psm.resource.dto;

/**
 * Created with IntelliJ IDEA.
 * User: AnushaP
 * Date: 2/24/17
 * Time: 10:53 PM
 * To change this template use File | Settings | File Templates.
 */
public class VoterInfoRequest {

    private String token;
    private int polling_station_id;
    private String voter_name;
    private String phone_number;
    private String companion_name;
    private String companion_address;

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public int getPolling_station_id() {
        return polling_station_id;
    }

    public void setPolling_station_id(int polling_station_id) {
        this.polling_station_id = polling_station_id;
    }

    public String getVoter_name() {
        return voter_name;
    }

    public void setVoter_name(String voter_name) {
        this.voter_name = voter_name;
    }

    public String getPhone_number() {
        return phone_number;
    }

    public void setPhone_number(String phone_number) {
        this.phone_number = phone_number;
    }

    public String getCompanion_name() {
        return companion_name;
    }

    public void setCompanion_name(String companion_name) {
        this.companion_name = companion_name;
    }

    public String getCompanion_address() {
        return companion_address;
    }

    public void setCompanion_address(String companion_address) {
        this.companion_address = companion_address;
    }
}
