package com.mdl.mdlrestapi.psm.resource.dto;

/**
 * Created with IntelliJ IDEA.
 * User: AnushaP
 * Date: 3/1/17
 * Time: 2:41 PM
 * To change this template use File | Settings | File Templates.
 */
public class ElectionCreateUpdateRequest {

    private String token;
    private int election_id ;
    private String ename;
    private String election_date ;
    private String start_time;
    private String end_time;
    private String counting_center_name;
    private String counting_center_address ;
    private String counting_center_latitude ;
    private String counting_center_longitude;
    public String  BPA_identifier ;
    private int ballot_type_count ;

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public int getElection_id() {
        return election_id;
    }

    public void setElection_id(int election_id) {
        this.election_id = election_id;
    }

    public String getEname() {
        return ename;
    }

    public void setEname(String ename) {
        this.ename = ename;
    }

    public String getElection_date() {
        return election_date;
    }

    public void setElection_date(String election_date) {
        this.election_date = election_date;
    }

    public String getStart_time() {
        return start_time;
    }

    public void setStart_time(String start_time) {
        this.start_time = start_time;
    }

    public String getEnd_time() {
        return end_time;
    }

    public void setEnd_time(String end_time) {
        this.end_time = end_time;
    }

    public String getCounting_center_name() {
        return counting_center_name;
    }

    public void setCounting_center_name(String counting_center_name) {
        this.counting_center_name = counting_center_name;
    }

    public String getCounting_center_address() {
        return counting_center_address;
    }

    public void setCounting_center_address(String counting_center_address) {
        this.counting_center_address = counting_center_address;
    }

    public String getCounting_center_latitude() {
        return counting_center_latitude;
    }

    public void setCounting_center_latitude(String counting_center_latitude) {
        this.counting_center_latitude = counting_center_latitude;
    }

    public String getCounting_center_longitude() {
        return counting_center_longitude;
    }

    public void setCounting_center_longitude(String counting_center_longitude) {
        this.counting_center_longitude = counting_center_longitude;
    }

    public int getBallot_type_count() {
        return ballot_type_count;
    }

    public void setBallot_type_count(int ballot_type_count) {
        this.ballot_type_count = ballot_type_count;
    }
}
