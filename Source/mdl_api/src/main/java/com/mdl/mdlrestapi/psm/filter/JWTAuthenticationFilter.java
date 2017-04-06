package com.mdl.mdlrestapi.psm.filter;

import javax.ws.rs.WebApplicationException;
import javax.ws.rs.core.HttpHeaders;
import javax.ws.rs.core.Response;
import java.io.*;
import java.net.URI;
import java.util.List;
import java.util.Map;
import com.sun.jersey.spi.container.ContainerRequest;
import com.sun.jersey.spi.container.ContainerRequestFilter;
import org.apache.commons.io.IOUtils;
import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONObject;
import org.json.JSONTokener;

import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.psm.service.UserService;
import com.mdl.mdlrestapi.psm.service.impl.UserServiceImpl;
import com.mdl.mdlrestapi.psm.utils.SecurityUtility;
import com.mdl.mdlrestapi.psm.utils.JWTClaims;
import com.mdl.mdlrestapi.psm.exception.MDLServiceException;
import com.mdl.mdlrestapi.psm.service.LoginService;
import com.mdl.mdlrestapi.psm.service.impl.LoginServiceImpl;
import com.mdl.mdlrestapi.psm.utils.ErrorCodes;

/**
 * Created with IntelliJ IDEA.
 * User: AnushaP
 * Date: 2/16/17
 * Time: 11:00 PM
 * To change this template use File | Settings | File Templates.
 */

public class JWTAuthenticationFilter implements ContainerRequestFilter {
    private static final Logger logger = Logger.getLogger(JWTAuthenticationFilter.class);
    private static final String LOGIN_URL = "mdlapi/login";
    private static final String USER_TOKEN = "token";
    private static final String APPLICATION_JSON = "application/json";
    LoginService loginService = new LoginServiceImpl();
    UserService userService  = new UserServiceImpl();

    private JWTClaims doAuthentication(List<String> tokenList) throws MDLServiceException {

        if (tokenList == null || tokenList.isEmpty()) {
            throw new MDLServiceException(ErrorCodes.JWT_VALIDATION_FAIL);
        }
        JWTClaims jwtClaims = null;
        if (!tokenList.isEmpty()) {
            String token = tokenList.get(0);
            if (!token.contains("Bearer") || token.split(" ").length != 2) {
                throw new MDLServiceException(ErrorCodes.JWT_VALIDATION_FAIL);
            } else {
                try {
                    jwtClaims = SecurityUtility.validateJWTAndGetClaims(token.split(" ")[1].trim());
                } catch (MDLServiceException e) {
                    logger.error("Error Occurred :" +e.getMessage() );
                    throw new MDLServiceException(ErrorCodes.JWT_VALIDATION_FAIL);
                }
                try {
                    if (!loginService.validateJWTTokenWithDB(token, jwtClaims)) {
                        throw new MDLServiceException(ErrorCodes.JWT_VALIDATION_FAIL);
                    }
                } catch (Exception e) {
                    throw new MDLServiceException(ErrorCodes.JWT_VALIDATION_FAIL);
                }
            }
        }
        return jwtClaims;
    }

    @Override
    public ContainerRequest filter(ContainerRequest request) {
        URI uri = request.getRequestUri();
        String url = uri.getPath();

        // Allow preflifght check for CORS
        if (request.getMethod().equals("OPTIONS")) {
            return request;
        }

        if (!url.contains(LOGIN_URL)) {
            List<String> authHeader = request.getRequestHeader(HttpHeaders.AUTHORIZATION);
            if (authHeader != null) {
                try {
                    JWTClaims jwtClaims = doAuthentication(authHeader);
                    if(!doAuthorization(jwtClaims.getRoleId(), url)){
                        logger.error("No permission to access the service" + url);
                        throw new WebApplicationException(Response.status(Response.Status.FORBIDDEN).entity(Response.Status.FORBIDDEN.name()).build());
                    }
                    List<String> contentTypeHeader = (request.getRequestHeader(HttpHeaders.CONTENT_TYPE)) ;
                    if(contentTypeHeader != null && contentTypeHeader.get(0).equalsIgnoreCase(APPLICATION_JSON)){
                    setUserToken(request, jwtClaims);
                    }
                } catch (MDLServiceException e) {
                    logger.error("Error Occurred: "+e.getMessage());
                    throw new WebApplicationException(Response.status(Response.Status.UNAUTHORIZED.getStatusCode()).entity(Response.Status.UNAUTHORIZED.name()).build());
                }
            } else {
                logger.error("Error Occurred: "+Response.Status.UNAUTHORIZED.name());
                throw new WebApplicationException(Response.status(Response.Status.UNAUTHORIZED.getStatusCode()).entity(Response.Status.UNAUTHORIZED.name()).build());
            }
        }

        return request;
    }

    private boolean doAuthorization(int roleId, String path) throws MDLServiceException {
        try {
            path = extractRequestPath(path);
            if(!path.isEmpty()) {
                Map<Integer, String> permMap = userService.getPermissions(roleId);
                return permMap.containsValue(path);
            }
            return false;
        } catch (MDLDBException e) {
           throw new MDLServiceException(e.getMessage());
        }
    }

    private void setUserToken(ContainerRequest request, JWTClaims jwtClaims) throws MDLServiceException {
        String requestBody = null;
        try {
            requestBody = IOUtils.toString(request.getEntityInputStream());

            Object json = new JSONTokener(requestBody).nextValue();
            if(json instanceof JSONObject){
            	JSONObject jsonBody = new JSONObject(requestBody);
            	if (jsonBody.has(USER_TOKEN)) {
            		jsonBody.remove(USER_TOKEN);
            	}
            	jsonBody.put(USER_TOKEN, jwtClaims.getName() + "|" + jwtClaims.getOrganization()  + "|");
            	InputStream in = IOUtils.toInputStream(jsonBody.toString());
            	request.setEntityInputStream(in);
            	
            }else if(json instanceof JSONArray){
            	
            	
            	JSONArray jsonArray = new JSONArray(requestBody);
            	JSONArray requestArray = new JSONArray();
            	
            	for (int i=0 ; i<jsonArray.length() ; i++){
            		JSONObject jsonBody = jsonArray.getJSONObject(i);
                	if (jsonBody.has(USER_TOKEN)) {
                		jsonBody.remove(USER_TOKEN);
                	}
                	jsonBody.put(USER_TOKEN, jwtClaims.getName() + "|" + jwtClaims.getOrganization()  + "|");
                	requestArray.put(jsonBody);
            	}
            	
            	InputStream in = IOUtils.toInputStream(requestArray.toString());
            	request.setEntityInputStream(in);
            	
            }
        } catch (IOException e) {
            logger.error("Error occurred : "+e.getMessage());
            throw new MDLServiceException(e.getMessage());
        }

    }
    public String extractRequestPath(String path){
        String mainPath = "";
        path = path.replaceFirst("\\/mdl_api\\/", "");
        String [] subPaths = path.split("/");
        if(subPaths.length >= 3) {
            for (int x = 1; x < 3; x++) {
                mainPath = mainPath + "/" + subPaths[x];
            }
        }
        else{
            if(subPaths.length > 1) {
                for (int x = 1; x < subPaths.length; x++) {
                    mainPath = mainPath + "/" + subPaths[x];
                }
            }
        }
        return mainPath;
    }
}
