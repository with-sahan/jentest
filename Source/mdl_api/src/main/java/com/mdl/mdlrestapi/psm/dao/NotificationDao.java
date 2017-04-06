package com.mdl.mdlrestapi.psm.dao;

import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.util.models.NotificationDto;
import com.mdl.mdlrestapi.util.models.NotificationResultDto;
import com.mdl.mdlrestapi.util.models.PollingStationDto;

import java.sql.SQLException;
import java.util.ArrayList;

/**
 * Created by lasantha on 3/13/2017.
 */
public interface NotificationDao {
    /**
     *
     * @param hierarchyId
     * @param token
     * @return
     * @throws MDLDBException
     */
    public ArrayList<NotificationDto> getFilteredResults(int hierarchyId, String token) throws MDLDBException;

    /**
     *
     * @param uploadedFileLocation
     * @param station_id
     * @param hierarchyId
     * @param description
     * @param token
     * @throws MDLDBException
     */
    public void saveToDbNotification(String uploadedFileLocation,String station_id,String hierarchyId,String description, String token) throws MDLDBException;

    /**
     *
     * @param orgId
     * @param stationId
     * @return
     * @throws MDLDBException
     */
    public ArrayList<Integer> getUserIdList(int orgId, int stationId) throws MDLDBException;

    /**
     *
     * @param hierarchyId
     * @param orgId
     * @return
     * @throws MDLDBException
     */
    public String getAllPollingStationList(int hierarchyId,int orgId) throws MDLDBException;

    /**
     *
     * @param hierarchyId
     * @param token
     * @return
     * @throws MDLDBException
     */
    public ArrayList<PollingStationDto> getActivePollingStationList(int hierarchyId, String token) throws MDLDBException;

    /**
     *
     * @param hierarchyId
     * @param token
     * @return
     * @throws MDLDBException
     */
    public String getActivePollingStationListString(int hierarchyId,String token) throws MDLDBException;

    /**
     *
     * @param stationList
     * @param orgId
     * @return
     * @throws MDLDBException
     */
    public String getActiveUserListForStationList(String stationList,int orgId) throws MDLDBException;

    /**
     *
     * @param stationList
     * @param orgId
     * @return
     * @throws MDLDBException
     */
    public ArrayList<Integer> getActiveUserIdArrayForStationList(String stationList,int orgId) throws MDLDBException;

}
