package com.mdl.mdlrestapi.psm.resource;

import com.google.gson.Gson;
import com.mdl.mdlrestapi.psm.service.StatisticService;
import com.mdl.mdlrestapi.psm.service.impl.StatisticServiceImpl;
import com.mdl.mdlrestapi.psm.utils.RequestValidationUtil;
import com.mdl.mdlrestapi.util.ErrorCodes;
import com.mdl.mdlrestapi.util.SimpleRequest;
import com.mdl.mdlrestapi.util.TokenValidation;
import com.mdl.mdlrestapi.util.exception.MDLServerException;
import com.mdl.mdlrestapi.util.exception.UnauthorizedException;
import com.mdl.mdlrestapi.util.models.CloseStatsDto;
import com.mdl.mdlrestapi.util.models.CloseStatsSummeryDto;
import org.apache.log4j.Logger;
import org.json.JSONObject;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.ArrayList;

/**
 * Created with IntelliJ IDEA.
 * User: Lasantha
 * Date: 03/08/17
 * Time: 6:23 PM
 * To change this template use File | Settings | File Templates.
 */
@Path("/getstats")
public class StatisticResource {
    private static final Logger logger = Logger.getLogger(StatisticResource.class);
    StatisticService statisticService = new StatisticServiceImpl();

    @POST
    @Path("/getallclosestatssummary_v3")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response getAllCloseStatsSummery(SimpleRequest request) {
        if (!RequestValidationUtil.inputValidationToken(request) || !RequestValidationUtil.inputValidation(request.electionId, request.hierarchyId)) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        }
        try {
            Gson gson = new Gson();
            ArrayList<CloseStatsSummeryDto> resultMap = statisticService.getAllCloseStatsSummery(request.token,request.electionId,request.hierarchyId);
            return Response.ok(gson.toJson(resultMap)).build();
        } catch (Exception ex) {
            logger.error(ex.getMessage());
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).build();
        }
    }

    @POST
    @Path("/getallclosestats_v3")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response getStatsTable(SimpleRequest request) {
        if (!RequestValidationUtil.inputValidationToken(request) || !RequestValidationUtil.inputValidation(request.electionId, request.hierarchyId)) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        }
        try {
            Gson gson = new Gson();
            ArrayList<CloseStatsDto> resultMap = statisticService.getAllCloseStats(request.token,request.electionId,request.hierarchyId);
            return Response.ok(gson.toJson(resultMap)).build();
        } catch (Exception ex) {
            logger.error(ex.getMessage());
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).build();
        }
    }

    @POST
    @Path("/csvballotaccountexport")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response getBallotIssueGraphStats(SimpleRequest request) {
        if (!RequestValidationUtil.inputValidationToken(request) || !RequestValidationUtil.inputValidation(request.electionId)) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        }
        try {
            Gson gson = new Gson();
            String resultMap = statisticService.updateAllCloseStats(request.token,request.electionId);
            return Response.ok(gson.toJson(resultMap)).build();
        } catch (Exception ex) {
            logger.error(ex.getMessage());
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).build();
        }
    }

    @POST
    @Path("/csvballotaccountunexport")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response getUnexportStatsTable(SimpleRequest request) {
        if (!RequestValidationUtil.inputValidationToken(request) || !RequestValidationUtil.inputValidation(request.electionId, request.hierarchyId)) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        }
        try {
            Gson gson = new Gson();
            ArrayList<CloseStatsDto> resultMap = statisticService.getUnexportedAllCloseStats(request.token,request.electionId,request.hierarchyId);
            return Response.ok(gson.toJson(resultMap)).build();
        } catch (Exception ex) {
            logger.error(ex.getMessage());
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).build();
        }
    }




}
