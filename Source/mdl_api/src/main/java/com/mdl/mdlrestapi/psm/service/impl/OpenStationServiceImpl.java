package com.mdl.mdlrestapi.psm.service.impl;

import com.mdl.mdlrestapi.psm.dao.CommonDao;
import com.mdl.mdlrestapi.psm.dao.impl.CommonDaoImpl;
import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.psm.exception.MDLServiceException;
import com.mdl.mdlrestapi.psm.resource.dto.ButtonStatusRequest;
import com.mdl.mdlrestapi.psm.service.OpenStationService;
import com.mdl.mdlrestapi.psm.utils.SQLUtil;

/**
 * @author Rushan
 *
 */
public class OpenStationServiceImpl implements OpenStationService {

	@Override
	public String getButtonStatus(ButtonStatusRequest request) throws MDLDBException, MDLServiceException {

		CommonDao openStationDao = new CommonDaoImpl();
		Object[] st = new Object[2];
        st[0]= request.token;
        st[1]= request.stationid;
		return openStationDao.getResultStringObject(SQLUtil.GET_POLLING_STATION_STATUS,st);
	}


}
