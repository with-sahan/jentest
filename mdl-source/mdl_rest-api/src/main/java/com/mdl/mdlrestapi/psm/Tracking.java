package com.mdl.mdlrestapi.psm;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

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
import com.mdl.mdlrestapi.util.database.subscription.SubscriptionQuerryHandler;
import com.mdl.mdlrestapi.util.exception.MDLServerException;
import com.mdl.mdlrestapi.util.exception.UnauthorizedException;
import com.mdl.mdlrestapi.util.models.TrackingDto;
import com.mdl.mdlrestapi.util.models.TrackingListDto;
import com.mdl.mdlrestapi.util.models.TrackingResult;

@Path("/tracking")
public class Tracking {
	private static final Logger logger = Logger.getLogger(Tracking.class);
	public Tracking(){
		//CTOR
	}

	//this is need to avoid the CORS issues when calling options
	@OPTIONS
	@Path("{path : .*}")
	public Response options() {
	    return Response.ok("")
	            .header("Access-Control-Allow-Origin", "*")
	            .header("Access-Control-Allow-Headers", "origin, content-type, accept, authorization")
	            .header("Access-Control-Allow-Credentials", "true")
	            .header("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS, HEAD")
	            .header("Access-Control-Max-Age", "1209600")
	            .build();
	}

	@POST
	@Path("/filterbyhierarchy")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public Response FilterByHierarchy(SimpleRequest request) throws UnauthorizedException, MDLServerException{
		String result = "error";
		if(request == null){
			logger.warn("Request is null");
			JSONObject responseobj = new JSONObject();
			responseobj.put("response", "Error:"+ErrorCodes.INVALID_DATA);
			return Response.ok(responseobj.toString()).build();
		}

		if (!TokenValidation.ValidateToken(request.token)) {
			logger.warn("Invalid token,token:" + request.token);
			throw new UnauthorizedException(new Throwable("Invalid token"));
		}
		try{

			Gson gson=new Gson();
			TrackingResult resultObj=GetFilterResults(request.token,request.hierarchyId);
			result =gson.toJson(resultObj);

		}catch(Exception ex){
			logger.error(ex);
			throw new MDLServerException(ex);
		}

		return Response.ok(result).build();
	}



	private TrackingResult GetFilterResults(String token,int hierarchyId) throws Exception{
		int orgid = 0;
		TrackingResult ird=new TrackingResult();
		Statement statement = null;
		Connection conn = null;
		ResultSet rs = null;
		try {
			//get the organization id
			logger.info("Got Parameters for GetFilterResults : token :"+token+" hierarchy Id :"+hierarchyId);
			orgid=SubscriptionQuerryHandler.getOrganizationId(token);
			//preapre the polling station list based on the hierarchy
			String stationList=GetPollingStationList(hierarchyId,orgid).replaceAll(",$", "");


			String blrQry="select track.pollingstationid as stationid, "
					+ "psm.getarrivaltime(track.id) as arrivaltime, "
					+ "td.ballot_box_number, "
					+ "IFNULL(track.longtitude,0) as longtitude, "
					+ "IFNULL(track.latitude, 0) as latitude, "
					+ "cc.name as counting_center_id, "
					+ "track.status as status, "
					+ "IFNULL(cc.latitude, 0) as destination_latitude, "
					+ "IFNULL(cc.longitude,0) as destination_longtitude, "
					+ "p.name as polling_station, "
					+ "'success' as response "
					+ "from psm.tracking track "
					+ "inner join "
					+ "( "
					+ "select "
					+ "MAX(t.id) as trackingid "
					+ ",GROUP_CONCAT(pse.ballot_box_number) as ballot_box_number "
					+ "from "
					+ "psm.tracking t inner join psm.polling_station_election pse "
					+ "on pse.polling_station_id = t.pollingstationid and pse.election_id = t.election_id and pse.organization_id = t.organization_id "
					+ "inner join psm.election e on pse.election_id = e.id and pse.organization_id = t.organization_id "
					+ "where t.organization_id = " + orgid + " "
					+ "and date(e.election_date_start)=date(current_date) and pse.polling_station_id in (" + stationList + " ) "
					+ "GROUP BY t.pollingstationid "
					+ ") td on track.id = td.trackingid "
					+ "INNER JOIN psm.polling_station_election_counting psec on "
					+ "psec.polling_station_id = track.pollingstationid and psec.election_id = track.election_id and psec.organization_id = track.organization_id "
					+ "inner join psm.counting_center cc on psec.counting_center_id = cc.id and psec.organization_id = cc.organization_id "
					+ "inner join psm.polling_station p on psec.polling_station_id = p.id "
					+ "order by p.id;";

			//System.out.println(blrQry);
			conn = DatabaseConnectionManager.getConnection();
			statement = conn.createStatement();
			rs = statement.executeQuery(blrQry);
			ird.result=new TrackingListDto();
			ird.result.entry=new ArrayList<TrackingDto>();
			while(rs.next()){
				TrackingDto entry=new TrackingDto();
				entry.response=rs.getString("response");
				entry.ballot_box_number=rs.getString("ballot_box_number");
				entry.stationid=rs.getString("stationid");
				entry.destination_latitude=rs.getString("destination_latitude");
				entry.polling_station=rs.getString("polling_station");
				entry.counting_center_id=rs.getString("counting_center_id");
				entry.longtitude=rs.getString("longtitude");
				entry.destination_longtitude=rs.getString("destination_longtitude");
				entry.latitude=rs.getString("latitude");
				entry.arrivaltime=rs.getString("arrivaltime");
				entry.status=rs.getString("status");
				ird.result.entry.add(entry);
			}

		}
		finally {
			if(rs!= null){
				rs.close();
			}
			if (statement != null) {
				statement.close();
		}
			if(conn != null){
			conn.close();
			}
	}
		return ird;
	}

	private String GetPollingStationList(int hierarchyId,int orgId) throws Exception{
		StringBuilder sb=new StringBuilder();
		Statement statement1 = null;
		Statement statement2 = null;
		Connection conn = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		try{


			int selHrc=0;
			//first get all the polling stations under this hierarchy
			String query0 = "SELECT id FROM psm.polling_station where hierarchy_value_id="+ hierarchyId +" and organization_id=" + orgId + ";";
			//add all the polling station ids

			conn= DatabaseConnectionManager.getConnection();
			statement1 = conn.createStatement();
			rs1 = statement1.executeQuery(query0);
			while(rs1.next()){
				sb.append(rs1.getInt("id")+ ",");
			}


			//now check child hierarchies for this hierachy and recurse
			String query1 = "SELECT id FROM psm.hierarchy_value where parent_id="+ hierarchyId +" and organization_id=" + orgId + ";";

			statement2= conn.createStatement();
			rs2 = statement2.executeQuery(query1);
			while(rs2.next()){
				selHrc = rs2.getInt("id");
				sb.append(GetPollingStationList(selHrc,orgId)) ;
			}

		}finally {
			if(rs1!= null){
				rs1.close();
			}
			if (statement1 != null) {
				statement1.close();
		}
			if(rs2!= null){
				rs2.close();
			}
			if (statement2 != null) {
				statement2.close();
		}
			if(conn != null){
			conn.close();
			}
	}
		return sb.toString();
	}

}