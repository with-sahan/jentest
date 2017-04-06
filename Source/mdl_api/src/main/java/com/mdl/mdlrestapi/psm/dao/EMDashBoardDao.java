package com.mdl.mdlrestapi.psm.dao;

import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.util.SimpleRequest;
import com.mdl.mdlrestapi.util.models.*;

import java.util.ArrayList;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: AnushaP
 * Date: 3/3/17
 * Time: 2:42 PM
 * To change this template use File | Settings | File Templates.
 */
public interface EMDashBoardDao {
    /**
     * Get Ballot graph stats
     * @param token
     * @param hierarchyId
     * @return
     * @throws MDLDBException
     */
    public ArrayList<GraphBallotStatsDto> getBallotGraphStats(String token,int hierarchyId) throws MDLDBException;

    /**
     * Get Election list
     * @param hierarchyId
     * @param token
     * @return
     * @throws MDLDBException
     */
    public ArrayList<ElectionDto> getElectionList(int hierarchyId, String token) throws MDLDBException;

    /**
     * get sum of all stats
     * @param token
     * @param hierarchyId
     * @param electionId
     * @return
     * @throws MDLDBException
     */
    public List<EmDashboardGridData> getAllSumStats(String token, int hierarchyId, int electionId) throws MDLDBException;

    /**
     * Get stats
     * @param hierarchyId
     * @param token
     * @param electionId
     * @return
     * @throws MDLDBException
     */
    public ArrayList<EmDashboardDto> getStats(int hierarchyId, String token, int electionId) throws MDLDBException;

    /**
     * Get Issue count graph stats
     * @param request
     * @return
     * @throws MDLDBException
     */
    public String getIssueCountGraphStats(SimpleRequest request)throws MDLDBException;

    /**
     * Get process polling station details
     * @param token
     * @param hierarchyId
     * @return
     * @throws MDLDBException
     */
    public List<PollingStationElectionDto> getProcessPollingStationDetailsV2(String token, int hierarchyId) throws MDLDBException;

    /**
     * GetPostal Graph Stats
     * @param token
     * @param hierarchyId
     * @return
     * @throws MDLDBException
     */
    public ArrayList<GraphBallotStatsDto> getPostalGraphStats(String token, int hierarchyId)throws MDLDBException;
}
