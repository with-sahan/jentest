package com.mdl.mdlrestapi.psm.service;

import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.util.models.RecordProgressDto;
import com.mdl.mdlrestapi.util.models.UpdateRecordProgressWrapper;

/**
 * Created by lasantha on 3/13/2017.
 */
public interface ProgressService  {
    
    /**
     * @param request
     * @return
     * @throws MDLDBException
     */
    public boolean performUpdateProgress(UpdateRecordProgressWrapper request)
            throws MDLDBException;


}
