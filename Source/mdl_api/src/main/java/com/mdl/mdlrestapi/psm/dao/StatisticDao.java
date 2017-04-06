package com.mdl.mdlrestapi.psm.dao;

import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.util.models.CloseStatsDto;
import com.mdl.mdlrestapi.util.models.CloseStatsSummeryDto;

import java.util.ArrayList;

/**
 * Created by lasantha on 3/8/2017.
 */
public interface StatisticDao {

    /**
     * @param token
     * @param electionId
     * @param hierarchyId
     * @return
     * @throws MDLDBException
     */
    public ArrayList<CloseStatsSummeryDto> getAllCloseStatsSummery(String token, int electionId, int hierarchyId) throws MDLDBException;

    /**
     * @param token
     * @param electionId
     * @return
     * @throws MDLDBException
     */
    public String updateAllCloseStats(String token,int electionId) throws MDLDBException;

    /**
     * @param token
     * @param electionId
     * @param hierarchyId
     * @return
     * @throws MDLDBException
     */
    public ArrayList<CloseStatsDto> getAllCloseStats(String token, int electionId, int hierarchyId) throws MDLDBException;

    /**
     * @param token
     * @param electionId
     * @param hierarchyId
     * @return
     * @throws MDLDBException
     */
    public ArrayList<CloseStatsDto> getUnexportedAllCloseStats(String token,int electionId,int hierarchyId) throws MDLDBException;


}
