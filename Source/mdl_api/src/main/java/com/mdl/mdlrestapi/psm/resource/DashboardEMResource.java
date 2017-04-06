package com.mdl.mdlrestapi.psm.resource;

import java.util.ArrayList;
import java.util.List;
import javax.ws.rs.Consumes;
import javax.ws.rs.OPTIONS;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import org.apache.log4j.Logger;
import com.google.gson.Gson;

import com.mdl.mdlrestapi.psm.service.EMDashBoardService;
import com.mdl.mdlrestapi.psm.service.impl.EMDashBoardServiceImpl;
import com.mdl.mdlrestapi.psm.utils.RequestValidationUtil;
import com.mdl.mdlrestapi.util.SimpleRequest;
import com.mdl.mdlrestapi.util.exception.MDLServerException;
import com.mdl.mdlrestapi.util.exception.UnauthorizedException;
import com.mdl.mdlrestapi.util.models.ElectionDto;
import com.mdl.mdlrestapi.util.models.EmDashboardDto;
import com.mdl.mdlrestapi.util.models.EmDashboardGridData;
import com.mdl.mdlrestapi.util.models.GraphBallotStatsDto;
import com.mdl.mdlrestapi.util.models.PollingStationElectionDto;

@Path("/emdashboard")
public class DashboardEMResource {
    EMDashBoardService emDashBoardService = new EMDashBoardServiceImpl();
    private static final Logger logger = Logger.getLogger(DashboardEMResource.class);

    @POST
    @Path("/getelectionsbyhierarchy")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response GetElectionsByHierarchy(SimpleRequest request)  {
        if (!RequestValidationUtil.inputValidationToken(request) || !RequestValidationUtil.inputValidation(request.hierarchyId)) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        } else {
            try {
                Gson gson = new Gson();
                List<ElectionDto> elList = new ArrayList<ElectionDto>();
                elList = emDashBoardService.getElectionList(request.hierarchyId, request.token);
                return Response.ok(gson.toJson(elList)).build();
            } catch (Exception ex) {
                logger.error(ex.getMessage());
                return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).build();
            }
        }
    }

    @POST
    @Path("/getsumstats")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response GetSumStats(SimpleRequest request)  {
        if (!RequestValidationUtil.inputValidationToken(request) || !RequestValidationUtil.inputValidation(request.hierarchyId, request.electionId)) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        } else {
            try {
                List<EmDashboardGridData> statList = new ArrayList<EmDashboardGridData>();
                statList = emDashBoardService.getAllSumStats(request.token, request.hierarchyId, request.electionId);
                Gson gson = new Gson();
                return Response.ok(gson.toJson(statList)).build();
            } catch (Exception ex) {
                logger.error(ex.getMessage());
                return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).build();
            }
        }
    }

    @POST
    @Path("/getstatsbyelection")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response getStatsByElection(SimpleRequest request)  {
        if (!RequestValidationUtil.inputValidationToken(request) || !RequestValidationUtil.inputValidation(request.hierarchyId, request.electionId)) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        } else {
            try {
                List<EmDashboardDto> statList = new ArrayList<EmDashboardDto>();
                statList = emDashBoardService.getStats(request.hierarchyId, request.token, request.electionId);
                Gson gson = new Gson();
                return Response.ok(gson.toJson(statList)).build();
            } catch (Exception ex) {
                logger.error(ex.getMessage());
                return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).build();
            }
        }
    }

    @POST
    @Path("/getissuecountgraphstats")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response GetIssueCountGraphStats(SimpleRequest request) {
        if (!RequestValidationUtil.inputValidationToken(request) || !RequestValidationUtil.inputValidation(request.hierarchyId)) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        }
        try {
            String data = emDashBoardService.getIssueCountGraphStats(request);
            return Response.ok(data).build();
        } catch (Exception e) {
            logger.error(e.getMessage());
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).build();
        }
    }

    @POST
    @Path("/getpollingstationdetails")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response getPollingStationDetails(SimpleRequest request) {
        if (!RequestValidationUtil.inputValidationToken(request) || !RequestValidationUtil.inputValidation(request.hierarchyId)) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        }
        try {
            List<PollingStationElectionDto> pollingStationElections = emDashBoardService.processGetPollingStationDetails_v2(request.token,
                    request.hierarchyId);
            return Response.ok(new Gson().toJson(pollingStationElections)).build();
        } catch (Exception e) {
            logger.error(e.getMessage());
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).build();
        }
    }

    @POST
    @Path("/getballotissuegraphstats_v2")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response getBallotIssueGraphStats(SimpleRequest request) {
        if (!RequestValidationUtil.inputValidationToken(request) || !RequestValidationUtil.inputValidation(request.hierarchyId)) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        }
        try {
            Gson gson = new Gson();
            ArrayList<GraphBallotStatsDto> resultMap = emDashBoardService.getBallotGraphStats(request.token, request.hierarchyId);
            return Response.ok(gson.toJson(resultMap)).build();
        } catch (Exception ex) {
            logger.error(ex.getMessage());
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).build();
        }
    }

    @POST
    @Path("/getpostalcollectgraphstats_v2")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response getPostalCollectGraphStats(SimpleRequest request) {
        if (!RequestValidationUtil.inputValidationToken(request) || !RequestValidationUtil.inputValidation(request.hierarchyId)) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        }
        try {
            Gson gson = new Gson();
            ArrayList<GraphBallotStatsDto> resultMap = emDashBoardService.getPostalGraphStats(request.token, request.hierarchyId);
            return Response.ok(gson.toJson(resultMap)).build();
        } catch (Exception ex) {
            logger.error(ex.getMessage());
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).build();
        }
    }

}

