package com.mdl.mdlrestapi.psm;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.ws.rs.Consumes;
import javax.ws.rs.OPTIONS;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.apache.log4j.Logger;
import org.json.JSONObject;

import com.google.gson.Gson;
import com.mdl.mdlrestapi.util.ErrorCodes;
import com.mdl.mdlrestapi.util.SimpleRequest;
import com.mdl.mdlrestapi.util.TokenValidation;
import com.mdl.mdlrestapi.util.database.DatabaseConnectionManager;
import com.mdl.mdlrestapi.util.database.psm.entities.HierarchyValue;
import com.mdl.mdlrestapi.util.database.subscription.SubscriptionQuerryHandler;
import com.mdl.mdlrestapi.util.exception.MDLServerException;
import com.mdl.mdlrestapi.util.exception.UnauthorizedException;
import com.mdl.mdlrestapi.util.models.CloseStatsDto;
import com.mdl.mdlrestapi.util.models.CloseStatsSummeryDto;
import com.mdl.mdlrestapi.util.models.PollingStationElectionDto;

@Path("/getstats")
public class GetStats {
	private static final Logger logger = Logger.getLogger(GetStats.class);

	public GetStats(){
		//CTOR
	}

	//this is need to avoid the CORS issues when calling options
	@OPTIONS
	@Path("{path : .*}")
	public Response options() {
		return Response.ok("").header("Access-Control-Allow-Origin", "*")
				.header("Access-Control-Allow-Headers", "origin, content-type, accept, authorization")
				.header("Access-Control-Allow-Credentials", "true")
				.header("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS, HEAD")
				.header("Access-Control-Max-Age", "1209600").build();
	}
	
	
	@POST
	@Path("/getallclosestatssummary_v3")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public Response getStatsSummery(SimpleRequest request) throws MDLServerException, UnauthorizedException{
		if(request == null){
			logger.warn("Request is null");
			JSONObject responseobj = new JSONObject();
			responseobj.put("response", "Error:"+ErrorCodes.INVALID_DATA);
			return Response.ok(responseobj.toString()).build();
		}
		if(!TokenValidation.ValidateToken(request.token)){
			logger.warn("Invalid token,token:" + request.token);
			throw new UnauthorizedException(new Throwable("Invalid token"));
		}
		try{
			Gson gson = new Gson();
			ArrayList<CloseStatsSummeryDto> resultMap=getAllCloseStatsSummery(request.token,request.electionId,request.hierarchyId);
			return Response.ok(gson.toJson(resultMap)).build();

		}catch(Exception ex){
			logger.error(ex);
			throw new MDLServerException(ex);
		}	
	}
	
	
	@POST
	@Path("/getallclosestats_v3")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public Response getStatsTable(SimpleRequest request) throws MDLServerException, UnauthorizedException{
		if(request == null){
			logger.warn("Request is null");
			JSONObject responseobj = new JSONObject();
			responseobj.put("response", "Error:"+ErrorCodes.INVALID_DATA);
			return Response.ok(responseobj.toString()).build();
		}
		if(!TokenValidation.ValidateToken(request.token)){
			logger.warn("Invalid token,token:" + request.token);
			throw new UnauthorizedException(new Throwable("Invalid token"));
		}
		try{
			Gson gson = new Gson();
			ArrayList<CloseStatsDto> resultMap=getAllCloseStats(request.token,request.electionId,request.hierarchyId);
			return Response.ok(gson.toJson(resultMap)).build();

		}catch(Exception ex){
			logger.error(ex);
			throw new MDLServerException(ex);
		}	
	}


