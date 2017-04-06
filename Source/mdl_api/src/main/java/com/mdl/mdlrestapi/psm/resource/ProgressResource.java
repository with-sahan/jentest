package com.mdl.mdlrestapi.psm.resource;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;

import javax.ws.rs.Consumes;
import javax.ws.rs.OPTIONS;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import com.mdl.mdlrestapi.psm.service.ProgressService;
import com.mdl.mdlrestapi.psm.service.impl.ProgressServiceImpl;
import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONObject;


import com.mdl.mdlrestapi.psm.controller.ProgressController;
import com.mdl.mdlrestapi.psm.resource.dto.CollectPostalPackRequest;
import com.mdl.mdlrestapi.psm.utils.RequestValidationUtil;
import com.mdl.mdlrestapi.util.ErrorCodes;
import com.mdl.mdlrestapi.util.SimpleRequest;
import com.mdl.mdlrestapi.util.TokenValidation;
import com.mdl.mdlrestapi.util.database.DatabaseConnectionManager;
import com.mdl.mdlrestapi.util.exception.MDLServerException;
import com.mdl.mdlrestapi.util.exception.UnauthorizedException;
import com.mdl.mdlrestapi.util.models.RecordProgressDto;
import com.mdl.mdlrestapi.util.models.UpdateRecordProgressWrapper;

@Path("/progress")
public class ProgressResource {

    private static final Logger logger = Logger.getLogger(ProgressResource.class);
	ProgressService progressService = new ProgressServiceImpl();
	private ProgressController progressController;

	public ProgressResource() {
		progressController = new ProgressController();
	}

	
    @POST
    @Path("/completeprogresssequence")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response completeProgressSequence(CollectPostalPackRequest request) {
        if (!RequestValidationUtil.inputValidation(request)) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        }
        String result = null;
        try {
        	return Response.status(Response.Status.NOT_FOUND.getStatusCode()).build();
            //result = pollingStationService.getPollingContact(request.getToken());
        } catch (Exception e) {
			logger.error(e);
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(e.getMessage()).build();
      }
        //return Response.status(Response.Status.OK.getStatusCode()).entity(result).build();
    }

	@POST
	@Path("/updateprogress")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes("application/json")
	public Response updateRecordProgress(UpdateRecordProgressWrapper request) {

		if (!RequestValidationUtil.inputValidation(request)) {
			return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
		}
		// TODO Remove saving object one by one , instead use a list. (need to
		// implement update_progress_v2 logic in JAXRS layer?)
		try {
			boolean allSucess = false;
				allSucess = progressService.performUpdateProgress(request);
				if (!allSucess) {
					JSONObject responseobj = new JSONObject();
					responseobj.put("response", "fail");
					return Response.ok(responseobj.toString()).build();
				}
			JSONObject responseobj = new JSONObject();
			responseobj.put("response", "sucess");
			return Response.ok(responseobj.toString()).build();

		} catch (Exception e) {
			logger.error(e);
			return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(e.getMessage()).build();
			
		}

	}

	@POST
	@Path("/getprogress")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes("application/json")
	public Response getProgress(SimpleRequest request) {
        if(logger.isDebugEnabled()){
		logger.debug("getprogress request recieved:" + request);
        }
		JSONObject resultobj = new JSONObject();
		JSONArray entryarray = new JSONArray();
		if (!RequestValidationUtil.inputValidationToken(request) || !RequestValidationUtil.inputValidation(request.electionId, request.stationid)) {
			return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
		}
		try {
			entryarray = progressController.getProgressPoressData(request);
		} catch (Exception e) {
			logger.error(e);
			return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(e.getMessage()).build();
		}
		resultobj.put("results", entryarray);
		return Response.status(200).entity(resultobj.toString()).build();
	}

	@POST
	@Path("/getprogressv2")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public Response getProgressNew(SimpleRequest request){
		if (!RequestValidationUtil.inputValidationToken(request) || !RequestValidationUtil.inputValidation(request.electionId, request.stationid)) {
			return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
		}
		try{
			JSONObject resultobj = new JSONObject();
			resultobj = progressController.getProgress(request);
			return Response.status(200).entity(resultobj.toString()).build();
		} catch (Exception e) {
			logger.error(e);
			return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(e.getMessage()).build();
		}
	}
    
}
