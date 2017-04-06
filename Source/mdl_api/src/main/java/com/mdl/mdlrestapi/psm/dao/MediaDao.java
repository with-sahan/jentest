package com.mdl.mdlrestapi.psm.dao;

import com.mdl.mdlrestapi.psm.exception.MDLDBException;

/**
 * Created by lasantha on 3/9/2017.
 */
public interface MediaDao {

    /**
     * @param uploadedFileLocation
     * @param stationId
     * @param token
     * @throws MDLDBException
     */
    public void saveToDbCamera(String uploadedFileLocation,String stationId,String token) throws MDLDBException;

    /**
     * @param uploadedFileLocation
     * @param notification_id
     * @param token
     * @throws MDLDBException
     */
    public void saveToDbNotification(String uploadedFileLocation, String notification_id, String token) throws MDLDBException;

    /**
     * @param token
     * @return
     * @throws MDLDBException
     */
    public int getCsvStructureId(String token) throws MDLDBException;

}
