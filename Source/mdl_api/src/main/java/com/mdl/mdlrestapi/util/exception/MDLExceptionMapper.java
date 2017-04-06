package com.mdl.mdlrestapi.util.exception;

import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.ResponseBuilder;
import javax.ws.rs.core.Response.Status;
import javax.ws.rs.ext.ExceptionMapper;
import javax.ws.rs.ext.Provider;

/**
 * @author Methmal
 *
 *This class will be map Application exceptions in to HTTP responces
 */
@Provider
public class MDLExceptionMapper implements ExceptionMapper<Throwable> {

	@Override
	public Response toResponse(Throwable exception) {

		Status status= Status.INTERNAL_SERVER_ERROR;
		if(exception instanceof MDLServerException){
			status= Status.INTERNAL_SERVER_ERROR;
		}
		else if(exception instanceof UnauthorizedException){
			status = Status.UNAUTHORIZED;
		}

		ResponseBuilder builder = Response.status(status);
		return builder.build();
	}

}
