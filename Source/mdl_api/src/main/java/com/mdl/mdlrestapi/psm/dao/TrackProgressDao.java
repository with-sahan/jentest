package com.mdl.mdlrestapi.psm.dao;

import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.util.models.TrackingDto;
import com.mdl.mdlrestapi.util.models.TrackingResult;

import java.util.ArrayList;

/**
 * Created by lasantha on 3/8/2017.
 */
public interface TrackProgressDao {

    /**
     * @param token
     * @param hierarchyId
     * @return
     * @throws MDLDBException
     */
    public ArrayList<TrackingDto> getFilterResults(String token, int hierarchyId) throws MDLDBException;
}
