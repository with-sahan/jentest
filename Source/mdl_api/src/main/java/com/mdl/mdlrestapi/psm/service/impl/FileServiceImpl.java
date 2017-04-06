package com.mdl.mdlrestapi.psm.service.impl;

import com.mdl.mdlrestapi.psm.dao.CommonDao;
import com.mdl.mdlrestapi.psm.dao.impl.CommonDaoImpl;
import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.psm.resource.dto.FileReportRequest;
import com.mdl.mdlrestapi.psm.service.FileService;
import com.mdl.mdlrestapi.psm.utils.SQLUtil;

/**
 * @Author	: Rushan
 * @Date	: Mar 2, 2017
 * @TIme	: 12:41:50 PM
 */
public class FileServiceImpl implements FileService{
	
	CommonDao commonDao = new CommonDaoImpl();

	@Override
	public String getFileReport(FileReportRequest request) throws MDLDBException {
		Object[] params = new Object[2];
		params[0] = request.getToken();
		params[1] = request.getElectionId();
		
		return commonDao.getResultStringObject(SQLUtil.GET_FILE_REPORT, params);
	}

}
