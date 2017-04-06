package com.mdl.mdlrestapi.psm.service;

import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.util.SimpleRequest;
import com.mdl.mdlrestapi.util.models.*;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: AnushaP
 * Date: 3/3/17
 * Time: 2:14 PM
 * To change this template use File | Settings | File Templates.
 */
public interface EMDashBoardService {
    /**
     * Get Ballot Graph Stats
     * @param token
     * @param hierarchyId
     * @return
     * @throws MDLDBException
     */
    public ArrayList<GraphBallotStatsDto> getBallotGraphStats(String token, int hierarchyId) throws MDLDBException;

    /**
     * Get Election List
     * @param hierarchyId
     * @param token
     * @return
     * @throws SQLException
     * @throws Exception
     */
    public ArrayList<ElectionDto> getElectionList(int hierarchyId, String token) throws SQLException, Exception;

    /**
     * Get sum of all stats
     * @param token
     * @param hierarchyId
     * @param electionId
     * @return
     */
    public List<EmDashboardGridData> getAllSumStats(String token, int hierarchyId, int electionId) throws Exception;

    /**
     * Get Stats
     * @param hierarchyId
     * @param token
     * @param electionId
     * @return
     * @throws Exception
     */
    public ArrayList<EmDashboardDto> getStats(int hierarchyId, String token, int electionId) throws Exception;

    /**
     *  Get Issue count stats
     * @param request
     * @return
     * @throws Exception
     */
    public String getIssueCountGraphStats(SimpleRequest request) throws Exception;

    /**
     * Get processed polling stations details
     * @param token
     * @param hierarchyId
     * @return
     * @throws Exception
     */
    public List<PollingStationElectionDto> processGetPollingStationDetails_v2(String token, int hierarchyId) throws Exception;

    /**
     * Get postal graph stats
     * @param token
     * @param hierarchyId
     * @return
     * @throws Exception
     */
    public ArrayList<GraphBallotStatsDto> getPostalGraphStats(String token,int hierarchyId) throws Exception;
}
