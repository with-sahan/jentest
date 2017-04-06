package com.mdl.mdlrestapi.psm.service.impl;

import com.mdl.mdlrestapi.psm.dao.CommonDao;
import com.mdl.mdlrestapi.psm.dao.PollingStationDao;
import com.mdl.mdlrestapi.psm.dao.impl.CommonDaoImpl;
import com.mdl.mdlrestapi.psm.dao.impl.PollingStationDaoImpl;
import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.psm.resource.dto.*;
import com.mdl.mdlrestapi.psm.resource.response.dto.PrePollingActivityDTO;
import com.mdl.mdlrestapi.psm.service.PollingStationService;
import com.mdl.mdlrestapi.psm.utils.SQLUtil;

/**
 * Created with IntelliJ IDEA.
 * User: AnushaP
 * Date: 2/21/17
 * Time: 5:07 PM
 * To change this template use File | Settings | File Templates.
 */
public class PollingStationServiceImpl implements PollingStationService {

    private PollingStationDao pollingStationDao = new PollingStationDaoImpl();
    private CommonDao commonDao = new CommonDaoImpl();

    @Override
    public String getPollingStations(String token) throws MDLDBException {
        Object [] params = new Object[1];
        params[0] =  token;
        return commonDao.getResultStringArray(SQLUtil.GET_POLLING_STATIONS, params);
    }

    /**
     * Get polling station closed status
     *
     * @param token
     * @param stationId
     * @return
     * @throws com.mdl.mdlrestapi.psm.exception.MDLServiceException
     *
     * @throws com.mdl.mdlrestapi.psm.exception.MDLDBException
     *
     */
    @Override
    public String getPollingStationsClosedStatus(String token, int stationId) throws MDLDBException {
        Object [] params = new Object[2];
        params[0] =  token;
        params[1] = stationId;
        return commonDao.getResultStringObject(SQLUtil.GET_POLLING_STATION_CLOSED_STATUS, params);
    }

    /**
     * Get Elections by station
     * @param token
     * @param stationId
     * @return
     * @throws MDLDBException
     */
    @Override
    public String  getElectionsByStation(String token, int stationId) throws MDLDBException {
        Object [] params = new Object[2];
        params[0] =  token;
        params[1] = stationId;
        return commonDao.getResultStringArray(SQLUtil.GET_ELECTIONS_BY_STATION, params);
    }

    /**
     * Update pre-polling activity
     *
     * @param prePollingActivity
     * @return
     * @throws com.mdl.mdlrestapi.psm.exception.MDLDBException
     *
     */
    @Override
    public String updatePrePollingActivity(PrePollingActivity prePollingActivity) throws MDLDBException {

        Object [] params = new Object[4];
        params[0] =  prePollingActivity.getToken();
        params[1] = prePollingActivity.getPollingstationid();
        params[2] = prePollingActivity.getActivityid();
        params[3] = prePollingActivity.getStatus();
        return commonDao.getResultStringObject(SQLUtil.UPDATE_PRE_POLL_ACTIVITY, params);
    }



    /**
     * Get Polling Contact
     *
     * @param token
     * @return
     * @throws com.mdl.mdlrestapi.psm.exception.MDLDBException
     *
     */
    @Override
    public String getPollingContact(String  token) throws MDLDBException {
        Object [] params = new Object[1];
        params[0] = token;
        return commonDao.getResultStringArray(SQLUtil.GET_POLLING_CONTACT, params);
    }
    /**
     * Get Election status
     *
     * @param electionStatusRequest
     * @return
     * @throws com.mdl.mdlrestapi.psm.exception.MDLDBException
     *
     */
    @Override
    public String getElectionStatus(ElectionStatusRequest electionStatusRequest) throws MDLDBException {
        Object [] params = new Object[3];
        params[0] =  electionStatusRequest.getToken();
        params[1] = electionStatusRequest.getElectionid();
        params[2] = electionStatusRequest.getStationid();
        return commonDao.getResultStringObject(SQLUtil.GET_ELECTION_STATUS, params);

    }

    /**
     * Generate BPA
     *
     * @param electionStatusRequest
     * @return
     * @throws com.mdl.mdlrestapi.psm.exception.MDLDBException
     *
     */
    @Override
    public String generateBPA(ElectionStatusRequest electionStatusRequest) throws MDLDBException {
        Object [] params = new Object[3];
        params[0] =  electionStatusRequest.getToken();
        params[1] =  electionStatusRequest.getStationid();
        params[2] = electionStatusRequest.getElectionid();
        return commonDao.getResultStringObject(SQLUtil.GENERATE_BPA, params);

    }

    /**
     * Get Post poll activity
     *
     * @param electionStatusRequest
     * @return
     * @throws com.mdl.mdlrestapi.psm.exception.MDLDBException
     *
     */
    @Override
    public String getPostPollActivity(PostPollingActivityRequest electionStatusRequest) throws MDLDBException {
        Object [] params = new Object[3];
        params[0] =  electionStatusRequest.getToken();
        params[1] =  electionStatusRequest.getPolling_station_id();
        params[2] =  electionStatusRequest.getElectionid();
        PrePollingActivityDTO prePollingActivityDTO = new PrePollingActivityDTO();
        return commonDao.getResultStringByDto(SQLUtil.GET_POST_POLL_ACTIVITIES, params, prePollingActivityDTO);

    }


    @Override
    public String getBPAStationByStation(StationRequest stationRequest) throws MDLDBException{

        Object [] params = new Object[2];
        params[0] =  stationRequest.getToken();
        params[1] =  stationRequest.getStationid();
        return commonDao.getResultStringObject(SQLUtil.GET_BPA_STATUS_BY_STATION, params);

    }

