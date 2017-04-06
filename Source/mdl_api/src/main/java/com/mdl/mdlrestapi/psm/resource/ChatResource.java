package com.mdl.mdlrestapi.psm.resource;

import com.mdl.mdlrestapi.psm.exception.MDLServiceException;
import com.mdl.mdlrestapi.psm.resource.dto.TokenRequest;
import com.mdl.mdlrestapi.psm.service.ChatService;
import com.mdl.mdlrestapi.psm.service.impl.ChatServiceImpl;
import com.mdl.mdlrestapi.psm.utils.ConfigUtil;
import com.mdl.mdlrestapi.psm.utils.RequestValidationUtil;
import com.mdl.mdlrestapi.psm.utils.SecurityUtility;
import com.mdl.mdlrestapi.util.TokenValidation;
import com.mdl.mdlrestapi.util.exception.MDLServerException;
import com.mdl.mdlrestapi.util.exception.UnauthorizedException;
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

/**
 * Created with IntelliJ IDEA.
 * User: AnushaP
 * Date: 2/25/17
 * Time: 12:01 AM
 * To change this template use File | Settings | File Templates.
 */
@Path("/chat")
public class ChatResource {
    private static final Logger logger = Logger.getLogger(ChatResource.class);
    ChatService chatService = new ChatServiceImpl();

    @POST
    @Path("/counter-alert")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response getChatCounterAlert(TokenRequest request) {
        if (!RequestValidationUtil.inputValidation(request)) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        }
        String result = null;
        try {
            result = chatService.getChatCountAlert(request);
        } catch (Exception e) {
            logger.error(e.getMessage());
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(e.getMessage()).build();
        }
        return Response.status(Response.Status.OK.getStatusCode()).entity(result).build();
    }

    @POST
    @Path("/counter-alert-v1")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response getChatCounterAlertV1(TokenRequest request) {
        if (!RequestValidationUtil.inputValidation(request)) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        }
        String result = null;
        try {
            result = chatService.getChatCountAlertV1(request);
        } catch (Exception e) {
            logger.error(e.getMessage());
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(e.getMessage()).build();
        }
        return Response.status(Response.Status.OK.getStatusCode()).entity(result).build();
    }

    @SuppressWarnings("finally")
    @POST
    @Path("/createchat")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.MULTIPART_FORM_DATA)
    public Response uploadFile(@FormDataParam("file") InputStream uploadedInputStream,
                               @FormDataParam("file") FormDataContentDisposition fileDetail, @QueryParam("issueid") String issueid,
                               @QueryParam("pollingstationid") String pollingstationid, @QueryParam("chatmessage") String chatmessage,
                               @Context HttpHeaders headers) throws UnauthorizedException, MDLServerException {
        String token = "";
        try {
            token = SecurityUtility.getUsernameAndOrganization(headers);
        } catch (MDLServiceException e) {
            throw new UnauthorizedException(new Throwable("Invalid Request"));
        }
        if(logger.isDebugEnabled()){
        logger.debug("createchat request recieved,token:" + token);
        }
        String respStatus="";
        if(!TokenValidation.ValidateToken(token)){
            logger.warn("Invalid token,token:" + token);
            throw new UnauthorizedException(new Throwable("Invalid token"));
        }
        try {

            if(fileDetail.getFileName()!=null){
                String uploadedFileLocation = ConfigUtil.UPLOAD_FILE_PATH + fileDetail.getFileName();
                // save it
                int chatId = chatService.saveToDbChat(uploadedFileLocation, issueid, pollingstationid, chatmessage, token);
                if (chatId > 0) {
                    chatService.writeToFile(uploadedInputStream, uploadedFileLocation);
                    respStatus = "File uploaded to : " + uploadedFileLocation;

                    //create issue notifications
                } else {
                    throw new Exception("saved to db failed");
                }

            }else {
                int chatId = chatService.saveToDbChat(null, issueid, pollingstationid, chatmessage, token);
                if(chatId > 0){
                    ////create issue notifications
                    chatService.createIssueNotificationsForChat(token,Integer.parseInt(issueid),chatId);

                    respStatus="success";
                }else{
                    respStatus="error";
                }
            }
        } catch(Exception ex){
            logger.error(ex);
            throw new MDLServerException(ex);
        }
        JSONObject responseobj = new JSONObject();
        responseobj.put("response", respStatus);
        return Response.status(200).entity(responseobj.toString()).build();
    }
}
