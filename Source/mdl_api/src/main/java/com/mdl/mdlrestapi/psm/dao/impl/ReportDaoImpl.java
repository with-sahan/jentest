package com.mdl.mdlrestapi.psm.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.mdl.mdlrestapi.util.database.DatabaseConnectionManager;
import com.mdl.mdlrestapi.util.models.TenderedVotesDTO;
import org.apache.log4j.Logger;


import com.mdl.mdlrestapi.util.database.security.SecurityQuerryHandler;
import com.mdl.mdlrestapi.psm.dao.CommonDao;
import com.mdl.mdlrestapi.psm.dao.ReportDao;
import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.psm.resource.dto.ElectionStartEndDto;
import com.mdl.mdlrestapi.psm.resource.dto.GeoStatoinsResponse;
import com.mdl.mdlrestapi.psm.resource.dto.HourlyPapersDto;
import com.mdl.mdlrestapi.psm.resource.dto.StationIdsDto;
import com.mdl.mdlrestapi.psm.resource.dto.TimeHourlyDto;
import com.mdl.mdlrestapi.psm.resource.dto.TokenRequest;
import com.mdl.mdlrestapi.util.SimpleRequest;
import com.mdl.mdlrestapi.util.database.subscription.SubscriptionQuerryHandler;

/**
 * @Author : Rushan
 * @Date : Mar 25, 2017
 * @TIme : 11:30:22 PM
 */
public class ReportDaoImpl implements ReportDao {
	private static final Logger logger = Logger.getLogger(ReportDaoImpl.class);
	CommonDao commonDao = new CommonDaoImpl();

	@Override
	public List<GeoStatoinsResponse> getAllGeoStations(SimpleRequest request) throws MDLDBException {

		List<GeoStatoinsResponse> result;
		String query = null;

		int orgId = SubscriptionQuerryHandler.getOrganizationId(request.token);
		int userId = SecurityQuerryHandler.getUserId(request.token, orgId);
		String stationList = commonDao.getPollingStationList(request.hierarchyId, orgId, userId).replaceAll(",$", "");

		try {
			query = "select "
					+ "'success' as response, "
					+ "psm.returnHierarchy(ps.hierarchy_value_id,1) as ward, "
					+ "psm.returnHierarchy(ps.hierarchy_value_id,2) as district, "
					+ "psm.returnHierarchy(ps.hierarchy_value_id,3) as place, "
					+ "ps.name as pollingstationname , "
					+ "ps.id as stationid, "
					+ "coalesce(sum(es.ballotpaper),0) as runningtotal "
					+ "from psm.polling_station ps "
					+ "inner join psm.election_stats es on es.polling_station_id=ps.id "
					+ "where ps.organization_id=" +orgId 
					+ " and ps.id in ("+stationList+") "
					+ " group by(es.polling_station_id);";

			GeoStatoinsResponse dto = new GeoStatoinsResponse();
			result = commonDao.getResultListByDto(query, dto);
			return result;
		} catch (MDLDBException e) {
			logger.error("Error : " + e.getMessage());
			throw new MDLDBException(e.getMessage());
		}

	}
	
	@Override
	public List<GeoStatoinsResponse> getAllGeoStationsByUser(TokenRequest request) throws MDLDBException {

		List<GeoStatoinsResponse> result;
		List<StationIdsDto> stations;
		
		String query = null;

		int orgId = SubscriptionQuerryHandler.getOrganizationId(request.getToken());

		try {
			query = "call psm.getstationidsbyuser('" + request.getToken() + "');";
			StationIdsDto obj = new StationIdsDto();
			stations =  commonDao.getResultListByDto(query, obj);			
			String stationList = getStationList(stations).replaceAll(",$", "");
			
			query = "select "
					+ "'success' as response, "
					+ "psm.returnHierarchy(ps.hierarchy_value_id,1) as ward, "
					+ "psm.returnHierarchy(ps.hierarchy_value_id,2) as district, "
					+ "psm.returnHierarchy(ps.hierarchy_value_id,3) as place, "
					+ "ps.name as pollingstationname , "
					+ "ps.id as stationid, "
					+ "coalesce(sum(es.ballotpaper),0) as runningtotal "
					+ "from psm.polling_station ps "
					+ "inner join psm.election_stats es on es.polling_station_id=ps.id "
					+ "where ps.organization_id=" +orgId 
					+ " and ps.id in ("+stationList+") "
					+ " group by(es.polling_station_id);";
			
			GeoStatoinsResponse dto = new GeoStatoinsResponse();
			result = commonDao.getResultListByDto(query, dto);
			return result;
		} catch (MDLDBException e) {
			logger.error("Error : " + e.getMessage());
			throw new MDLDBException(e.getMessage());
		}

	}
	
	private String getStationList(List<StationIdsDto> stations){
		StringBuilder sb = new StringBuilder();
		for(StationIdsDto stationid : stations){
			sb.append(stationid.getPollingstation_id());
			sb.append(',');
		}
		return sb.toString();
	}
		
