package com.mdl.mdlrestapi.psm.service;

import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.psm.resource.dto.PsiCheckListRequest;
import com.mdl.mdlrestapi.psm.resource.dto.TokenRequest;
import com.mdl.mdlrestapi.util.models.CheckListUpdateDto;
import com.mdl.mdlrestapi.util.models.GraphBallotStatsDto;

import java.util.ArrayList;

/**
 * Created by lasantha on 3/2/2017.
 */
public interface PsiCheckListService {
    /**
     * get Places List
     * @param request
     * @return
     * @throws MDLDBException
     */
    public String getPlacesList(TokenRequest request) throws MDLDBException;

    /**
     * get Places List
     * @param request
     * @return
     * @throws MDLDBException
     */
    public String getPsiCheckList(PsiCheckListRequest request) throws MDLDBException;

    /**
     * get Places List
     * @param request
     * @return
     * @throws MDLDBException
     */
    public String getPsiCheckListCategories(PsiCheckListRequest request) throws MDLDBException;

    public String getElectionList(CheckListUpdateDto request) throws Exception;
}
