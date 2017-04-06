package com.mdl.mdlrestapi.psm.resource;

import javax.ws.rs.Consumes;
import javax.ws.rs.OPTIONS;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.apache.log4j.Logger;

import com.mdl.mdlrestapi.psm.resource.dto.TokenRequest;
import com.mdl.mdlrestapi.psm.service.OrganizationService;
import com.mdl.mdlrestapi.psm.service.impl.OrganizationServiceImpl;

@Path("/organization")
public class OrganizationResource {
	private static final Logger logger = Logger.getLogger(OrganizationResource.class);
	private OrganizationService organizationService = new OrganizationServiceImpl();
		
	@POST
	@Path("/getorginfo")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	public Response GetOrganizationInfo(TokenRequest token){
		if(token == null || ( token.getToken().isEmpty())){
			return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
		}
		try{
			return Response.ok(organizationService.getOrganizationInformation(token.getToken())).build();
		}catch(Exception e){
			logger.error(e);
			return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).build();
		}
		
	}
}
