package com.mdl.mdlrestapi.psm.resource;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import com.google.gson.Gson;
import com.mdl.mdlrestapi.psm.resource.dto.*;
import com.mdl.mdlrestapi.psm.service.IssueService;
import com.mdl.mdlrestapi.psm.service.impl.IssueServiceImpl;
import com.mdl.mdlrestapi.psm.utils.RequestValidationUtil;
import com.mdl.mdlrestapi.util.ErrorCodes;
import com.mdl.mdlrestapi.util.GoogleMail;
import com.mdl.mdlrestapi.util.SimpleRequest;
import com.mdl.mdlrestapi.util.TokenValidation;
import com.mdl.mdlrestapi.util.exception.MDLServerException;
import com.mdl.mdlrestapi.util.exception.UnauthorizedException;
import com.mdl.mdlrestapi.util.models.ElectionDto;
import com.mdl.mdlrestapi.util.models.IssueDtoEntry;
import com.mdl.mdlrestapi.util.models.IssueResultDto;
import com.mdl.mdlrestapi.util.models.UserDto;
import org.apache.log4j.Logger;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: AnushaP
 * Date: 2/24/17
 * Time: 6:23 PM
 * To change this template use File | Settings | File Templates.
 */
@Path("/issues")
public class IssueResource {
    private static final Logger logger = Logger.getLogger(IssueResource.class);
    IssueService issueService = new IssueServiceImpl();

