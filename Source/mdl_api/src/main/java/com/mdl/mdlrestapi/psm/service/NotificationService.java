package com.mdl.mdlrestapi.psm.service;

import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.psm.resource.dto.TokenRequest;
import com.mdl.mdlrestapi.util.models.NotificationDto;
import com.mdl.mdlrestapi.util.models.NotificationResultDto;
import com.mdl.mdlrestapi.util.models.PollingStationDto;

import java.io.InputStream;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 * Created with IntelliJ IDEA.
 * User: AnushaP
 * Date: 2/24/17
 * Time: 2:35 PM
 * To change this template use File | Settings | File Templates.
 */
public interface NotificationService {

    /**
     * Get notification pulse
     * @param token
     * @return
     * @throws MDLDBException
     */
    public String getNotificationPulse(String token)throws MDLDBException;

    /**
     * Get Top notifications
     * @param token
     * @return
     * @throws MDLDBException
     */
    public String getNotificationTop(String token)throws MDLDBException;

    /**
     * Get All notifications
     * @param token
     * @return
     * @throws MDLDBException
     */
    public String getNotificationAll(String token)throws MDLDBException;

    /**
     * Read Notification
     * @param token
     * @param notificationId
     * @return
     * @throws MDLDBException
     */
    public String getNotificationRead(String token, int notificationId)throws MDLDBException;
    
    /**
     * @param request
     * @return
     * @throws MDLDBException
     */
    public String getNotificationCount(TokenRequest request) throws MDLDBException;

    /**
     * Read Notification
     * @param token
     * @param notificationId
     * @return
     * @throws MDLDBException
     */
    public String getNotificationById(String token, int notificationId)throws MDLDBException;

    /**
     * Get global notifications
     * @param token
     * @return
     * @throws MDLDBException
     */
    public String getGlobalNotifications(String token)throws MDLDBException;

    /**
     * @param uploadedInputStream
     * @param relativePath
     */
    public void writeToFile(InputStream uploadedInputStream,
                            String relativePath);

    /**
     * @param hierarchyId
     * @param token
     * @return
     * @throws Exception
     */
    public ArrayList<NotificationDto> getFilteredResults(int hierarchyId, String token) throws Exception;

    /**
     * @param uploadedFileLocation
     * @param station_id
     * @param hierarchyId
     * @param description
     * @param token
     * @throws Exception
     */
    public void saveToDbNotification(String uploadedFileLocation,String station_id, String hierarchyId, String description, String token) throws Exception;

    /**
     * @param orgId
     * @param stationId
     * @return
     * @throws SQLException
     */
    public ArrayList<Integer> getUserIdList(int orgId, int stationId) throws Exception;

    /**
     * @param hierarchyId
     * @param orgId
     * @return
     * @throws Exception
     */
    public String getAllPollingStationList(int hierarchyId,int orgId) throws Exception;

    /**
     * @param hierarchyId
     * @param token
     * @return
     * @throws Exception
     */
    public ArrayList<PollingStationDto> getActivePollingStationList(int hierarchyId, String token) throws Exception;

    /**
     * @param hierarchyId
     * @param token
     * @return
     * @throws Exception
     */
    public String getActivePollingStationListString(int hierarchyId,String token) throws Exception;

    /**
     * @param stationList
     * @param orgId
     * @return
     * @throws Exception
     */
    public String getActiveUserListForStationList(String stationList,int orgId) throws Exception;

    /**
     * @param stationList
     * @param orgId
     * @return
     * @throws Exception
     */
    public ArrayList<Integer> getActiveUserIdArrayForStationList(String stationList,int orgId) throws Exception;

}
