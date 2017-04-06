package com.mdl.mdlrestapi.psm.resource;

import javax.ws.rs.Consumes;
import javax.ws.rs.OPTIONS;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import com.mdl.mdlrestapi.psm.resource.dto.AssignIssueRequest;
import com.mdl.mdlrestapi.util.ErrorCodes;
import com.mdl.mdlrestapi.util.TokenValidation;
import com.mdl.mdlrestapi.util.exception.MDLServerException;
import com.mdl.mdlrestapi.util.exception.UnauthorizedException;
import com.mdl.mdlrestapi.util.models.ReportIssueAllStationsRequest;
import org.apache.log4j.Logger;

import com.mdl.mdlrestapi.psm.resource.dto.IssueReportAllStationRequest;
import com.mdl.mdlrestapi.psm.service.IssueService;
import com.mdl.mdlrestapi.psm.service.impl.IssueServiceImpl;
import com.mdl.mdlrestapi.psm.utils.RequestValidationUtil;
import org.json.JSONObject;

/**
 * Created by Thara on 3/12/2017.
 */
@Path("/reportissueservices")
public class ReportIssueResource {
    private static final Logger logger = Logger.getLogger(ReportIssueResource.class);
    IssueService issueService = new IssueServiceImpl();

    @POST
    @Path("/reportissueallstations")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response ReportIssueToAllStations(IssueReportAllStationRequest request){
        if (!RequestValidationUtil.inputValidation(request)) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        }
        String result = null;
        try {
            result = issueService.reportIssueToAllStations(request);
        } catch (Exception e) {
            logger.error(e);
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(e.getMessage()).build();
        }
        return Response.status(Response.Status.OK.getStatusCode()).entity(result).build();
    }

//    @POST
//    @Path("/reportissue")
//    @Produces(MediaType.APPLICATION_JSON)
//    @Consumes(MediaType.APPLICATION_JSON)
//    public Response reportIssue(ReportIssueAllStationsRequest request){
//        if (!RequestValidationUtil.inputValidation(request)) {
//            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
//        }
//        String result = null;
//        try {
////            result = issueService.saveIssueReport(request);
//        } catch (Exception e) {
//            logger.error(e);
//            return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(e.getMessage()).build();
//        }
//        return Response.status(Response.Status.OK.getStatusCode()).entity(result).build();
//    }

//    @POST
//    @Path("/assignissue")
//    @Produces(MediaType.APPLICATION_JSON)
//    @Consumes(MediaType.APPLICATION_JSON)
//    public Response assignIssue(AssignIssueRequest request){
//        if (!RequestValidationUtil.inputValidation(request)) {
//            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
//        }
//        String result = null;
//        try {
//            result = issueService.assignIssue(request);
//        } catch (Exception e) {
//            logger.error(e);
//            return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(e.getMessage()).build();
//        }
//        return Response.status(Response.Status.OK.getStatusCode()).entity(result).build();
//    }

    @POST
    @Path("/assignissue")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response assignIssue(AssignIssueRequest request){
        if (!RequestValidationUtil.inputValidation(request)) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        }
        try {
            boolean suceed = issueService.performAssignIssue(request);
            JSONObject responseobj = new JSONObject();

            if (suceed) {
                responseobj.put("response", "success");
                return Response.ok(responseobj.toString()).build();
            } else {
                responseobj.put("response", "Error");
                return Response.ok(responseobj.toString()).build();
            }
        } catch (Exception ex) {
            logger.error(ex);
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(ex.getMessage()).build();
        }
    }


    @POST
    @Path("/reportissue")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response reportIssue(ReportIssueAllStationsRequest request) {

        if (!RequestValidationUtil.inputValidation(request)) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        }

        try {
            boolean suceed = issueService.performReportIssue(request);
            JSONObject responseobj = new JSONObject();

            if (suceed) {
                responseobj.put("response", "success");
                return Response.ok(responseobj.toString()).build();

            } else {
                responseobj.put("response", "Error");
                return Response.ok(responseobj.toString()).build();

            }
        } catch (Exception ex) {
            logger.error(ex);
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(ex.getMessage()).build();
        }
    }










}
