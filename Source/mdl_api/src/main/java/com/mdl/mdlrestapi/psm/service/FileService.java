package com.mdl.mdlrestapi.psm.service;

import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.psm.resource.dto.FileReportRequest;

/**
 * @Author	: Rushan
 * @Date	: Mar 2, 2017
 * @TIme	: 12:13:49 PM
 */
public interface FileService {

	/**
	 * @param request
	 * @return
	 * @throws MDLDBException
	 */
	public String getFileReport(FileReportRequest request) throws MDLDBException;
}
