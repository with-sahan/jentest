package com.mdl.mdlrestapi.psm.service;

import java.io.IOException;
import java.util.ArrayList;

import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.psm.exception.MDLServiceException;
import com.mdl.mdlrestapi.psm.resource.dto.TenderedVotesRequest;
import com.mdl.mdlrestapi.psm.resource.dto.TokenRequest;
import com.mdl.mdlrestapi.util.SimpleRequest;
import com.mdl.mdlrestapi.util.models.TenderedVotesDTO;

/**
 * @Author : Rushan
 * @Date : Mar 25, 2017
 * @TIme : 11:10:49 PM
 */
public interface ReportService {

	/**
	 * @param request
	 * @return
	 * @throws MDLDBException
	 */
	public String getHoulyAnalysisData(SimpleRequest request) throws MDLDBException, MDLServiceException;
	
	/**
	 * @param request
	 * @return
	 * @throws MDLDBException
	 */
	public byte[] getHoulyAnalysisPDF(SimpleRequest request) throws MDLDBException, IOException, MDLServiceException;
	
	/**
	 * @param request
	 * @return
	 * @throws MDLDBException
	 */
	public String getHoulyAnalysisDataByUser(TokenRequest request) throws MDLDBException, MDLServiceException;

	/**
	 * @param request
	 * @return
	 * @throws MDLDBException
	 * @throws MDLServiceException
	 */
	public String getAllTenderedVotes(TokenRequest request) throws MDLDBException, MDLServiceException;

	/**
	 * @param request
	 * @return
	 * @throws MDLDBException
	 * @throws MDLServiceException
	 */
	public String getTenderedVotesById(TenderedVotesRequest request) throws MDLDBException, MDLServiceException;

	/**
	 * @param request
	 * @return
	 * @throws MDLDBException
	 * @throws MDLServiceException
	 */
	public String addToTenderedVotes(TenderedVotesRequest request) throws MDLDBException, MDLServiceException;

	/**
	 * @param request
	 * @return
	 * @throws MDLDBException
	 * @throws MDLServiceException
	 */
	public String updateTenderedVote(TenderedVotesRequest request) throws MDLDBException, MDLServiceException;

	/**
	 * @param request
	 * @return
	 * @throws MDLDBException
	 * @throws MDLServiceException
	 */
	public String deleteTenderedVote(TenderedVotesRequest request) throws MDLDBException, MDLServiceException;

	/**
	 * @param request
	 * @return
	 * @throws MDLDBException
	 * @throws MDLServiceException
	 */
	public ArrayList<TenderedVotesDTO> getTenderedVotersByHierarchyId(SimpleRequest request) throws MDLDBException,MDLServiceException;

}
