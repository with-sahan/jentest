package com.mdl.mdlrestapi.psm.resource;

import com.google.gson.Gson;
import com.mdl.mdlrestapi.psm.resource.dto.ChatIssueResolveRequest;
import com.mdl.mdlrestapi.psm.resource.dto.PsiCheckListRequest;
import com.mdl.mdlrestapi.psm.resource.dto.TokenRequest;
import com.mdl.mdlrestapi.psm.service.PsiCheckListService;
import com.mdl.mdlrestapi.psm.service.impl.PsiCheckListServiceImpl;
import com.mdl.mdlrestapi.psm.utils.RequestValidationUtil;
import com.mdl.mdlrestapi.util.ErrorCodes;
import com.mdl.mdlrestapi.util.SimpleRequest;
import com.mdl.mdlrestapi.util.TokenValidation;
import com.mdl.mdlrestapi.util.exception.MDLServerException;
import com.mdl.mdlrestapi.util.exception.UnauthorizedException;
import com.mdl.mdlrestapi.util.models.CheckListUpdateDto;
import com.mdl.mdlrestapi.util.models.CheckListUpdateEntry;
import com.mdl.mdlrestapi.util.models.ElectionDto;
import org.apache.log4j.Logger;
import org.json.JSONObject;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.ArrayList;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Sahan
 * Date: 3/01/17
 * Time: 6:23 PM
 * To change this template use File | Settings | File Templates.
 */
@Path("/psichecklist")
public class PSICheckResource {
    private static final Logger logger = Logger.getLogger(PSICheckResource.class);
    PsiCheckListService psiCheckListService = new PsiCheckListServiceImpl();

    @POST
    @Path("/list-places")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response getNotificationAll(TokenRequest request) {
        if (!RequestValidationUtil.inputValidation(request)) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        }
        String result = null;
        try {
            result = psiCheckListService.getPlacesList(request);
        } catch (Exception e) {
            logger.error(e);
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(e.getMessage()).build();
        }
        return Response.status(Response.Status.OK.getStatusCode()).entity(result).build();
    }

    @POST
    @Path("/checklist")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response getPsiCheckList(PsiCheckListRequest request) {
        if (!RequestValidationUtil.inputValidation(request)) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        }
        String result = null;
        try {
            result = psiCheckListService.getPsiCheckList(request);
        } catch (Exception e) {
            logger.error(e);
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(e.getMessage()).build();
        }
        return Response.status(Response.Status.OK.getStatusCode()).entity(result).build();
    }

    @POST
    @Path("/checklist-category")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response getPsiCheckListCategories(PsiCheckListRequest request) {
        if (!RequestValidationUtil.inputValidation(request)) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        }
        String result = null;
        try {
            result = psiCheckListService.getPsiCheckListCategories(request);
        } catch (Exception e) {
            logger.error(e);
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(e.getMessage()).build();
        }
        return Response.status(Response.Status.OK.getStatusCode()).entity(result).build();
    }

    @POST
    @Path("/psichecklistupdate")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response updatePSICheckList(CheckListUpdateDto request) {
        if (!RequestValidationUtil.inputValidation(request)) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        } else {
            try {
                String data = psiCheckListService.getElectionList(request);
                return Response.ok(data).build();

            } catch (Exception ex) {
                logger.error(ex.getMessage());
                return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).build();
            }
        }
    }

    @POST
    @Path("/getpsichecklist")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response getPSICheckList(CheckListUpdateDto data){
        return null;
    }
}
