package com.mdl.mdlrestapi.psm.service;

import java.util.List;

import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.psm.exception.MDLServiceException;
import com.mdl.mdlrestapi.psm.model.*;
import com.mdl.mdlrestapi.psm.resource.dto.*;

/**
 * Created with IntelliJ IDEA.
 * User: AnushaP
 * Date: 2/21/17
 * Time: 5:06 PM
 * To change this template use File | Settings | File Templates.
 */
public interface PollingStationService {
    /**
     * Get polling stations
     * @param token
     * @return
     * @throws MDLServiceException
     * @throws MDLDBException
     */
    public String getPollingStations(String token) throws MDLServiceException, MDLDBException;

    /**
     * Get polling station closed status
     * @param token
     * @param stationId
     * @return
     * @throws MDLServiceException
     * @throws MDLDBException
     */
    public String getPollingStationsClosedStatus (String token, int stationId) throws MDLDBException;

    /**
     * Get Elections by station
     * @param token
     * @param stationId
     * @return
     * @throws MDLDBException
     */
    public String getElectionsByStation(String token, int stationId) throws MDLDBException;

    /**
     * Update pre-polling activity
     * @param prePollingActivity
     * @return
     * @throws MDLDBException
     */
    public String updatePrePollingActivity(PrePollingActivity prePollingActivity) throws MDLDBException;

    /**
     * Get Election status
     * @param electionStatusRequest
     * @return
     * @throws MDLDBException
     */
    public String getElectionStatus(ElectionStatusRequest electionStatusRequest) throws MDLDBException;

     /**
     * Generate BPA
     * @param electionStatusRequest
     * @return
     * @throws MDLDBException
     */
    public String generateBPA(ElectionStatusRequest electionStatusRequest) throws MDLDBException;

    /**
     * Get Post poll activity
     * @param electionStatusRequest
     * @return
     * @throws MDLDBException
     */
    public String getPostPollActivity(PostPollingActivityRequest electionStatusRequest) throws MDLDBException;

    /**
     * Get BPA station by station
     * @param stationRequest
     * @return
     * @throws MDLDBException
     */
    public String getBPAStationByStation(StationRequest stationRequest) throws MDLDBException;

    /**
     * Get BPA Status
     * @param stationRequest
     * @return
     * @throws MDLDBException
     */
    public String getBPAStatus(ElectionStatusRequest stationRequest) throws MDLDBException;


    /**
     * Close station
     * @param pollingStationRequest
     * @return
     * @throws MDLDBException
     */
    public String closePollingStation(PollingStationRequest pollingStationRequest) throws MDLDBException;

    /**
     * Get pre polling activities
     * @param prePollingActivity
     * @return
     * @throws MDLDBException
     */
    public String getPrePollActivity(PrePollingActivity prePollingActivity) throws MDLDBException;
    
    
	/**
	 * open polling station
	 * @param request
     * @return
     * @throws MDLDBException
	 */
	public String openPollingStation(PollingStationRequest request) throws MDLDBException;

    /**
     * Update Station close stat
     * @param request
     * @return
     * @throws MDLDBException
     */
    public String updateStationCloseStat(CloseStationStatRequest request)throws MDLDBException;

    /**
     * Get Polling Contact
     * @param token
     * @return
     * @throws MDLDBException
     */
    public String getPollingContact(String  token) throws MDLDBException;
    
    
    /*
     * Complete progress sequence
     */
    public String completeProgressSequence(PollingStationRequest request) throws MDLDBException;

    /**
     * Polling stations by Station id
     * @param token
     * @return
     * @throws MDLDBException
     */
    public String getPollingStationByStationId(StationRequest token)throws MDLDBException;

    /**
     * Update Station
     * @param request
     * @return
     * @throws MDLDBException
     */
    public String updateStation(StationUpdateRequest request)throws MDLDBException;

    /**
     * Get progress
     * @param request
     * @return
     * @throws MDLDBException
     */
    public String getProgress(BallotCloseStatRequest request)throws MDLDBException;

    /**
     * Update progress
     * @param request
     * @return
     * @throws MDLDBException
     */
    public String updateProgress(UpdateProgressRequest request)throws MDLDBException;
}
