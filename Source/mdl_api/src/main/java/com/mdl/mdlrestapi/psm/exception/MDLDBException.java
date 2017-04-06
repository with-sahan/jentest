package com.mdl.mdlrestapi.psm.exception;

/**
 * Created with IntelliJ IDEA.
 * User: AnushaP
 * Date: 2/20/17
 * Time: 5:14 PM
 * To change this template use File | Settings | File Templates.
 */
public class MDLDBException extends Exception {
    public MDLDBException(String message) {
        super(message);
    }

    public MDLDBException(Throwable cause) {
        super(cause);
    }

    public MDLDBException(String message, Throwable cause) {
        super(message, cause);
    }

}
