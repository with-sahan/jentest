package com.mdl.mdlrestapi.psm.exception;

/**
 * Created with IntelliJ IDEA.
 * User: AnushaP
 * Date: 2/20/17
 * Time: 5:25 PM
 * To change this template use File | Settings | File Templates.
 */
public class MDLServiceException extends Exception {
    public MDLServiceException(String message) {
        super(message);
    }
    public MDLServiceException(Throwable cause) {
        super(cause);
    }

    public MDLServiceException(String message, Throwable cause) {
        super(message, cause);
    }
}
