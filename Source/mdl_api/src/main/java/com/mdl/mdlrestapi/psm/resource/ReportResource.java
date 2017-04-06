package com.mdl.mdlrestapi.psm.resource;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.HttpHeaders;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import com.google.gson.Gson;
import com.mdl.mdlrestapi.psm.resource.dto.TenderedVotesRequest;
import com.mdl.mdlrestapi.util.models.IssueDtoEntry;
import com.mdl.mdlrestapi.util.models.TenderedVotesDTO;
import org.apache.log4j.Logger;

import com.mdl.mdlrestapi.psm.exception.MDLServiceException;
import com.mdl.mdlrestapi.psm.resource.dto.TokenRequest;
import com.mdl.mdlrestapi.psm.service.ReportService;
import com.mdl.mdlrestapi.psm.service.impl.ReportServiceImpl;
import com.mdl.mdlrestapi.psm.utils.RequestValidationUtil;
import com.mdl.mdlrestapi.psm.utils.SecurityUtility;
import com.mdl.mdlrestapi.util.SimpleRequest;

import java.util.ArrayList;

/**
 * @Author : Rushan
 * @Date : Mar 25, 2017
 * @TIme : 11:10:32 PM
 */
@Path("/reports")
public class ReportResource {
	ReportService reportService = new ReportServiceImpl();
	private static final Logger logger = Logger.getLogger(ReportResource.class);
	@POST
	@Path("hourlyanalysis")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	public Response getHourlyAnalysisData(SimpleRequest request) {
		if (!RequestValidationUtil.inputValidationToken(request)
				|| !RequestValidationUtil.inputValidation(request.hierarchyId)) {
			return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
		}

		String result = null;
		try {
			result = reportService.getHoulyAnalysisData(request);
			return Response.status(Response.Status.OK.getStatusCode()).entity(result).build();
		} catch (Exception ex) {
			logger.error(ex.getMessage());
			return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).build();
		}
	}

	@GET
	@Path("pdf-hourlyanalysis")
	@Produces(MediaType.APPLICATION_OCTET_STREAM)
	public Response getHourlyAnalysisPDF(@QueryParam("hierarchyId") int hierarchyId, @Context HttpHeaders headers) {	
		String token = "";
		try {
			token = SecurityUtility.getUsernameAndOrganization(headers);
        } catch (MDLServiceException e) {
            return Response.status(Response.Status.UNAUTHORIZED.getStatusCode()).build();
        }
		
		if (!RequestValidationUtil.inputValidation(hierarchyId)) {
			return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
		}

		SimpleRequest request = new SimpleRequest();
		request.hierarchyId = hierarchyId;
		request.token = token;
		byte[] pdfBytes = null;
		Response.ResponseBuilder response = null;
		try {
			pdfBytes = reportService.getHoulyAnalysisPDF(request);
			response = Response.ok(pdfBytes);
			response.header("Content-Disposition", "attachment; filename=HourlyAnalysis.pdf");
			return response.build();
		} catch (Exception ex) {
			logger.error(ex.getMessage());
			return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).build();
		}
	}
	
	@POST
	@Path("psm-hourlyanalysis")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	public Response getHourlyAnalysisByUser(TokenRequest request) {
		if (!RequestValidationUtil.inputValidation(request)) {
			return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
		}

		String result = null;
		try {
			result = reportService.getHoulyAnalysisDataByUser(request);
			return Response.status(Response.Status.OK.getStatusCode()).entity(result).build();
		} catch (Exception ex) {
			logger.error(ex.getMessage());
			return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).build();
		}
	}


	//Report service form features
	@POST
	@Path("/getalltenderedvotes")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public Response getAllTenderedVotes(TokenRequest request) {
		if (!RequestValidationUtil.inputValidation(request)) {
			return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
		}
		String result = null;
		try {
			result = reportService.getAllTenderedVotes(request);
		} catch (Exception e) {
			logger.error(e.getMessage());
			return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(e.getMessage()).build();
		}
		return Response.status(Response.Status.OK.getStatusCode()).entity(result).build();
	}

	@POST
	@Path("/gettenderedvotebyid")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public Response getTenderedVotesById(TenderedVotesRequest request) {
		if (!RequestValidationUtil.inputValidation(request)) {
			return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
		}
		String result = null;
		try {
			result = reportService.getTenderedVotesById(request);
		} catch (Exception e) {
			logger.error(e.getMessage());
			return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(e.getMessage()).build();
		}
		return Response.status(Response.Status.OK.getStatusCode()).entity(result).build();
	}

	@POST
	@Path("/addtotenderedvotes")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public Response addToTenderedVotes(TenderedVotesRequest request) {
		if (!RequestValidationUtil.inputValidation(request)) {
			return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
		}
		String result = null;
		try {
			result = reportService.addToTenderedVotes(request);
		} catch (Exception e) {
			logger.error(e.getMessage());
			return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(e.getMessage()).build();
		}
		return Response.status(Response.Status.OK.getStatusCode()).entity(result).build();
	}

	@POST
	@Path("/updatetenderedvote")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public Response updateTenderedVote(TenderedVotesRequest request) {
		if (!RequestValidationUtil.inputValidation(request)) {
			return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
		}
		String result = null;
		try {
			result = reportService.updateTenderedVote(request);
		} catch (Exception e) {
			logger.error(e.getMessage());
			return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(e.getMessage()).build();
		}
		return Response.status(Response.Status.OK.getStatusCode()).entity(result).build();
	}

	@POST
	@Path("/deletetenderedvote")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public Response deleteTenderedVote(TenderedVotesRequest request) {
		if (!RequestValidationUtil.inputValidation(request)) {
			return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
		}
		String result = null;
		try {
			result = reportService.deleteTenderedVote(request);
		} catch (Exception e) {
			logger.error(e.getMessage());
			return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(e.getMessage()).build();
		}
		return Response.status(Response.Status.OK.getStatusCode()).entity(result).build();
	}

    @POST
    @Path("/gettenderedvotelist")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response getTenderedVoters(SimpleRequest request) {

        if (!RequestValidationUtil.inputValidationToken(request) || !RequestValidationUtil.inputValidation(request.hierarchyId)) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        } else {
            try {
                Gson gson = new Gson();
                ArrayList<TenderedVotesDTO> resultMap = reportService.getTenderedVotersByHierarchyId(request);
                return Response.ok(gson.toJson(resultMap)).build();

            } catch (Exception ex) {
                logger.error(ex.getMessage());
                return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).build();
            }
        }
    }


}
