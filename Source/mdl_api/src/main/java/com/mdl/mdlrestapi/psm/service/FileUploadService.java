package com.mdl.mdlrestapi.psm.service;

import com.mdl.mdlrestapi.psm.exception.MDLServiceException;

/**
 * Created by Anuja on 2017-03-06.
 */
public interface FileUploadService {
    public String getFileString(String filename) throws MDLServiceException;
}
