package com.mdl.mdlrestapi.psm.resource;

import com.mdl.mdlrestapi.psm.exception.MDLServiceException;
import com.mdl.mdlrestapi.psm.service.FileUploadService;
import com.mdl.mdlrestapi.psm.service.impl.FileUploadServiceImpl;
import com.mdl.mdlrestapi.psm.utils.ConfigUtil;
import com.mdl.mdlrestapi.psm.utils.SecurityUtility;
import org.apache.commons.io.FilenameUtils;
import org.apache.log4j.Logger;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.HttpHeaders;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.io.File;

/**
 * Created by lasantha on 3/10/2017.
 */

@Path("/data")
public class DownloadResource {

    private static final Logger logger = Logger.getLogger(DownloadResource.class);
    FileUploadService fileUploadService = new FileUploadServiceImpl();

    @GET
    @Path("/media/{param}")
    @Produces(MediaType.APPLICATION_OCTET_STREAM)
    public Response getMsg(@PathParam("param") String filename, @Context HttpHeaders headers)  {
        try {
            SecurityUtility.getUsernameAndOrganization(headers);
        } catch (MDLServiceException e) {
            return Response.status(Response.Status.UNAUTHORIZED.getStatusCode()).build();
        }
        
        Response.ResponseBuilder response = null;
        File file;
        try {
        	file = new File(ConfigUtil.DOWNLOAD_FILE_PATH + filename);
            response = Response.ok(file);
            response.header("Content-Disposition", "attachment; filename="+filename);
        } catch (Exception e) {
            logger.error(e.getMessage());
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).build();
        }

        return response.build();
    }
}
