package com.mdl.mdlrestapi.psm.resource;

import java.sql.Connection;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Properties;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import com.mdl.mdlrestapi.psm.dao.impl.ElectionDaoImpl;
import com.mdl.mdlrestapi.psm.resource.dto.*;
import org.apache.log4j.Logger;
import org.json.JSONObject;

import com.mdl.mdlrestapi.psm.service.ElectionService;
import com.mdl.mdlrestapi.psm.service.impl.ElectionServiceImpl;
import com.mdl.mdlrestapi.psm.utils.RequestValidationUtil;
import com.mdl.mdlrestapi.util.ErrorCodes;
import com.mdl.mdlrestapi.util.SimpleRequest;
import com.mdl.mdlrestapi.util.TokenValidation;
import com.mdl.mdlrestapi.util.database.DatabaseConnectionManager;
import com.mdl.mdlrestapi.util.database.subscription.SubscriptionQuerryHandler;
import com.mdl.mdlrestapi.util.exception.MDLServerException;
import com.mdl.mdlrestapi.util.exception.UnauthorizedException;
import com.mdl.mdlrestapi.util.models.ActivationDayRequest;

@Path("/election")
public class ElectionResource {
    private static final Logger logger = Logger.getLogger(ElectionResource.class);
	ElectionService electionService = new ElectionServiceImpl();
	
    @POST
    @Path("/getelectionbyid")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response getElectionByID(ElectionRequest request) {
        if (!RequestValidationUtil.inputValidation(request)) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        }
        String result = null;
        try {
            result = electionService.getElectionByID(request);
        } catch (Exception e) {
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(e.getMessage()).build();
        }
        return Response.status(Response.Status.OK.getStatusCode()).entity(result).build();
    }
    
    @POST
    @Path("/closeelection")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response closeElection(CloseElectionRequest request) {
        if (!RequestValidationUtil.inputValidation(request)) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        }
        String result = null;
        try {
            result = electionService.closeElection(request);
        } catch (Exception e) {
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(e.getMessage()).build();
        }
        return Response.status(Response.Status.OK.getStatusCode()).entity(result).build();
    }

    @POST
    @Path("/update")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response updateElection(ElectionCreateUpdateRequest request) {
        if (!RequestValidationUtil.inputValidation(request, true)) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        }
        String result = null;
        try {
            result = electionService.updateElection(request);
        } catch (Exception e) {
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(e.getMessage()).build();
        }
        return Response.status(Response.Status.OK.getStatusCode()).entity(result).build();
    }

    @POST
    @Path("/delete")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response deleteElection(ElectionDeleteRequest request) {
        if (!RequestValidationUtil.inputValidation(request)) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        }
        String result = null;
        try {
            result = electionService.deleteElection(request);
        } catch (Exception e) {
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(e.getMessage()).build();
        }
        return Response.status(Response.Status.OK.getStatusCode()).entity(result).build();
    }

    @POST
    @Path("/file-upload-data")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response getFileUploadData(ElectionFileUploadStatusRequest request) {
        if (!RequestValidationUtil.inputValidation(request)) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        }
        String result = null;
        try {
            result = electionService.getFileUploadData(request);
        } catch (Exception e) {
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(e.getMessage()).build();
        }
        return Response.status(Response.Status.OK.getStatusCode()).entity(result).build();
    }

    @POST
    @Path("/stations-by-eid")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response getPollingStationsByElectionId(ElectionRequest request) {
        if (!RequestValidationUtil.inputValidation(request)) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        }
        String result = null;
        try {
            result = electionService.getPollingStationsByElectionId(request);
        } catch (Exception e) {
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(e.getMessage()).build();
        }
        return Response.status(Response.Status.OK.getStatusCode()).entity(result).build();
    }


    @POST
    @Path("/findByUser")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response getElection(TokenRequest request) {
        if (!RequestValidationUtil.inputValidation(request)) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        }
        String result = null;
        try {
            result = electionService.getElections(request);
        } catch (Exception e) {
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(e.getMessage()).build();
        }
        return Response.status(Response.Status.OK.getStatusCode()).entity(result).build();
    }

    @POST
    @Path("/create")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response createElection(ElectionCreateUpdateRequest request) {
        if (!RequestValidationUtil.inputValidation(request, false)) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        }
        String result = null;
        try {
            result = electionService.createElection(request);
        } catch (Exception e) {
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(e.getMessage()).build();
        }
        return Response.status(Response.Status.OK.getStatusCode()).entity(result).build();
    }


	/**
	 * @param request
	 * returns the election activation day according to the organization id
	 * @throws UnauthorizedException
	 * @throws MDLServerException
	 */
	@POST
	@Path("/isactivationday")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public Response getElectionsActivationDay(SimpleRequest request) throws UnauthorizedException, MDLServerException {
		if (!RequestValidationUtil.inputValidationToken(request)) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        }else {
			try {
				JSONObject responseobj = new JSONObject();
				responseobj.put("result", electionService.getActivatedDay(request));
				return Response.ok(responseobj.toString()).build();
			}catch(Exception ex){
				logger.error(ex);
				throw new MDLServerException(ex);
			}
		}
	}
	
	

	@POST
	@Path("/updateactivationday")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public Response updateElectionsActivationDay(ActivationDayRequest request) throws UnauthorizedException, MDLServerException {
        if (!RequestValidationUtil.inputValidation(request)) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        }else {
			try {
				JSONObject responseobj = new JSONObject();
				responseobj.put("result", electionService.updateActivatedDay(request));
				return Response.ok(responseobj.toString()).build();
			}catch(Exception ex){
				logger.error(ex);
				throw new MDLServerException(ex);
			}
		}
	}
	

	
	@POST
	@Path("/resettenantdata")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public Response resetData(SimpleRequest request) throws UnauthorizedException, MDLServerException {
        if (!RequestValidationUtil.inputValidationToken(request)) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        }else {
			try {
				JSONObject responseobj = new JSONObject();
				responseobj.put("result", electionService.resetTenantData(request));
				return Response.ok(responseobj.toString()).build();
			}catch(Exception ex){
				logger.error(ex);
				throw new MDLServerException(ex);
			}
		}
	}
	
	


}
