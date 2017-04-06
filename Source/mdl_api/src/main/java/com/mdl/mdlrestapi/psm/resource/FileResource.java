package com.mdl.mdlrestapi.psm.resource;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import com.mdl.mdlrestapi.psm.resource.dto.FileReportRequest;
import com.mdl.mdlrestapi.psm.service.FileService;
import com.mdl.mdlrestapi.psm.service.impl.FileServiceImpl;
import com.mdl.mdlrestapi.psm.utils.RequestValidationUtil;
import org.apache.log4j.Logger;

/**
 * @Author	: Rushan
 * @Date	: Mar 2, 2017
 * @TIme	: 12:14:10 PM
 */
@Path("/allfiles")
public class FileResource {
	private static final Logger logger = Logger.getLogger(FileResource.class);
	FileService fileService = new FileServiceImpl();

	@POST
	@Path("/getfilereport")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	public Response getFileReport(FileReportRequest request){

		if (!RequestValidationUtil.inputValidation(request)) {
			return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
		}
		try {
			return Response.status(Response.Status.OK).entity(fileService.getFileReport(request)).build();
		} catch (Exception e) {
			logger.error(e.getMessage());
			return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(e.getMessage()).build();
		}
	}


}
