package com.mdl.mdlrestapi.psm.service.impl;

import com.mdl.mdlrestapi.psm.dao.CommonDao;
import com.mdl.mdlrestapi.psm.dao.PSICheckListDao;
import com.mdl.mdlrestapi.psm.dao.impl.CommonDaoImpl;
import com.mdl.mdlrestapi.psm.dao.impl.PSICheckListDaoImpl;
import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.psm.resource.dto.ChatIssueRequest;
import com.mdl.mdlrestapi.psm.resource.dto.PsiCheckListRequest;
import com.mdl.mdlrestapi.psm.resource.dto.TokenRequest;
import com.mdl.mdlrestapi.psm.service.PsiCheckListService;
import com.mdl.mdlrestapi.psm.utils.SQLUtil;
import com.mdl.mdlrestapi.util.models.CheckListUpdateDto;
import com.mdl.mdlrestapi.util.models.GraphBallotStatsDto;

import java.util.ArrayList;

/**
 * Created by lasantha on 3/2/2017.
 */
public class PsiCheckListServiceImpl implements PsiCheckListService {
    CommonDao commonDao = new CommonDaoImpl();
    PSICheckListDao psiCheckListDao = new PSICheckListDaoImpl();
    /**
     * Get Places List
     *
     * @param request
     * @return
     * @throws com.mdl.mdlrestapi.psm.exception.MDLDBException
     *
     */
    @Override
    public String getPlacesList(TokenRequest request) throws MDLDBException {
        Object [] params = new Object[1];
        params[0] =  request.getToken();
        return commonDao.getResultStringArray(SQLUtil.GET_PLACES_LIST, params);
    }

    /**
     * Get Psi Check List
     *
     * @param request
     * @return
     * @throws com.mdl.mdlrestapi.psm.exception.MDLDBException
     *
     */
    @Override
    public String getPsiCheckList(PsiCheckListRequest request) throws MDLDBException {
        Object [] params = new Object[2];
        params[0] =  request.getToken();
        params[1] =  request.getPlace_id();
        return commonDao.getResultStringArray(SQLUtil.GET_PSI_CHECK_LIST, params);
    }

    /**
     * Get Psi Check List Categories
     *
     * @param request
     * @return
     * @throws com.mdl.mdlrestapi.psm.exception.MDLDBException
     *
     */
    @Override
    public String getPsiCheckListCategories(PsiCheckListRequest request) throws MDLDBException {
        Object [] params = new Object[2];
        params[0] =  request.getToken();
        params[1] =  request.getPlace_id();
        return commonDao.getResultStringArray(SQLUtil.GET_UNIQUE_PSI_CHECK_LIST_CATEGORIES, params);
    }

    /**
     * Get Election List
     *
     * @param request
     * @return
     * @throws Exception
     */
    @Override
    public String getElectionList(CheckListUpdateDto request) throws Exception {
        String status = "failed";
        boolean allUpdated = psiCheckListDao.performUpdateCheckList(request.token, request.checkListUpdateData);  //To change body of implemented methods use File | Settings | File Templates.
        if(allUpdated){
            status = "success";
        }
        return status;
    }

}
