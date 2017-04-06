package com.mdl.mdlrestapi.psm.dao;

import java.util.ArrayList;
import java.util.List;

import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.psm.resource.dto.ElectionStartEndDto;
import com.mdl.mdlrestapi.psm.resource.dto.GeoStatoinsResponse;
import com.mdl.mdlrestapi.psm.resource.dto.HourlyPapersDto;
import com.mdl.mdlrestapi.psm.resource.dto.TimeHourlyDto;
import com.mdl.mdlrestapi.psm.resource.dto.TokenRequest;
import com.mdl.mdlrestapi.util.SimpleRequest;
import com.mdl.mdlrestapi.util.models.TenderedVotesDTO;

/**
 * @Author : Rushan
 * @Date : Mar 25, 2017
 * @TIme : 11:20:38 PM
 */
public interface ReportDao {

	/**
	 * @param request
	 * @return
	 * @throws MDLDBException
	 */
	public List<GeoStatoinsResponse> getAllGeoStations(SimpleRequest request) throws MDLDBException;

	/**
	 * @param stationId
	 * @return
	 * @throws MDLDBException
	 */
	public List<TimeHourlyDto> getTimeArrayStatsByStationId(int stationId) throws MDLDBException;

	/**
	 * @param stationId
	 * @param time
	 * @return
	 * @throws MDLDBException
	 */
	public List<HourlyPapersDto> getBallotPaperHourly(int stationId, String time) throws MDLDBException;
	
	/**
	 * @param stationId
	 * @return
	 * @throws MDLDBException
	 */
	public List<ElectionStartEndDto> getElectionStartEndTimes(int stationId) throws MDLDBException;
	
	/**
	 * @param request
	 * @return
	 * @throws MDLDBException
	 */
	public List<GeoStatoinsResponse> getAllGeoStationsByUser(TokenRequest request) throws MDLDBException;

	/**
	 * @param request
	 * @return
	 * @throws MDLDBException
	 */
	public ArrayList<TenderedVotesDTO> getTenderedVotersByHierarchyId(SimpleRequest request) throws MDLDBException;
	
}
