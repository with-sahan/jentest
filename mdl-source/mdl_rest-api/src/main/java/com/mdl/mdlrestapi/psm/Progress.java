package com.mdl.mdlrestapi.psm;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.ws.rs.Consumes;
import javax.ws.rs.OPTIONS;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONObject;

import com.mdl.mdlrestapi.psm.controller.ProgressController;
import com.mdl.mdlrestapi.util.ErrorCodes;
import com.mdl.mdlrestapi.util.SimpleRequest;
import com.mdl.mdlrestapi.util.TokenValidation;
import com.mdl.mdlrestapi.util.database.DatabaseConnectionManager;
import com.mdl.mdlrestapi.util.exception.MDLServerException;
import com.mdl.mdlrestapi.util.exception.UnauthorizedException;
import com.mdl.mdlrestapi.util.models.RecordProgressDto;
import com.mdl.mdlrestapi.util.models.UpdateRecordProgressWrapper;


@Path("/progress")
public class Progress {

	private static final Logger logger = Logger
			.getLogger(Progress.class);
	
	private ProgressController progressController;
	
	public Progress() 
	{
		progressController = new ProgressController();
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
	@Path("/updateprogress")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes("application/json")
	public Response updateRecordProgress(UpdateRecordProgressWrapper request) throws UnauthorizedException, MDLServerException {

		if (request == null) {
			logger.warn("Request is null");
			JSONObject responseobj = new JSONObject();
			responseobj.put("response", "Error:" + ErrorCodes.INVALID_DATA);
			return Response.ok(responseobj.toString()).build();
		}
		if (!TokenValidation.ValidateToken(request.token)) {
			logger.warn("Invalid token,token:" + request.token);
			throw new UnauthorizedException(new Throwable("Invalid token"));
		}
		// TODO Remove saving object one by one , instead use a list. (need to
		// implement update_progress_v2 logic in JAXRS layer?)
		try {
			boolean allSucess = false;
			for (RecordProgressDto row : request.recordProgressDtoList) {
				allSucess = performUpdateProgress(request.token,request.electionId,request.pollingStationId, row);
				if (!allSucess) {
					JSONObject responseobj = new JSONObject();
					responseobj.put("response", "fail");
					return Response.ok(responseobj.toString()).build();

				}
			}
			JSONObject responseobj = new JSONObject();
			responseobj.put("response", "sucess");
			return Response.ok(responseobj.toString()).build();


		} catch (Exception e) {
			logger.error(e);
			throw new MDLServerException(e);
		}

	}

	private boolean performUpdateProgress(String token, int electionId, int pollingStationId, RecordProgressDto row)
			throws Exception {
		Connection conn = null;
		CallableStatement cs = null;
		ResultSet rs = null;
		try {
			conn = DatabaseConnectionManager.getConnection();
			// stored procedure calling statement
			String callString = "{call psm.updateprogress_v2(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";

			cs = conn.prepareCall(callString);
			// Adding items to arrayList
			cs.setString(1, token);
			cs.setInt(2, electionId);
			cs.setInt(3, pollingStationId);
			cs.setInt(4, row.ballotPapers);
			cs.setInt(5, row.postalPacks);
			cs.setInt(6, row.postalPacksCollected);
			cs.setInt(7, row.spoiltBallots);
			cs.setInt(8, row.tenBallotPapers);
			cs.setInt(9, row.tenSpoiltBallots);
			cs.setInt(10, row.updateTime);
			cs.setInt(11, row.ballotPapers2);
			cs.setInt(12, row.postalPacks2);
			cs.setInt(13, row.postalPacksCollected2);
			cs.setInt(14, row.spoiltBallots2);
			cs.setInt(15, row.tenBallotPapers2);
			cs.setInt(16, row.tenSpoiltBallots2);

			rs = cs.executeQuery();
			String res = "";
			while (rs.next()) {
				res = rs.getString("response");
			}
			if (res.equalsIgnoreCase("success")) {
				return true;
			}
		} finally {
			if (conn != null) {
				conn.close();
			}
			if (cs != null) {
				cs.close();
			}
			if (rs != null) {
				rs.close();
			}
		}
		return false;
	}


	@POST
	@Path("/getprogress")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes("application/json")
	public Response getProgress(SimpleRequest request) throws UnauthorizedException, MDLServerException  {
		logger.info("getprogress request recieved:" +request);
		JSONObject resultobj = new JSONObject();
		JSONArray entryarray = new JSONArray();
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
			entryarray = progressController.getProgressPoressData(request);
		}catch(Exception e){
			logger.error(e);
			throw new MDLServerException(e);
		}
		resultobj.put("results", entryarray);
		return Response.status(200).entity(resultobj.toString()).build();
	}
	
	
	@POST
	@Path("/getprogressv2")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public Response getProgressNew(SimpleRequest request) throws UnauthorizedException, MDLServerException  {
		
		logger.info("getprogressv2 request recieved:" +request);
		JSONObject resultobj = new JSONObject();
		
		if(request == null)
		{
			logger.warn("Request is null");
			JSONObject responseobj = new JSONObject();
			responseobj.put("response", "Error:"+ErrorCodes.INVALID_DATA);
			return Response.ok(responseobj.toString()).build();
		}
		if (!TokenValidation.ValidateToken(request.token)) 
		{
			logger.warn("Invalid token,token:" + request.token);
			throw new UnauthorizedException(new Throwable("Invalid token"));
		}
	
		resultobj = progressController.getProgress(request);

		return Response.status(200).entity(resultobj.toString()).build();
	}
	
}
