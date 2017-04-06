package com.mdl.mdlrestapi.psm.dao;

import java.sql.SQLException;

import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.util.models.RecordProgressDto;
import com.mdl.mdlrestapi.util.models.UpdateRecordProgressWrapper;

/**
 * Created by lasantha on 3/13/2017.
 */
public interface ProgressDao {


    /**
     * @param request
     * @return
     * @throws MDLDBException
     * @throws SQLException
     */
    public boolean performUpdateProgress(UpdateRecordProgressWrapper request)
            throws MDLDBException, SQLException;
}
