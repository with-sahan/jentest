package com.mdl.mdlrestapi.psm.service;

import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.psm.exception.MDLServiceException;
import com.mdl.mdlrestapi.psm.resource.dto.ButtonStatusRequest;
import com.mdl.mdlrestapi.util.SimpleRequest;

/**
 * @author Rushan
 *
 */
public interface OpenStationService {
	/**
	 * @param request
	 * @return
	 * @throws MDLDBException
	 * @throws MDLServiceException
	 */
	public String getButtonStatus(ButtonStatusRequest request) throws MDLDBException, MDLServiceException; 
}
