package com.mdl.mdlrestapi.psm.service;

import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.psm.exception.MDLServiceException;
import com.mdl.mdlrestapi.psm.resource.dto.GpsRequest;
import com.mdl.mdlrestapi.psm.resource.dto.TokenRequest;
import com.mdl.mdlrestapi.util.models.TrackingDto;

import java.util.ArrayList;

/**
 * @Author	: Rushan
 * @Date	: Feb 26, 2017
 * @TIme	: 11:24:54 PM
 */
public interface TrackProgressService {

	/**
	 * @param request
	 * @return
	 * @throws MDLServiceException
	 * @throws MDLDBException
	 */
	public String getMapCenter(TokenRequest request) throws MDLServiceException,MDLDBException;
	/**
	 * @param request
	 * @return
	 * @throws MDLServiceException
	 * @throws MDLDBException
	 */
	public String startTracking(GpsRequest request) throws MDLServiceException, MDLDBException;
	/**
	 * @param request
	 * @return
	 * @throws MDLServiceException
	 * @throws MDLDBException
	 */
	public String updateTracking(GpsRequest request) throws MDLServiceException,MDLDBException;
	/**
	 * @param request
	 * @return
	 * @throws MDLServiceException
	 * @throws MDLDBException
	 */
	public String closeTracking(TokenRequest request) throws MDLServiceException, MDLDBException;

	/**
	 * @param token
	 * @param hierarchyId
	 * @return
	 * @throws Exception
	 */
	public ArrayList<TrackingDto> getFilterResults(String token, int hierarchyId) throws Exception;
	
}
