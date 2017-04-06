package com.mdl.mdlrestapi.psm.service;

import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.psm.resource.dto.*;
import com.mdl.mdlrestapi.util.SimpleRequest;
import com.mdl.mdlrestapi.util.models.ActivationDayRequest;
import org.json.JSONObject;

public interface ElectionService {
	public String getElectionByID(ElectionRequest request)throws MDLDBException;
	public String closeElection(CloseElectionRequest request)throws MDLDBException;

    /**
     * Update Election
     * @param request
     * @return
     * @throws MDLDBException
     */
    public String updateElection(ElectionCreateUpdateRequest request)throws MDLDBException;

    /**
     * Get Election
     * @param request
     * @return
     * @throws MDLDBException
     */
    public String getElections(TokenRequest request)throws MDLDBException;

    /**
     * Create Election
     * @param request
     * @return
     * @throws MDLDBException
     */
    public String createElection(ElectionCreateUpdateRequest request)throws MDLDBException;

    /**
     * Delete Election
     * @param request
     * @return
     * @throws MDLDBException
     */
    public String deleteElection(ElectionDeleteRequest request)throws MDLDBException;

    /**
     * Get File Upload data
     * @param request
     * @return
     * @throws MDLDBException
     */
    public String getFileUploadData(ElectionFileUploadStatusRequest request)throws MDLDBException;

    /**
     * Get Polling stations by election id
     * @param request
     * @return
     * @throws MDLDBException
     */
    public String getPollingStationsByElectionId(ElectionRequest request) throws MDLDBException;

    /**
     * @param request
     * @return
     * @throws Exception
     */
    public JSONObject resetTenantData(SimpleRequest request) throws Exception;

    /**
     * @param request
     * @return
     * @throws Exception
     */
    public JSONObject updateActivatedDay(ActivationDayRequest request) throws Exception;

    /**
     * @param request
     * @return
     * @throws Exception
     */
    public JSONObject getActivatedDay(SimpleRequest request) throws Exception;
}
