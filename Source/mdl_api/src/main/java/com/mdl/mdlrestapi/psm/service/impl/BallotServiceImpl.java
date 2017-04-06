package com.mdl.mdlrestapi.psm.service.impl;

import com.mdl.mdlrestapi.psm.dao.BallotDao;
import com.mdl.mdlrestapi.psm.dao.CommonDao;
import com.mdl.mdlrestapi.psm.dao.impl.BallotDaoImpl;
import com.mdl.mdlrestapi.psm.dao.impl.CommonDaoImpl;
import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.psm.resource.dto.BallotCloseStatRequest;
import com.mdl.mdlrestapi.psm.resource.dto.ElectionRequest;
import com.mdl.mdlrestapi.psm.resource.dto.ElectionStatusRequest;
import com.mdl.mdlrestapi.psm.service.BallotService;
import com.mdl.mdlrestapi.psm.utils.SQLUtil;

/**
 * Created with IntelliJ IDEA.
 * User: AnushaP
 * Date: 2/23/17
 * Time: 12:45 PM
 * To change this template use File | Settings | File Templates.
 */
public class BallotServiceImpl implements BallotService {

    BallotDao ballotDao = new BallotDaoImpl();
    CommonDao commonDao = new CommonDaoImpl();
    /**
     * Get Ballot type count
     *
     * @param electionStatusRequest
     * @return
     * @throws com.mdl.mdlrestapi.psm.exception.MDLDBException
     *
     */
    @Override
    public String getBallotTypeCount(ElectionRequest electionStatusRequest) throws MDLDBException {

        Object [] params = new Object[2];
        params[0] =  electionStatusRequest.getToken();
        params[1] =  electionStatusRequest.getElectionid();
        return commonDao.getResultStringObject(SQLUtil.GET_BALLOT_TYPE_COUNT, params);
    }

    /**
     * Get ballet papers
     *
     * @param electionRequest
     * @return
     * @throws com.mdl.mdlrestapi.psm.exception.MDLDBException
     *
     */
    @Override
    public String getBallotPapers(ElectionRequest electionRequest) throws MDLDBException {
        Object [] params = new Object[2];
        params[0] =  electionRequest.getToken();
        params[1] =  electionRequest.getElectionid();
        return commonDao.getResultStringObject(SQLUtil.GET_BALLOT_PAPER_NAMES, params);
    }

    /**
     * Get Ballot close status
     *
     * @param electionRequest
     * @return
     * @throws com.mdl.mdlrestapi.psm.exception.MDLDBException
     *
     */
    @Override
    public String getBallotCloseStat(BallotCloseStatRequest electionRequest) throws MDLDBException {
        Object [] params = new Object[3];
        params[0] =  electionRequest.getToken();
        params[1] =  electionRequest.getElectionid();
        params[2] = electionRequest.getPollingstationid();

        return commonDao.getResultStringObject(SQLUtil.GET_BALLOT_CLOSE_STAT, params) ;
    }

    /**
     * Get All close status
     *
     * @param electionRequest
     * @return
     * @throws com.mdl.mdlrestapi.psm.exception.MDLDBException
     *
     */
    @Override
    public String getAllCloseStat(ElectionRequest electionRequest) throws MDLDBException {
        Object [] params = new Object[2];
        params[0] =  electionRequest.getToken();
        params[1] =  electionRequest.getElectionid();

        return commonDao.getResultStringObject(SQLUtil.GET_ALL_CLOSE_STAT_V2, params) ;
    }

    /**
     * Get All close stat summary
     *
     * @param electionRequest
     * @return
     * @throws com.mdl.mdlrestapi.psm.exception.MDLDBException
     *
     */
    @Override
    public String getAllCloseStatSummary(ElectionRequest electionRequest) throws MDLDBException {
        Object [] params = new Object[2];
        params[0] =  electionRequest.getToken();
        params[1] =  electionRequest.getElectionid();

        return commonDao.getResultStringObject(SQLUtil.GET_ALL_CLOSE_STAT_SUMMARY, params) ;
    }

    /**
     * csv Ballot Account Export
     *
     * @param electionRequest
     * @return
     * @throws com.mdl.mdlrestapi.psm.exception.MDLDBException
     *
     */
    @Override
    public String csvBallotAccExport(ElectionRequest electionRequest) throws MDLDBException {
        Object [] params = new Object[2];
        params[0] =  electionRequest.getToken();
        params[1] =  electionRequest.getElectionid();

        return commonDao.getResultStringObject(SQLUtil.CSV_BALLOT_ACCOUNT_EXPORT, params) ;
    }
}
