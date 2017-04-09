package com.mdl.mdlrestapi.psm.dao;


import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.psm.resource.dto.ElectionResponse;
import com.mdl.mdlrestapi.psm.resource.dto.GetStatsRequest;
import com.mdl.mdlrestapi.psm.resource.dto.GetStatsResponse;
import com.mdl.mdlrestapi.psm.resource.dto.TokenRequest;
import com.mdl.mdlrestapi.util.models.UpdatePrePollingActivityRequest;


import java.util.ArrayList;
import java.util.List;

/**
 * Created by Thara on 3/7/2017.
 */
public interface PSMDashBoardDao {
    /**
     *
     * @param request
     * @return
     * @throws MDLDBException
     */
    public GetStatsResponse getStats(GetStatsRequest request) throws MDLDBException;

    /**
     *
     * @param request
     * @return
     * @throws MDLDBException
     */
    public ArrayList<ElectionResponse> getElectionList(TokenRequest request) throws MDLDBException;

    /**
     *
     * @param updateList
     * @return
     * @throws MDLDBException
     */
    public String updatePrePollingActivity(List<UpdatePrePollingActivityRequest> updateList) throws MDLDBException;
}