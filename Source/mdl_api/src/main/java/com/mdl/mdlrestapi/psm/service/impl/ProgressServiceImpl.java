package com.mdl.mdlrestapi.psm.service.impl;

import java.sql.SQLException;

import com.mdl.mdlrestapi.psm.dao.ProgressDao;
import com.mdl.mdlrestapi.psm.dao.impl.ProgressDaoImpl;
import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.psm.service.ProgressService;
import com.mdl.mdlrestapi.util.models.UpdateRecordProgressWrapper;

/**
 * Created by lasantha on 3/13/2017.
 */
public class ProgressServiceImpl implements ProgressService {
	
	private ProgressDao progressDao = new ProgressDaoImpl();
    
    public boolean performUpdateProgress(UpdateRecordProgressWrapper request)
            throws MDLDBException{
    	try {
			return  progressDao.performUpdateProgress(request);
		} catch (SQLException e) {
			throw new MDLDBException(e.getMessage());
		}
    }
}
