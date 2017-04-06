package com.mdl.mdlrestapi.psm.resource;

import javax.ws.rs.Consumes;
import javax.ws.rs.OPTIONS;
import javax.ws.rs.POST;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.HttpHeaders;
import javax.ws.rs.core.Context;

import com.mdl.mdlrestapi.psm.utils.RequestValidationUtil;
import org.apache.log4j.Logger;
import org.json.JSONObject;
import java.util.List;

import com.mdl.mdlrestapi.psm.exception.MDLServiceException;
import com.mdl.mdlrestapi.psm.utils.ErrorCodes;
import com.mdl.mdlrestapi.psm.service.LoginService;
import com.mdl.mdlrestapi.psm.service.impl.LoginServiceImpl;
import com.mdl.mdlrestapi.psm.resource.dto.LoginRequest;
import com.mdl.mdlrestapi.psm.resource.dto.LoginResponse;
import com.mdl.mdlrestapi.util.exception.MDLServerException;


@Path("/")
public class LoginResource {
    private static final Logger logger = Logger.getLogger(LoginResource.class);

    LoginService loginService = new LoginServiceImpl();

    @POST
    @Path("/ping")
    @Produces(MediaType.APPLICATION_JSON)
    public Response GetGroHierarchy() throws MDLServerException {
        JSONObject responseobj = new JSONObject();
        try {
            String result = "I'm alive";
            responseobj.put("response", result);
        } catch (Exception ex) {
            logger.error(ex);
            // Do No throw Exception here
        }
        return Response.status(Response.Status.OK.getStatusCode()).entity(responseobj.toString()).build();
    }

    @POST
    @Path("/login")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response LoginClass(LoginRequest request) {

        LoginResponse loginResponse = null;
        if (!RequestValidationUtil.inputValidation(request)) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).entity(Response.Status.BAD_REQUEST.name()).build();
        }
        try {
            loginResponse = loginService.processLogin(request.username, request.organization_code, request.usersecret);
        } catch (Exception e) {
            logger.error(e.getMessage());
            if (ErrorCodes.INVALID_CREDENTIALS.equals(e.getMessage())) {
                return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).entity(Response.Status.BAD_REQUEST.name()).build();
            } else {
                return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(Response.Status.INTERNAL_SERVER_ERROR.name()).build();
            }
        }
        return Response.ok(loginResponse.jsonObject.toString()).build();
    }

    @GET
    @Path("/logout")
    @Produces(MediaType.APPLICATION_JSON)
    public Response Logout(@Context HttpHeaders headers) {

        List<String> tokenList = headers.getRequestHeader("Authorization");
        if (tokenList == null || tokenList.isEmpty()) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        }
        String token = tokenList.get(0);
        if (!token.contains("Bearer") || token.split(" ").length != 2) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        }
        try {
            loginService.deleteJWTToken(token.split(" ")[1].trim());
        } catch (MDLServiceException e) {
            logger.error(e.getMessage());
            if (ErrorCodes.NO_RECORD_FOUND.equals(e.getMessage())) {
                return Response.status(Response.Status.NOT_FOUND.getStatusCode()).build();
            } else {
                return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).build();
            }
        }

        return Response.status(Response.Status.OK.getStatusCode()).build();
    }

}

