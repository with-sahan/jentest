package com.mdl.mdlrestapi.psm.resource.dto;

/**
 * Created with IntelliJ IDEA.
 * User: AnushaP
 * Date: 2/24/17
 * Time: 3:25 PM
 * To change this template use File | Settings | File Templates.
 */
public class NotificationRequest {
    private String token;
    private int notification_id;

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public int getNotification_id() {
        return notification_id;
    }

    public void setNotification_id(int notification_id) {
        this.notification_id = notification_id;
    }
}
