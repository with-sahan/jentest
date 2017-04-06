package com.mdl.mdlrestapi.psm.resource;

import javax.ws.rs.Consumes;
import javax.ws.rs.OPTIONS;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import com.mdl.mdlrestapi.psm.resource.dto.ButtonStatusRequest;
import com.mdl.mdlrestapi.psm.service.OpenStationService;
import com.mdl.mdlrestapi.psm.service.impl.OpenStationServiceImpl;
import com.mdl.mdlrestapi.util.SimpleRequest;
import org.apache.log4j.Logger;

/**
 * @author Rushan
 *
 */
@Path("/openstation")
public class OpenStationResource {
	private static final Logger logger = Logger.getLogger(OpenStationResource.class);
	OpenStationService openStationService = new OpenStationServiceImpl();

	@POST
	@Path("/getpollingstationstatus")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	public Response getPollingStationButtonStatus(ButtonStatusRequest request){
		if(!validateInput(request)){
			return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
		}
		try{
			return Response.ok(openStationService.getButtonStatus(request)).build();
		}catch(Exception e){
			logger.error(e);
			return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).build();
		}
		
	}

	private boolean validateInput(ButtonStatusRequest request) {
		if(request.stationid < 1)
			return false;
		if((request.token==null) || (request.token.isEmpty()))
			return false;
			
		return true;
	}

}
