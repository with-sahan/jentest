package com.mdl.mdlrestapi.psm.service.impl;

import com.mdl.mdlrestapi.psm.dao.CommonDao;
import com.mdl.mdlrestapi.psm.dao.impl.CommonDaoImpl;
import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.psm.resource.dto.CollectPostalPackRequest;
import com.mdl.mdlrestapi.psm.resource.dto.StationElectionRequest;
import com.mdl.mdlrestapi.psm.service.PollingStationElectionService;
import com.mdl.mdlrestapi.psm.utils.SQLUtil;

public class PollingStationElectionServiceImpl implements PollingStationElectionService {
	
	private CommonDao commonDao = new CommonDaoImpl();

	@Override
	public String getRecordCloseButtonState(StationElectionRequest request) throws MDLDBException {
        Object [] params = new Object[3];
        params[0] =  request.getToken();
        params[1] = request.getElectionid();
        params[2] = request.getPollingstationid();
        return commonDao.getResultStringObject(SQLUtil.GET_RECORD_CLOSE_BUTTON_SHOW, params);
	}

	@Override
	public String getPollingStationElectionDetails(StationElectionRequest request) throws MDLDBException {
        Object [] params = new Object[3];
        params[0] =  request.getToken();
        params[1] = request.getElectionid();
        params[2] = request.getPollingstationid();
        return commonDao.getResultStringObject(SQLUtil.GET_POLLING_STATION_ELECTION_DETAILS, params);
	}

	@Override
	public String getUnclosedElectionsByStationID(StationElectionRequest request) throws MDLDBException {
        Object [] params = new Object[3];
        params[0] =  request.getToken();
        params[1] = request.getPollingstationid();
        params[2] = request.getElectionid();
        return commonDao.getResultStringArray(SQLUtil.GET_UNCLOSED_ELECTIONS_BY_STATION_ID, params);
	}

	@Override
	public String collectPostalPacks(CollectPostalPackRequest request) throws MDLDBException {
        Object [] params = new Object[4];
        params[0] =  request.getToken();
        params[1] = request.getPollingstationid();
        params[2] = request.getElectionid();
        params[3] = request.getperson_name();
        return commonDao.getResultStringObject(SQLUtil.COLLECT_POSTAL_PACKS, params);
	}
	
	@Override
	public String getPostalPackProgress(StationElectionRequest request) throws MDLDBException {
        Object [] params = new Object[3];
        params[0] =  request.getToken();
        params[1] = request.getPollingstationid();
        params[2] = request.getElectionid();
        return commonDao.getResultStringArray(SQLUtil.GET_POSTAL_PACK_POGRESS, params);
	}

}
