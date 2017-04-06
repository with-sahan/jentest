package com.mdl.mdlrestapi.psm.dao;

import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.util.SimpleRequest;
import com.mdl.mdlrestapi.util.models.ActivationDayRequest;
import org.json.JSONObject;

/**
 * Created by lasantha on 3/13/2017.
 */
public interface ElectionDao  {

    /**
     * @param request
     * @return
     * @throws MDLDBException
     */
    public JSONObject resetTenantData(SimpleRequest request) throws MDLDBException;

    /**
     * @param request
     * @return
     * @throws MDLDBException
     */
    public JSONObject updateActivatedDay(ActivationDayRequest request) throws MDLDBException;

    /**
     * @param request
     * @return
     * @throws MDLDBException
     */
    public JSONObject getActivatedDay(SimpleRequest request) throws MDLDBException;


}