    @POST
    @Path("/chat-resolve")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response getNotificationAll(ChatIssueResolveRequest request) {
        if (!RequestValidationUtil.inputValidation(request)) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        }
        String result = null;
        try {
            result = issueService.updateIssueStatus(request);
        } catch (Exception e) {
            logger.error(e.getMessage());
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(e.getMessage()).build();
        }
        return Response.status(Response.Status.OK.getStatusCode()).entity(result).build();
    }

    @POST
    @Path("/chat")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response getChat(ChatIssueRequest request) {
        if (!RequestValidationUtil.inputValidation(request)) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        }
        String result = null;
        try {
            result = issueService.getChatIssue(request);
        } catch (Exception e) {
            logger.error(e.getMessage());
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(e.getMessage()).build();
        }
        return Response.status(Response.Status.OK.getStatusCode()).entity(result).build();
    }

    @POST
    @Path("/list")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response getChat(TokenRequest request) {
        if (!RequestValidationUtil.inputValidation(request)) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        }
        String result = null;
        try {
            result = issueService.getIssues(request);
        } catch (Exception e) {
            logger.error(e.getMessage());
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(e.getMessage()).build();
        }
        return Response.status(Response.Status.OK.getStatusCode()).entity(result).build();
    }

    @POST
    @Path("/all")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response getAllIssues(StationRequest request) {
        if (!RequestValidationUtil.inputValidation(request)) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        }
        String result = null;
        try {
            result = issueService.getAllIssues(request);
        } catch (Exception e) {
            logger.error(e.getMessage());
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(e.getMessage()).build();
        }
        return Response.status(Response.Status.OK.getStatusCode()).entity(result).build();
    }

    @POST
    @Path("/report")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response reportIssue(IssueReportRequest request) {
        if (!RequestValidationUtil.inputValidation(request)) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        }
        String result = null;
        try {
            result = issueService.saveIssueReport(request);
        } catch (Exception e) {
            logger.error(e.getMessage());
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(e.getMessage()).build();
        }
        return Response.status(Response.Status.OK.getStatusCode()).entity(result).build();
    }

    @POST
    @Path("/update")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response updateIssue(IssueRequest request) {
        if (!RequestValidationUtil.inputValidation(request)) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        }
        String result = null;
        try {
            result = issueService.updateIssue(request);
        } catch (Exception e) {
            logger.error(e.getMessage());
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(e.getMessage()).build();
        }
        return Response.status(Response.Status.OK.getStatusCode()).entity(result).build();
    }

    @POST
    @Path("/assign-count")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response getAssignmentCounterAlert(TokenRequest request) {
        if (!RequestValidationUtil.inputValidation(request)) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        }
        String result = null;
        try {
            result = issueService.getAssignmentCounterAlert(request);
        } catch (Exception e) {
            logger.error(e.getMessage());
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(e.getMessage()).build();
        }
        return Response.status(Response.Status.OK.getStatusCode()).entity(result).build();
    }
    
    

    @POST
    @Path("/getallissues")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response getAllIssuesEM(TokenRequest request) {
        if (!RequestValidationUtil.inputValidation(request)) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        }
        String result = null;
        try {
            result = issueService.getAllIssuesEM(request);
        } catch (Exception e) {
            logger.error(e.getMessage());
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(e.getMessage()).build();
        }
        return Response.status(Response.Status.OK.getStatusCode()).entity(result).build();
    }

    @POST
    @Path("/resolve-graphstats")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response getResolveGraphStats(TokenRequest request) {
        if (!RequestValidationUtil.inputValidation(request)) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        }
        String result = null;
        try {
            result = issueService.getResolveGraphStats(request);
        } catch (Exception e) {
            logger.error(e.getMessage());
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(e.getMessage()).build();
        }
        return Response.status(Response.Status.OK.getStatusCode()).entity(result).build();
    }

    @POST
    @Path("/category-graphstats")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response getIssueCategoryGraphStats(TokenRequest request) {
        if (!RequestValidationUtil.inputValidation(request)) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        }
        String result = null;
        try {
            result = issueService.getCategoryGraphStats(request);
        } catch (Exception e) {
            logger.error(e.getMessage());
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(e.getMessage()).build();
        }
        return Response.status(Response.Status.OK.getStatusCode()).entity(result).build();
    }

    @POST
    @Path("/getissue-byid")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response getIssueById(UserIssueRequest request) {
        if (!RequestValidationUtil.inputValidation(request)) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        }
        String result = null;
        try {
            result = issueService.getIssueById(request);
        } catch (Exception e) {
            logger.error(e.getMessage());
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(e.getMessage()).build();
        }
        return Response.status(Response.Status.OK.getStatusCode()).entity(result).build();
    }

    @POST
    @Path("/allusers")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response getAllUsersByIssueId(TokenRequest request) {
        if (!RequestValidationUtil.inputValidation(request)) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        }
        String result = null;
        try {
            result = issueService.getAllUsers(request);
        } catch (Exception e) {
            logger.error(e.getMessage());
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(e.getMessage()).build();
        }
        return Response.status(Response.Status.OK.getStatusCode()).entity(result).build();
    }

    @POST
    @Path("/allusers-byid")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response getAllUsersByIssueId(UserIssueRequest request) {
        if (!RequestValidationUtil.inputValidation(request)) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        }
        String result = null;
        try {
            result = issueService.getAllUsersByIssueId(request);
        } catch (Exception e) {
            logger.error(e.getMessage());
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(e.getMessage()).build();
        }
        return Response.status(Response.Status.OK.getStatusCode()).entity(result).build();
    }

    @POST
    @Path("/resolve")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response resolveIssue(IssueDescriptionRequest request) {
        if (!RequestValidationUtil.inputValidation(request)) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        }
        String result = null;
        try {
            result = issueService.resolveIssue(request);
        } catch (Exception e) {
            logger.error(e.getMessage());
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(e.getMessage()).build();
        }
        return Response.status(Response.Status.OK.getStatusCode()).entity(result).build();
    }

    @POST
    @Path("/untracked-notifications")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response getUnTrackedNotifications(TokenRequest request) {
        if (!RequestValidationUtil.inputValidation(request)) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        }
        String result = null;
        try {
            result = issueService.getUnTrackedNotifications(request);
        } catch (Exception e) {
            logger.error(e.getMessage());
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(e.getMessage()).build();
        }
        return Response.status(Response.Status.OK.getStatusCode()).entity(result).build();
    }

    @POST
    @Path("/mark-notification")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response markIssueNotificationsAsWatched(IssueNotificationRequest request) {
        if (!RequestValidationUtil.inputValidation(request)) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        }
        String result = null;
        try {
            result = issueService.markIssueNotificationAsWatched(request);
        } catch (Exception e) {
            logger.error(e.getMessage());
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(e.getMessage()).build();
        }
        return Response.status(Response.Status.OK.getStatusCode()).entity(result).build();
    }

    @POST
    @Path("/polling-stations")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response getStations(TokenRequest request) {
        if (!RequestValidationUtil.inputValidation(request)) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        }
        String result = null;
        try {
            result = issueService.getPollingStations(request);
        } catch (Exception e) {
            logger.error(e.getMessage());
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(e.getMessage()).build();
        }
        return Response.status(Response.Status.OK.getStatusCode()).entity(result).build();
    }

    @POST
    @Path("/count-graphstats")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response getIssueCountGraphStats(TokenRequest request) {
        if (!RequestValidationUtil.inputValidation(request)) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        }
        String result = null;
        try {
            result = issueService.getIssueCountGraphStats(request);
        } catch (Exception e) {
            logger.error(e.getMessage());
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(e.getMessage()).build();
        }
        return Response.status(Response.Status.OK.getStatusCode()).entity(result).build();
    }

    @POST
    @Path("/filterbyhierarchy")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response filterByHierarchy(SimpleRequest request) throws UnauthorizedException, MDLServerException {
        if (!RequestValidationUtil.inputValidationToken(request) || !RequestValidationUtil.inputValidation(request.hierarchyId)) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        } else {
            try {
                Gson gson=new Gson();
                ArrayList<IssueDtoEntry> resultObj =issueService.getFilterResults(request.token,request.hierarchyId);
                if(logger.isDebugEnabled()){
                logger.debug("Fitered result :"+resultObj+"for token :"+request.token+"hierarchyId :"+request.hierarchyId);
                }
                return Response.ok(gson.toJson(resultObj)).build();

            } catch (Exception ex) {
                logger.error(ex.getMessage());
                return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).build();
            }
        }
    }

    @POST
    @Path("/getisseresolvers")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response getIssueResolvers(SimpleRequest request) throws UnauthorizedException, MDLServerException {
        if (!RequestValidationUtil.inputValidationToken(request) || !RequestValidationUtil.inputValidation(request.issueId)) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        } else {
            try {
                Gson gson=new Gson();
                List<UserDto> result = issueService.processIssueResolvers(request.token,request.issueId);
                return Response.ok(gson.toJson(result)).build();

            } catch (Exception ex) {
                logger.error(ex.getMessage());
                return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).build();
            }
        }
    }

    @POST
    @Path("/sendemail")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response SendEmail(SimpleRequest request) throws UnauthorizedException, MDLServerException {
        if (!RequestValidationUtil.inputValidationToken(request) || !RequestValidationUtil.stringsValidate(request.emailTo,request.emailSubject,request.emailBody)) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        } else {
            try {
                GoogleMail.Send(request.emailTo, request.emailSubject, request.emailBody);
                JSONObject responseobj = new JSONObject();
                responseobj.put("response", "success");
                return Response.ok(responseobj.toString()).build();

            } catch (Exception ex) {
                logger.error(ex.getMessage());
                return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).build();
            }
        }
    }
}
