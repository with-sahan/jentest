package com.mdl.mdlrestapi.psm.service.impl;

import com.mdl.mdlrestapi.psm.dao.CommonDao;
import com.mdl.mdlrestapi.psm.dao.ElectionDao;
import com.mdl.mdlrestapi.psm.dao.impl.CommonDaoImpl;
import com.mdl.mdlrestapi.psm.dao.impl.ElectionDaoImpl;
import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.psm.resource.dto.*;
import com.mdl.mdlrestapi.psm.service.ElectionService;
import com.mdl.mdlrestapi.psm.utils.SQLUtil;
import com.mdl.mdlrestapi.util.SimpleRequest;
import com.mdl.mdlrestapi.util.models.ActivationDayRequest;
import org.json.JSONObject;

public class ElectionServiceImpl implements ElectionService {
	
	private CommonDao commonDao = new CommonDaoImpl();
    private ElectionDao electionDao = new ElectionDaoImpl();

	@Override
	public String getElectionByID(ElectionRequest request) throws MDLDBException {
        Object [] params = new Object[2];
        params[0] =  request.getToken();
        params[1] =  request.getElectionid();
        return commonDao.getResultStringObject(SQLUtil.GET_ELECTION_BY_ID, params);
	}

	@Override
	public String closeElection(CloseElectionRequest request) throws MDLDBException {
        Object [] params = new Object[4];
        params[0] =  request.getToken();
        params[1] =  request.getElectionid();
        params[2] =  request.getPollingstationid();
        params[3] =  request.getElectionstatus();
        return commonDao.getResultStringObject(SQLUtil.CLOSE_ELECTION, params);
	}

    /**
     * Update Election
     *
     * @param request
     * @return
     * @throws com.mdl.mdlrestapi.psm.exception.MDLDBException
     *
     */
    @Override
    public String updateElection(ElectionCreateUpdateRequest request) throws MDLDBException {
        Object [] params = new Object[12];
        params[0] =  request.getToken();
        params[1] =  request.getElection_id();
        params[2] =  request.getEname();
        params[3] =  request.getElection_date();
        params[4] =  request.getStart_time();
        params[5] =  request.getEnd_time();
        params[6] =  request.getCounting_center_name();
        params[7] =  request.getCounting_center_address();
        params[8] =  request.getCounting_center_latitude();
        params[9] =  request.getCounting_center_longitude();
        params[10] =  Integer.valueOf(request.BPA_identifier);
        params[11] =  request.getBallot_type_count();
        return commonDao.getResultStringObject(SQLUtil.UPDATE_ELECTION_STATION, params);
    }

    /**
     * Get Election
     *
     * @param request
     * @return
     * @throws com.mdl.mdlrestapi.psm.exception.MDLDBException
     *
     */
    @Override
    public String getElections(TokenRequest request) throws MDLDBException {
        Object [] params = new Object[1];
        params[0] =  request.getToken();
        return commonDao.getResultStringArray(SQLUtil.GET_ELECTION, params);
    }

    /**
     * Create Election
     *
     * @param request
     * @return
     * @throws com.mdl.mdlrestapi.psm.exception.MDLDBException
     *
     */
    @Override
    public String createElection(ElectionCreateUpdateRequest request) throws MDLDBException {
        Object [] params = new Object[11];
        params[0] =  request.getToken();
        params[1] =  request.getEname();
        params[2] =  request.getElection_date();
        params[3] =  request.getStart_time();
        params[4] =  request.getEnd_time();
        params[5] =  request.getCounting_center_name();
        params[6] =  request.getCounting_center_address();
        params[7] =  request.getCounting_center_latitude();
        params[8] =  request.getCounting_center_longitude();
        params[9] =  Integer.valueOf(request.BPA_identifier);
        params[10] =  request.getBallot_type_count();
        return commonDao.getResultStringObject(SQLUtil.CREATE_ELECTION, params);
    }

    /**
     * Delete Election
     *
     * @param request
     * @return
     * @throws com.mdl.mdlrestapi.psm.exception.MDLDBException
     *
     */
    @Override
    public String deleteElection(ElectionDeleteRequest request) throws MDLDBException {
        Object [] params = new Object[2];
        params[0] =  request.getToken();
        params[1] =  request.getElection_Id();
        return commonDao.getResultStringObject(SQLUtil.DELETE_ELECTION, params);
    }

    /**
     * Get File Upload data
     *
     * @param request
     * @return
     * @throws com.mdl.mdlrestapi.psm.exception.MDLDBException
     *
     */
    @Override
    public String getFileUploadData(ElectionFileUploadStatusRequest request) throws MDLDBException {
        Object [] params = new Object[2];
        params[0] =  request.getToken();
        params[1] =  request.getEid();
        return commonDao.getResultStringObject(SQLUtil.GET_ELECTION_FILE_UPLOAD_DATA, params);
    }

    /**
     * Get Polling stations by election id
     *
     * @param request
     * @return
     * @throws com.mdl.mdlrestapi.psm.exception.MDLDBException
     *
     */
    @Override
    public String getPollingStationsByElectionId(ElectionRequest request) throws MDLDBException {
        Object [] params = new Object[2];
        params[0] =  request.getToken();
        params[1] =  request.getElectionid();
        return commonDao.getResultStringArray(SQLUtil.GET_POLLING_STATIONS_BY_ELECTION_ID, params);
    }

    /**
     * @param request
     * @return
     * @throws Exception
     */
    public JSONObject resetTenantData(SimpleRequest request) throws Exception{
        return electionDao.resetTenantData(request);
    }

    /**
     * @param request
     * @return
     * @throws Exception
     */
    public JSONObject updateActivatedDay(ActivationDayRequest request) throws Exception{
        return electionDao.updateActivatedDay(request);
    }

    /**
     * @param request
     * @return
     * @throws Exception
     */
    public JSONObject getActivatedDay(SimpleRequest request) throws Exception{
        return electionDao.getActivatedDay(request);
    }
}
