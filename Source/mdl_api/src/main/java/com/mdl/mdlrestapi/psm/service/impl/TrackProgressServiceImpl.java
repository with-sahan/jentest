package com.mdl.mdlrestapi.psm.service.impl;

import com.mdl.mdlrestapi.psm.dao.CommonDao;
import com.mdl.mdlrestapi.psm.dao.TrackProgressDao;
import com.mdl.mdlrestapi.psm.dao.impl.CommonDaoImpl;
import com.mdl.mdlrestapi.psm.dao.impl.TrackProgressDaoImpl;
import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.psm.exception.MDLServiceException;
import com.mdl.mdlrestapi.psm.resource.dto.GpsRequest;
import com.mdl.mdlrestapi.psm.resource.dto.TokenRequest;
import com.mdl.mdlrestapi.psm.service.TrackProgressService;
import com.mdl.mdlrestapi.psm.utils.SQLUtil;
import com.mdl.mdlrestapi.util.models.EmDashboardGridData;
import com.mdl.mdlrestapi.util.models.TrackingDto;

import java.util.ArrayList;
import java.util.List;

/**
 * @Author	: Rushan
 * @Date	: Feb 26, 2017
 * @TIme	: 11:34:32 PM
 */
public class TrackProgressServiceImpl implements TrackProgressService {
	CommonDao commonDao = new CommonDaoImpl();
	TrackProgressDao trackProgressDao = new TrackProgressDaoImpl();

	@Override
	public String startTracking(GpsRequest request) throws MDLServiceException, MDLDBException {
		Object[] params = new Object[3];
		params[0] = request.getToken();
		params[1] = request.getLongtitude();
		params[2] = request.getLatitude();
		
		return commonDao.getResultStringObject(SQLUtil.START_TRACK, params);
	}

	@Override
	public String updateTracking(GpsRequest request) throws MDLServiceException, MDLDBException {
		Object[] params = new Object[3];
		params[0] = request.getToken();
		params[1] = request.getLongtitude();
		params[2] = request.getLatitude();
		
		return commonDao.getResultStringObject(SQLUtil.UPDATE_TRACK, params);
	}

	@Override
	public String closeTracking(TokenRequest request) throws MDLServiceException, MDLDBException {
		Object[] params = new Object[1];
		params[0] = request.getToken();
		
		return commonDao.getResultStringObject(SQLUtil.CLOSE_TRACK, params);
	}

	@Override
	public String getMapCenter(TokenRequest request) throws MDLServiceException, MDLDBException {
		Object[] params = new Object[1];
		params[0] = request.getToken();
		
		return commonDao.getResultStringObject(SQLUtil.GET_MAP_CENTER, params);
	}

	public ArrayList<TrackingDto> getFilterResults(String token, int hierarchyId) throws Exception {
		return trackProgressDao.getFilterResults(token, hierarchyId);
	}

}