	private ArrayList<CloseStatsDto> getAllCloseStats(String token,int electionId,int hierarchyId) throws Exception {
		GeoHierarchy geoHierarchy = new GeoHierarchy();	
		int orgId = SubscriptionQuerryHandler.getOrganizationId(token);
		ArrayList<CloseStatsDto> closeStatsDetails = new ArrayList<CloseStatsDto>();
		
		if (orgId > 0 && electionId >0 && hierarchyId >0 ) {
			Connection conn = null;
			PreparedStatement preparedStatement = null;
			ResultSet rs = null;
			List<HierarchyValue> hierarchyValues = geoHierarchy.findHierarchyValueByOrganizationId(orgId);
			try{
				String stationList = EmDashboard.getPollingStationList(hierarchyId, orgId).replaceAll(",$", "");
				
//				String querry = "call psm.getallclosestats_v2(?,?)";
//				conn = DatabaseConnectionManager.getConnection();
//				preparedStatement = conn.prepareStatement(querry);
//				preparedStatement.setString(1, token);
//				preparedStatement.setInt(2, electionId);
//				rs = preparedStatement.executeQuery();
				
				String query = "select ecs.tot_ballots,ecs.tot_spolied_issued as tot_spoiled_replaced, "
						+ "ecs.tot_unused,ecs.tot_tend_ballots, "
						+ "ecs.tot_tend_spoiled,ecs.tot_tend_unused, "
						+ "ecs.tot_ballots2,ecs.tot_spolied_issued2 as tot_spoiled_replaced2, "
						+ "ecs.tot_unused2,ecs.tot_tend_ballots2, "
						+ "ecs.tot_tend_spoiled2,ecs.tot_tend_unused2, "
						+ "el.election_name as electionname, "
						+ "ps.name as pollingstation, el.Id as electionid, "
						+ "hv.value as pollingstation_place, "
						+ "hv.parent_id as parent_id, "
						+ "hv.id as hierarchy_value_id, "
						+ "'success' as response "
						+ "from psm.election_close_stats ecs "
						+ "inner join psm.election el on el.id=election_id "
						+ "inner join psm.polling_station ps on ps.id=polling_station_id "
						+ "inner join psm.hierarchy_value hv on ps.hierarchy_value_id=hv.id "
						+ "where ecs.organization_id=? and ps.id in ("+stationList+") "			//TODO give stationList as a param
						+ "and el.id=? "
						+ "and UNIX_TIMESTAMP(ecs.updatedon) > UNIX_TIMESTAMP(CURDATE()) ; ";
				conn = DatabaseConnectionManager.getConnection();
				preparedStatement = conn.prepareStatement(query);
				preparedStatement.setInt(1, orgId);
				preparedStatement.setInt(2, electionId);
				rs = preparedStatement.executeQuery();

				while (rs.next()) {
					CloseStatsDto csd = new CloseStatsDto();
					HierarchyValue placeHierarchyValue = new HierarchyValue();
					csd.tot_ballots = rs.getString("tot_ballots");
					csd.tot_ballots2 = rs.getString("tot_ballots2");
					csd.tot_spoiled_replaced = rs.getString("tot_spoiled_replaced");
					csd.tot_spoiled_replaced2 = rs.getString("tot_spoiled_replaced2");
					csd.tot_unused = rs.getString("tot_unused");
					csd.tot_unused2 = rs.getString("tot_unused2");
					csd.tot_tend_ballots = rs.getString("tot_tend_ballots");
					csd.tot_tend_ballots2 = rs.getString("tot_tend_ballots2");
					csd.tot_tend_spoiled = rs.getString("tot_tend_spoiled");
					csd.tot_tend_spoiled2 = rs.getString("tot_tend_spoiled2");
					csd.tot_tend_unused = rs.getString("tot_tend_unused");
					csd.tot_tend_unused2 = rs.getString("tot_tend_unused2");
					csd.electionname = rs.getString("electionname");
					csd.pollingstation = rs.getString("pollingstation");
					csd.electionid = rs.getString("electionid");
					csd.pollingstation_place = rs.getString("pollingstation_place");
					csd.parent_id = rs.getString("parent_id");
					csd.hierarchy_value_id = rs.getString("hierarchy_value_id");
					csd.response = rs.getString("response");
					

					placeHierarchyValue.setParentId(rs.getInt("parent_id"));
					placeHierarchyValue.setValue(csd.pollingstation_place);
					List<HierarchyValue> temp = geoHierarchy.traverse(hierarchyValues, placeHierarchyValue);
					if(temp.size()==3){
						csd.pollingstation_ward=temp.get(0).getValue();
						csd.pollingstation_district=temp.get(1).getValue();
						for(HierarchyValue hv:hierarchyValues){
							if(hv.getId().intValue() == temp.get(0).getParentId().intValue()){
								csd.pollingstation_council=hv.getValue();
								break;
							}
						}
					}
					closeStatsDetails.add(csd);
				}
				
				
				
			}finally {
				if (rs != null) {
					rs.close();
				}if (preparedStatement != null) {
					preparedStatement.close();
				}if (conn != null) {
					conn.close();
				}
			}

		}else{
			logger.warn("orgid(" + orgId + ") or electionid(" + electionId + ")  is not defined");
		}
		return closeStatsDetails;
	}
	
	
	
