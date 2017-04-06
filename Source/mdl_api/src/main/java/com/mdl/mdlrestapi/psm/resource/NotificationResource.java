package com.mdl.mdlrestapi.psm.resource;

import com.google.gson.Gson;
import com.mdl.mdlrestapi.psm.exception.MDLServiceException;
import com.mdl.mdlrestapi.psm.resource.dto.NotificationRequest;
import com.mdl.mdlrestapi.psm.resource.dto.StationRequest;
import com.mdl.mdlrestapi.psm.resource.dto.TokenRequest;
import com.mdl.mdlrestapi.psm.service.NotificationService;
import com.mdl.mdlrestapi.psm.service.impl.NotificationServiceImpl;
import com.mdl.mdlrestapi.psm.utils.ConfigUtil;
import com.mdl.mdlrestapi.psm.utils.RequestValidationUtil;
import com.mdl.mdlrestapi.psm.utils.SecurityUtility;
import com.mdl.mdlrestapi.util.ErrorCodes;
import com.mdl.mdlrestapi.util.SimpleRequest;
import com.mdl.mdlrestapi.util.TokenValidation;
import com.mdl.mdlrestapi.util.exception.MDLServerException;
import com.mdl.mdlrestapi.util.exception.UnauthorizedException;
import com.mdl.mdlrestapi.util.models.CloseStatsDto;
import com.mdl.mdlrestapi.util.models.NotificationDto;
import com.mdl.mdlrestapi.util.models.NotificationResultDto;
import com.mdl.mdlrestapi.util.models.PollingStationDto;
import com.sun.jersey.core.header.FormDataContentDisposition;
import com.sun.jersey.multipart.FormDataParam;
import org.apache.log4j.Logger;
import org.json.JSONObject;

import javax.ws.rs.*;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.HttpHeaders;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.io.InputStream;
import java.util.ArrayList;

/**
 * Created with IntelliJ IDEA.
 * User: AnushaP
 * Date: 2/24/17
 * Time: 2:30 PM
 * To change this template use File | Settings | File Templates.
 */
@Path("/notification")
public class NotificationResource {

    private static final Logger logger = Logger.getLogger(NotificationResource.class);
    NotificationService notificationService = new NotificationServiceImpl();

    @POST
    @Path("/pulse")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response getNotificationPulse(TokenRequest request) {
        if (!RequestValidationUtil.inputValidation(request)) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        }
        String result = null;
        try {
            result = notificationService.getNotificationPulse(request.getToken());
        } catch (Exception e) {
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(e.getMessage()).build();
        }
        return Response.status(Response.Status.OK.getStatusCode()).entity(result).build();
    }

    @POST
    @Path("/top")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response getNotificationTop(TokenRequest request) {
        if (!RequestValidationUtil.inputValidation(request)) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        }
        String result = null;
        try {
            result = notificationService.getNotificationTop(request.getToken());
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
    public Response getNotificationAll(TokenRequest request) {
        if (!RequestValidationUtil.inputValidation(request)) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        }
        String result = null;
        try {
            result = notificationService.getNotificationAll(request.getToken());
        } catch (Exception e) {
            logger.error(e.getMessage());
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(e.getMessage()).build();
        }
        return Response.status(Response.Status.OK.getStatusCode()).entity(result).build();
    }

    @POST
    @Path("/read")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response getNotificationRead(NotificationRequest request) {
        if (!RequestValidationUtil.inputValidation(request)) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        }
        String result = null;
        try {
            result = notificationService.getNotificationRead(request.getToken(),request.getNotification_id() );
        } catch (Exception e) {
            logger.error(e.getMessage());
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(e.getMessage()).build();
        }
        return Response.status(Response.Status.OK.getStatusCode()).entity(result).build();
    }

    @POST
    @Path("/global")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response getGlobalNotifications(TokenRequest request) {
        if (!RequestValidationUtil.inputValidation(request)) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        }
        String result = null;
        try {
            result = notificationService.getGlobalNotifications(request.getToken());
        } catch (Exception e) {
            logger.error(e.getMessage());
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(e.getMessage()).build();
        }
        return Response.status(Response.Status.OK.getStatusCode()).entity(result).build();
    }


    @POST
    @Path("/id")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response getNotificationById(NotificationRequest request) {
        if (!RequestValidationUtil.inputValidation(request)) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        }
        String result = null;
        try {
            result = notificationService.getNotificationById(request.getToken(),request.getNotification_id() );
        } catch (Exception e) {
            logger.error(e.getMessage());
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(e.getMessage()).build();
        }
        return Response.status(Response.Status.OK.getStatusCode()).entity(result).build();
    }


    @SuppressWarnings("finally")
    @POST
    @Path("/makenotification")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.MULTIPART_FORM_DATA)
    public Response uploadFile(
            @FormDataParam("file") InputStream uploadedInputStream,
            @FormDataParam("file") FormDataContentDisposition fileDetail,
            @FormDataParam("description") String description,
            @FormDataParam("stationId") String stationId,
            @FormDataParam("hierarchyId") String hierarchyId,
            @Context HttpHeaders headers) {
        String token = "";
        try {
            token = SecurityUtility.getUsernameAndOrganization(headers);
        } catch (MDLServiceException e) {
        	return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        }
        if(logger.isDebugEnabled()){
        logger.debug("Parameters for upload file in make notifications :"+description+" "+stationId+" "+hierarchyId+" "+token);
        }
        String respStatus="";
        //token validation
        if(!TokenValidation.ValidateToken(token)){
            logger.warn("Invalid token,token:" + token);
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        }
        try{
            if(fileDetail.getFileName()!=null){
                String uploadedFileLocation = ConfigUtil.UPLOAD_FILE_PATH + fileDetail.getFileName();
                // save it
                notificationService.saveToDbNotification(uploadedFileLocation,stationId,hierarchyId,description,token);
                notificationService.writeToFile(uploadedInputStream, uploadedFileLocation);
                //			return Response.status(200).entity(output).build();
            }
            else{
                notificationService.saveToDbNotification(null,stationId,hierarchyId,description,token);
            }
        }catch(Exception ex){
            logger.error(ex);
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(ex.getMessage()).build();
        }
        JSONObject responseobj = new JSONObject();
        responseobj.put("response", respStatus);
        return Response.status(200).entity(responseobj.toString()).build();
    }

    @POST
    @Path("/getpollingstationsbyhierarchy")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response GetPollingStationsByHierarchy(SimpleRequest request) {
        if (!RequestValidationUtil.inputValidationToken(request) || !RequestValidationUtil.inputValidation(request.hierarchyId)) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        }
        try{
            ArrayList<PollingStationDto> statList = notificationService.getActivePollingStationList(request.hierarchyId, request.token);
            Gson gson=new Gson();
            return Response.ok(gson.toJson(statList)).build();
        }catch(Exception ex){
            logger.error(ex);
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(ex.getMessage()).build();
        }
    }

    @POST
    @Path("/notificationsbyhierarchy")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response GetNotificationsByHierarchy(SimpleRequest request) {
        if (!RequestValidationUtil.inputValidationToken(request) || !RequestValidationUtil.inputValidation(request.hierarchyId)) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        }
        try{
            ArrayList<NotificationDto> result= notificationService.getFilteredResults(request.hierarchyId, request.token);
            Gson gson=new Gson();
            return Response.ok(gson.toJson(result)).build();

        }catch(Exception ex){
            logger.error(ex);
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(ex.getMessage()).build();
        }
    }

}