	@Override
	public List<TimeHourlyDto> getTimeArrayStatsByStationId(int stationId) throws MDLDBException {

		List<TimeHourlyDto> result;
		String query = null;

		try {
			query = "SELECT timeHour as hour, "
					+ "sum(ballotpaper) as totalcount, "
					+ "psm.cumilativeballotcount(" + stationId + ",timeHour) as runningtotal "
					+ "FROM psm.election_stats "
					+ "where polling_station_id=" + stationId + " and "
					+ "timeHour>0 group by(timeHour)";

			TimeHourlyDto dto = new TimeHourlyDto();
			result = commonDao.getResultListByDto(query, dto);
			return result;
		} catch (MDLDBException e) {
			logger.error("Error : " + e.getMessage());
			throw new MDLDBException(e.getMessage());
		}
	}

	@Override
	public List<HourlyPapersDto> getBallotPaperHourly(int stationId, String time) throws MDLDBException {

		List<HourlyPapersDto> result;
		String query = null;

		try {
			query = "SELECT e.election_name as ename,"
					+ "psm.gethourlypapersbybpai(" + stationId + ",es.timeHour,e.BPA_identifier,es.electionid) as papers "
					+ "FROM psm.election_stats es "
					+ "inner join psm.election e on e.id = es.electionid "
					+ "where es.polling_station_id="+stationId
					+ " and es.timeHour=" + time + " group by(es.electionid);";

			HourlyPapersDto dto = new HourlyPapersDto();
			result = commonDao.getResultListByDto(query, dto);
			return result;
		} catch (MDLDBException e) {
			logger.error("Error : " + e.getMessage());
			throw new MDLDBException(e.getMessage());
		}
	}

	@Override
	public List<ElectionStartEndDto> getElectionStartEndTimes(int stationId) throws MDLDBException {
		
		List<ElectionStartEndDto> result;
		String query = null;

		try {
			query = "SELECT  e.election_name as ename,"
					+ " hour(e.election_date_start) as starttime, "
					+ " hour(e.election_date_end) as endtime "
					+ " FROM psm.polling_station_election pse "
					+ " inner join psm.election e "
					+ " on e.id= pse.election_id "
					+ " where polling_station_id=" + stationId + ";";

			ElectionStartEndDto dto = new ElectionStartEndDto();
			result = commonDao.getResultListByDto(query, dto);
			return result;
		} catch (MDLDBException e) {
			logger.error("Error : " + e.getMessage());
			throw new MDLDBException(e.getMessage());
		}
	}


    public ArrayList<TenderedVotesDTO> getTenderedVotersByHierarchyId(SimpleRequest request) throws MDLDBException {

        ArrayList<TenderedVotesDTO> arrayDTO = new ArrayList<TenderedVotesDTO>();

        int orgid = SubscriptionQuerryHandler.getOrganizationId(request.token);
        int userid = SecurityQuerryHandler.getUserId(request.token, orgid);
        String stationList = commonDao.getPollingStationList(request.hierarchyId, orgid, userid).replaceAll(",$", "");
        String querry = null;
        try {
            if (request.hierarchyId > 0 && orgid > 0) {
                Connection conn = DatabaseConnectionManager.getConnection();

                querry = "select tv.id as id, " + "psm.returnHierarchy(ps.hierarchy_value_id,2) as district, "
                        + "psm.returnHierarchy(ps.hierarchy_value_id,1) as ward, " + "ps.name as pollingstationname, "
                        + "tv.voter_name as votername, " + "tv.elector_number as electornumber, "
                        + "tv.isalready_marked as isalreadymarked, "
                        + "concat(u.firstname,' ',u.lastname) as pofficername, "
                        + "'success' as response "
                        + "from psm.bof_tendered_votes tv "
                        + "inner join psm.polling_station ps on ps.id=tv.polling_station_id "
                        + "inner join security.user u on u.id=tv.user_id "
                        + "where tv.organization_id=? and tv.polling_station_id in (" + stationList
                        + ");";

                PreparedStatement ps = conn.prepareStatement(querry);
                ps.setInt(1, orgid);
                ResultSet rs = ps.executeQuery();

                while (rs.next()) {
                    TenderedVotesDTO obj = new TenderedVotesDTO();
                    obj.id = rs.getInt("id");
                    obj.district = rs.getString("district");
                    obj.ward = rs.getString("ward");
                    obj.pollingstationname = rs.getString("pollingstationname");
                    obj.electornumber = rs.getInt("electornumber");
                    obj.votername = rs.getString("votername");
                    obj.isalreadymarked = rs.getInt("isalreadymarked");
                    obj.pofficername = rs.getString("pofficername");
                    obj.response = "success";
                    arrayDTO.add(obj);
                }
            } else {
                TenderedVotesDTO obj = new TenderedVotesDTO();
                obj.response = "error";
                arrayDTO.add(obj);
            }

        } catch (MDLDBException | SQLException e) {
            logger.error("Error : " + e.getMessage());
            throw new MDLDBException(e.getMessage());
        }
        return arrayDTO;
    }
	
}











