package com.mdl.mdlrestapi.psm.service;

import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.psm.resource.dto.CollectPostalPackRequest;
import com.mdl.mdlrestapi.psm.resource.dto.StationElectionRequest;

public interface PollingStationElectionService {
	
	/*
	 * Get election record close button status (in record progress )
	 */
	public String getRecordCloseButtonState(StationElectionRequest request) throws MDLDBException;
	
	/*
	 * Get polling station election details
	 */
	public String getPollingStationElectionDetails(StationElectionRequest request)throws MDLDBException;
	
	/*
	 * Get unclosed elections by station
	 */
	public String getUnclosedElectionsByStationID(StationElectionRequest request)throws MDLDBException;
	
	/*
	 * Collect postal packs
	 */
	public String collectPostalPacks(CollectPostalPackRequest request) throws MDLDBException;
	
	/*
	 * Get postal pack progress
	 */
	public String getPostalPackProgress(StationElectionRequest request)throws MDLDBException;
}
