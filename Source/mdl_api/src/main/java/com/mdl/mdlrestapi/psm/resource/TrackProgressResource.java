package com.mdl.mdlrestapi.psm.resource;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import com.google.gson.Gson;
import com.mdl.mdlrestapi.psm.resource.dto.GpsRequest;
import com.mdl.mdlrestapi.psm.resource.dto.TokenRequest;
import com.mdl.mdlrestapi.psm.service.TrackProgressService;
import com.mdl.mdlrestapi.psm.service.impl.TrackProgressServiceImpl;
import com.mdl.mdlrestapi.psm.utils.RequestValidationUtil;
import com.mdl.mdlrestapi.util.ErrorCodes;
import com.mdl.mdlrestapi.util.SimpleRequest;
import com.mdl.mdlrestapi.util.TokenValidation;
import com.mdl.mdlrestapi.util.exception.MDLServerException;
import com.mdl.mdlrestapi.util.exception.UnauthorizedException;
import com.mdl.mdlrestapi.util.models.TrackingDto;
import com.mdl.mdlrestapi.util.models.TrackingResult;
import org.apache.log4j.Logger;
import org.json.JSONObject;

import java.util.ArrayList;

/**
 * @Author	: Rushan
 * @Date	: Feb 26, 2017
 * @TIme	: 11:17:32 PM
 */
@Path("/gpstrack")
public class TrackProgressResource {
	private static final Logger logger = Logger.getLogger(TrackProgressResource.class);
	TrackProgressService trackProgressService = new TrackProgressServiceImpl();
	//this is need to avoid the CORS issues when calling options

	@POST
	@Path("/getmapcenter")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	public Response getMapCentre(TokenRequest request){
		
		if(!RequestValidationUtil.inputValidation(request)){
			return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
		}
		try{
			String result = null;
			result = trackProgressService.getMapCenter(request);
			return Response.ok(result).build();
			
		}catch (Exception e){
			logger.error(e.getMessage());
			return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).build();
		}
		
	}
	
	@POST
	@Path("starttrack")
	public Response startTracking(GpsRequest request) {
		
		if(!RequestValidationUtil.inputValidation(request)){
			return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
		}
		try{
			String result = null;
			result = trackProgressService.startTracking(request);
			return Response.ok(result).build();					
		}catch (Exception e){
			logger.error(e.getMessage());
			return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).build();
		}
	}
	
	@POST
	@Path("updatetrack")
	public Response updateTracking(GpsRequest request) {
		
		if(!RequestValidationUtil.inputValidation(request)){
			return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
		}
		try{
			String result = null;
			result = trackProgressService.updateTracking(request);
			return Response.ok(result).build();					
		}catch (Exception e){
			logger.error(e.getMessage());
			return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).build();
		}
	}
	
	@POST
	@Path("closetrack")
	public Response closeTracking(TokenRequest request) {
		
		if(!RequestValidationUtil.inputValidation(request)){
			return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
		}
		try{
			String result = null;
			result = trackProgressService.closeTracking(request);
			return Response.ok(result).build();					
		}catch (Exception e){
			logger.error(e.getMessage());
			return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).build();
		}
	}

	@POST
	@Path("filterbyhierarchy")
	public Response FilterByHierarchy(SimpleRequest request) {

		if (!RequestValidationUtil.inputValidationToken(request) || !RequestValidationUtil.inputValidation(request.hierarchyId)) {
			return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
		}
		try{
			ArrayList<TrackingDto> resultList = trackProgressService.getFilterResults(request.token,request.hierarchyId);
			return Response.ok(resultList).build();
		}catch (Exception e){
			logger.error(e.getMessage());
			return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).build();
		}
	}

}
