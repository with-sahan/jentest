package com.mdl.mdlrestapi.psm.resource;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import com.mdl.mdlrestapi.psm.resource.dto.TokenRequest;
import com.mdl.mdlrestapi.psm.service.NotificationService;
import com.mdl.mdlrestapi.psm.service.impl.NotificationServiceImpl;
import com.mdl.mdlrestapi.psm.utils.RequestValidationUtil;
import org.apache.log4j.Logger;

@Path("/managerdashboard")
public class EMDashboardResource {
	private static final Logger logger = Logger.getLogger(EMDashboardResource.class);
	NotificationService notificationServive = new NotificationServiceImpl();
	
	@POST
	@Path("/getnotificationcountgraphstats")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)	
	public Response getBPAStatus(TokenRequest request){
		
		if(!RequestValidationUtil.inputValidation(request)){
			return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
		}
		String result = null;
		try {
			result = notificationServive.getNotificationCount(request);
			return Response.status(Response.Status.OK.getStatusCode()).entity(result).build();
		}catch (Exception e){
			logger.error(e.getMessage());
			return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).build();
		}
		
	}
	
	



}
