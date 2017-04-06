package com.mdl.mdlrestapi.util.exception;

/**
 * @author Methmal
 * Custom Exception to be thrown for generic exception handling
 *         see
 *         {@link com.mdl.mdlrestapi.util.exception.MDLExceptionMapper#toResponse(Throwable exception)}
 *         to see Exception to HTTP response message
 */
public class MDLServerException extends Exception {

	public MDLServerException(Throwable cause) {
		super(cause);
	}

	private static final long serialVersionUID = 1L;

}