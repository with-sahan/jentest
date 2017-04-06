package com.mdl.mdlrestapi.psm.service.impl;

import java.util.ArrayList;
import java.util.List;

import com.mdl.mdlrestapi.psm.dao.CommonDao;
import com.mdl.mdlrestapi.psm.dao.EMDashBoardDao;
import com.mdl.mdlrestapi.psm.dao.impl.CommonDaoImpl;
import com.mdl.mdlrestapi.psm.dao.impl.EMDashBoardDaoImpl;
import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.psm.service.EMDashBoardService;
import com.mdl.mdlrestapi.util.SimpleRequest;
import com.mdl.mdlrestapi.util.models.*;

/**
 * Created with IntelliJ IDEA.
 * User: AnushaP
 * Date: 3/3/17
 * Time: 2:14 PM
 * To change this template use File | Settings | File Templates.
 */
public class EMDashBoardServiceImpl implements EMDashBoardService {
    CommonDao commonDao = new CommonDaoImpl();
    EMDashBoardDao dashBoardDao = new EMDashBoardDaoImpl();

    @Override
    public ArrayList<GraphBallotStatsDto> getBallotGraphStats(String token, int hierarchyId) throws MDLDBException {
          try {
            return dashBoardDao.getBallotGraphStats(token, hierarchyId) ;
        } catch (Exception e) {
            throw new MDLDBException(e.getMessage()) ;
        }
     }

    @Override
    public ArrayList<ElectionDto> getElectionList(int hierarchyId, String token) throws Exception {
        return dashBoardDao.getElectionList(hierarchyId, token);  //To change body of implemented methods use File | Settings | File Templates.
    }

    /**
     * Get sum of all stats
     *
     * @param token
     * @param hierarchyId
     * @param electionId
     * @return
     */
    @Override
    public List<EmDashboardGridData> getAllSumStats(String token, int hierarchyId, int electionId) throws Exception {
        return dashBoardDao.getAllSumStats(token, hierarchyId, electionId);
    }

    /**
     * Get Stats
     *
     * @param hierarchyId
     * @param token
     * @param electionId
     * @return
     * @throws Exception
     */
    @Override
    public ArrayList<EmDashboardDto> getStats(int hierarchyId, String token, int electionId) throws Exception {
        return dashBoardDao.getStats(hierarchyId, token, electionId) ;
    }

    /**
     * Get Issue count stats
     *
     * @param request
     * @return
     * @throws Exception
     */
    @Override
    public String getIssueCountGraphStats(SimpleRequest request) throws Exception {
        return dashBoardDao.getIssueCountGraphStats(request);
    }

    /**
     * Get processed polling stations details
     *
     * @param token
     * @param hierarchyId
     * @return
     * @throws Exception
     */
    @Override
    public List<PollingStationElectionDto> processGetPollingStationDetails_v2(String token, int hierarchyId) throws Exception {
        return dashBoardDao.getProcessPollingStationDetailsV2(token, hierarchyId);
    }

    /**
     * Get postal graph stats
     *
     * @param token
     * @param hierarchyId
     * @return
     * @throws Exception
     */
    @Override
    public ArrayList<GraphBallotStatsDto> getPostalGraphStats(String token, int hierarchyId) throws Exception {
        return dashBoardDao.getPostalGraphStats(token, hierarchyId);  //To change body of implemented methods use File | Settings | File Templates.
    }

}
