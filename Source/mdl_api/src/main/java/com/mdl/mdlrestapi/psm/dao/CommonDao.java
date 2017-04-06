package com.mdl.mdlrestapi.psm.dao;

import java.util.List;

import com.mdl.mdlrestapi.psm.exception.MDLDBException;

public interface CommonDao {

    /**
     *
     * @param query
     * @param objects
     * @return
     * @throws MDLDBException
     */
	public String getResultStringArray(String query,Object[] objects) throws MDLDBException;

    /**
     *
     * @param query
     * @param objects
     * @return
     * @throws MDLDBException
     */
    public String getResultStringObject(String query,Object[] objects) throws MDLDBException;

    /**
     *
     * @param query
     * @param objects
     * @param resultDto
     * @param <T>
     * @return
     * @throws MDLDBException
     */
    public <T> String getResultStringByDto(String query,Object[] objects,T resultDto)  throws MDLDBException;
    
    /**
     * @param resultDto
     * @return
     * @throws MDLDBException
     */
    public <T> List<T> getResultListByDto(String Query, T resultDto) throws MDLDBException;

    /**
     * Get all station list based on the logged user
     * @param hierarchyId
     * @param orgId
     * @param userId
     * @return
     * @throws MDLDBException
     */
    public String getPollingStationList(int hierarchyId, int orgId, int userId) throws MDLDBException;

}