    /**
     * Get BPA Status
     *
     * @param stationRequest
     * @return
     * @throws com.mdl.mdlrestapi.psm.exception.MDLDBException
     *
     */
    @Override
    public String getBPAStatus(ElectionStatusRequest stationRequest) throws MDLDBException {
        Object [] params = new Object[3];
        params[0] =  stationRequest.getToken();
        params[1] =  stationRequest.getStationid();
        params[2] =  stationRequest.getElectionid();

        return commonDao.getResultStringObject(SQLUtil.GET_BPA_STATUS, params);
    }



    /**
     * Colse station
     *
     * @param pollingStationRequest
     * @return
     * @throws com.mdl.mdlrestapi.psm.exception.MDLDBException
     *
     */
    @Override
    public String closePollingStation(PollingStationRequest pollingStationRequest) throws MDLDBException {

        Object [] params = new Object[3];
        params[0] =  pollingStationRequest.getToken();
        params[1] =  pollingStationRequest.getPollingstationid();
        return commonDao.getResultStringObject(SQLUtil.CLOSE_POLLING_STATION, params);
    }

    /**
     * Get pre polling activities
     *
     * @param prePollingActivity
     * @return
     * @throws com.mdl.mdlrestapi.psm.exception.MDLDBException
     *
     */
    @Override
    public String getPrePollActivity(PrePollingActivity prePollingActivity) throws MDLDBException {

        Object [] params = new Object[2];
        params[0] =  prePollingActivity.getToken();
        params[1] = prePollingActivity.getPollingstationid();
        PrePollingActivityDTO prePollingActivityDTO = new PrePollingActivityDTO();
        return commonDao.getResultStringByDto(SQLUtil.GET_PRE_POLL_ACTIVITY, params, prePollingActivityDTO);

    }

	@Override
	public String openPollingStation(PollingStationRequest request) throws MDLDBException {
        Object [] params = new Object[2];
        params[0] =  request.getToken();
        params[1] =  request.getPollingstationid();
        return commonDao.getResultStringObject(SQLUtil.OPEN_POLLING_STATION, params);
	}

    /**
     * Update Station close stat
     *
     * @param request
     * @return
     * @throws com.mdl.mdlrestapi.psm.exception.MDLDBException
     *
     */
    @Override
    public String updateStationCloseStat(CloseStationStatRequest request) throws MDLDBException {
        Object [] params = new Object[9];
        params[0] =  request.getToken();
        params[1] =  request.getElectionid();
        params[2] =  request.getTot_ballots();
        params[3] =  request.getTot_spoiled_replaced();
        params[4] =  request.getTot_unused();
        params[5] =  request.getTot_tend_ballots();
        params[6] =  request.getTot_tend_spoiled();
        params[7] =  request.getTot_tend_unused();
        params[8] =  request.getPollingstationid();
        return commonDao.getResultStringObject(SQLUtil.UPDATE_CLOSE_STATION_STAT, params);
    }

	@Override
	public String completeProgressSequence(PollingStationRequest request) throws MDLDBException {
        Object [] params = new Object[2];
        params[0] =  request.getToken();
        params[1] =  request.getPollingstationid();
        return commonDao.getResultStringObject(SQLUtil.COMPLETE_PROGRESS_SEQUENCE, params);
	}

    /**
     * Polling stations by Station id
     *
     * @param request
     * @return
     * @throws com.mdl.mdlrestapi.psm.exception.MDLDBException
     *
     */
    @Override
    public String getPollingStationByStationId(StationRequest request) throws MDLDBException {
        Object [] params = new Object[2];
        params[0] =  request.getToken();
        params[1] =  request.getStationid();
        return commonDao.getResultStringObject(SQLUtil.GET_STATION_BY_STATION_ID, params);
    }

    /**
     * Update Station
     *
     * @param request
     * @return
     * @throws com.mdl.mdlrestapi.psm.exception.MDLDBException
     *
     */
    @Override
    public String updateStation(StationUpdateRequest request) throws MDLDBException {
        Object [] params = new Object[5];
        params[0] =  request.getToken();
        params[1] =  request.getStationid();
        params[2] =  request.getElectionid();
        params[3] =  request.getBoxnumber();
        params[4] =  request.getStationname();
        return commonDao.getResultStringObject(SQLUtil.UPDATE_STATION, params);
    }

    /**
     * Get progress
     *
     * @param request
     * @return
     * @throws com.mdl.mdlrestapi.psm.exception.MDLDBException
     *
     */
    @Override
    public String getProgress(BallotCloseStatRequest request) throws MDLDBException {
        Object [] params = new Object[3];
        params[0] =  request.getToken();
        params[1] =  request.getElectionid();
        params[2] =  request.getPollingstationid();
        return commonDao.getResultStringObject(SQLUtil.GET_PROGRESS, params);
    }

    /**
     * Update progress
     *
     * @param request
     * @return
     * @throws com.mdl.mdlrestapi.psm.exception.MDLDBException
     *
     */
    @Override
    public String updateProgress(UpdateProgressRequest request) throws MDLDBException {
        Object [] params = new Object[6];
        params[0] =  request.getToken();
        params[1] =  request.getElectionid();
        params[2] =  request.getPollingstationid();
        params[3] =  request.getBallotpapers();
        params[4] =  request.getPostalpacks();
        params[5] =  request.getPostalpackscollected();
        return commonDao.getResultStringObject(SQLUtil.UPDATE_PROGRESS, params);
    }
}
