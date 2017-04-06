package com.mdl.mdlrestapi.util.exception;

/**
 * @author Methmal
 *  Custom Exception to be thrown for  unauthorized access handling
 *         see
 *         {@link com.mdl.mdlrestapi.util.exception.MDLExceptionMapper#toResponse(Throwable exception)}
 *         to see Exception to HTTP response message
 *
 */
public class UnauthorizedException extends Exception  {

	private static final long serialVersionUID = 1L;

	public UnauthorizedException(Throwable cause) {
		super(cause);
	}


}
