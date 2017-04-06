package com.mdl.mdlrestapi.psm.service;

import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.psm.exception.MDLServiceException;

public interface OrganizationService {
	public String getOrganizationInformation(String token) throws MDLServiceException, MDLDBException;
}
