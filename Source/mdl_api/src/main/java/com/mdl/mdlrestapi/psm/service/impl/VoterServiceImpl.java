package com.mdl.mdlrestapi.psm.service.impl;

import com.mdl.mdlrestapi.psm.dao.CommonDao;
import com.mdl.mdlrestapi.psm.dao.impl.CommonDaoImpl;
import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.psm.resource.dto.TokenRequest;
import com.mdl.mdlrestapi.psm.resource.dto.VoterDeleteRequest;
import com.mdl.mdlrestapi.psm.resource.dto.VoterInfoRequest;
import com.mdl.mdlrestapi.psm.service.VoterService;
import com.mdl.mdlrestapi.psm.utils.SQLUtil;

/**
 * Created with IntelliJ IDEA.
 * User: AnushaP
 * Date: 2/24/17
 * Time: 10:46 PM
 * To change this template use File | Settings | File Templates.
 */
public class VoterServiceImpl implements VoterService {
    CommonDao commonDao = new CommonDaoImpl();

    /**
     * Get Voters list
     *
     * @param request
     * @return
     * @throws com.mdl.mdlrestapi.psm.exception.MDLDBException
     *
     */
    @Override
    public String getVotersList(TokenRequest request) throws MDLDBException {
        Object[] params = new Object[1];
        params[0] = request.getToken();
        return commonDao.getResultStringArray(SQLUtil.GET_VOTER_LIST, params);
    }

    /**
     * Save Voter
     *
     * @param request
     * @return
     * @throws com.mdl.mdlrestapi.psm.exception.MDLDBException
     *
     */
    @Override
    public String saveVoter(VoterInfoRequest request) throws MDLDBException {
        Object[] params = new Object[6];
        params[0] = request.getToken();
        params[1] = request.getPolling_station_id();
        params[2] = request.getVoter_name();
        params[3] = request.getPhone_number();
        params[4] = request.getCompanion_name();
        params[5] = request.getCompanion_address();
        return commonDao.getResultStringArray(SQLUtil.ADD_VOTER, params);
    }

    /**
     * Voter Delete
     *
     * @param request
     * @return
     * @throws com.mdl.mdlrestapi.psm.exception.MDLDBException
     *
     */
    @Override
    public String deleteVoter(VoterDeleteRequest request) throws MDLDBException {
        Object[] params = new Object[2];
        params[0] = request.getToken();
        params[1] = request.getVoter_list_id();
        return commonDao.getResultStringArray(SQLUtil.DELETE_VOTER, params);
    }
}