	private ArrayList<CloseStatsSummeryDto> getAllCloseStatsSummery(String token,int electionId,int hierarchyId) throws Exception {
		GeoHierarchy geoHierarchy = new GeoHierarchy();	
		int orgId = SubscriptionQuerryHandler.getOrganizationId(token);
		ArrayList<CloseStatsSummeryDto> closeStatsDetails = new ArrayList<CloseStatsSummeryDto>();
		
		if (orgId > 0 && electionId >0  && hierarchyId >0) {
			Connection conn = null;
			PreparedStatement preparedStatement = null;
			ResultSet rs = null;
			List<HierarchyValue> hierarchyValues = geoHierarchy.findHierarchyValueByOrganizationId(orgId);
			try{
				String stationList = EmDashboard.getPollingStationList(hierarchyId, orgId).replaceAll(",$", "");				
				
				String query = "select sum(ecs.tot_ballots) as sum_tot_ballots, "
						+ "sum(ecs.tot_spolied_issued) as sum_tot_spoiled_replaced, "
						+ "sum(ecs.tot_unused) as sum_tot_unused, "
						+ "sum(ecs.tot_tend_ballots) as sum_tot_tend_ballots, "
						+ "sum(ecs.tot_tend_spoiled) as sum_tot_tend_spoiled, "
						+ "sum(ecs.tot_tend_unused) as sum_tot_tend_unused, "
						+ "sum(ecs.tot_ballots2) as sum_tot_ballots2, "
						+ "sum(ecs.tot_spolied_issued2) as sum_tot_spoiled_replaced2, "
						+ "sum(ecs.tot_unused2) as sum_tot_unused2, "
						+ "sum(ecs.tot_tend_ballots2) as sum_tot_tend_ballots2, "
						+ "sum(ecs.tot_tend_spoiled2) as sum_tot_tend_spoiled2, "
						+ "sum(ecs.tot_tend_unused2) as sum_tot_tend_unused2, "
						+ "ecs.election_id as electionid, "
						+ "'success' as response from "
						+ "psm.election_close_stats ecs "
						+ "where ecs.organization_id=? and "
						+ "ecs.election_id = ? and "
						+ "ecs.polling_station_id in (" + stationList + ") and "
						+ "UNIX_TIMESTAMP(ecs.updatedon) > UNIX_TIMESTAMP(CURDATE()) "
						+ "group by ecs.election_id; ";
				conn = DatabaseConnectionManager.getConnection();
				preparedStatement = conn.prepareStatement(query);
				preparedStatement.setInt(1, orgId);
				preparedStatement.setInt(2, electionId);
				rs = preparedStatement.executeQuery();

				while (rs.next()) {
					CloseStatsSummeryDto csd = new CloseStatsSummeryDto();
					HierarchyValue placeHierarchyValue = new HierarchyValue();
					csd.sum_tot_tend_unused = rs.getString("sum_tot_tend_unused");
					csd.sum_tot_unused = rs.getString("sum_tot_unused");
					csd.sum_tot_tend_spoiled = rs.getString("sum_tot_tend_spoiled");
					csd.sum_tot_tend_ballots = rs.getString("sum_tot_tend_ballots");
					csd.sum_tot_ballots = rs.getString("sum_tot_ballots");
					csd.sum_tot_spoiled_replaced = rs.getString("sum_tot_spoiled_replaced");
					csd.sum_tot_tend_unused2 = rs.getString("sum_tot_tend_unused2");
					csd.sum_tot_unused2 = rs.getString("sum_tot_unused2");
					csd.sum_tot_tend_spoiled2 = rs.getString("sum_tot_tend_spoiled2");
					csd.sum_tot_tend_ballots2 = rs.getString("sum_tot_tend_ballots2");
					csd.sum_tot_ballots2 = rs.getString("sum_tot_ballots2");
					csd.sum_tot_spoiled_replaced2 = rs.getString("sum_tot_spoiled_replaced2");
					csd.electionid = rs.getString("electionid");
					csd.response = rs.getString("response");
					
					closeStatsDetails.add(csd);
				}
				
				
				
			}finally {
				if (rs != null) {
					rs.close();
				}if (preparedStatement != null) {
					preparedStatement.close();
				}if (conn != null) {
					conn.close();
				}
			}

		}else{
			logger.warn("orgid(" + orgId + ") or electionid(" + electionId + ")  is not defined");
		}
		return closeStatsDetails;
	}

}
