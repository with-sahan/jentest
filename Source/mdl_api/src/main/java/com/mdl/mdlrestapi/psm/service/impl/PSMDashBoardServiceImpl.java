package com.mdl.mdlrestapi.psm.service.impl;

import com.mdl.mdlrestapi.psm.dao.PSMDashBoardDao;
import com.mdl.mdlrestapi.psm.dao.impl.PSMDashBoardDaoImlp;
import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.psm.resource.dto.ElectionResponse;
import com.mdl.mdlrestapi.psm.resource.dto.GetStatsRequest;
import com.mdl.mdlrestapi.psm.resource.dto.GetStatsResponse;
import com.mdl.mdlrestapi.psm.resource.dto.TokenRequest;
import com.mdl.mdlrestapi.psm.service.PSMDashBoardService;
import com.mdl.mdlrestapi.util.models.UpdatePrePollingActivityRequest;


import java.util.ArrayList;
import java.util.List;

import org.json.JSONObject;

/**
 * Created by Thara on 3/7/2017.
 */
public class PSMDashBoardServiceImpl implements PSMDashBoardService{
    PSMDashBoardDao psmDashBoardDao=new PSMDashBoardDaoImlp();

    @Override
    public GetStatsResponse getStats(GetStatsRequest request) throws MDLDBException{
        return psmDashBoardDao.getStats(request);


    }

    @Override
    public ArrayList<ElectionResponse> getElectionList(TokenRequest request) throws MDLDBException {
        return psmDashBoardDao.getElectionList(request);

    }

    @Override
    public String updatePrePollingActivity(List<UpdatePrePollingActivityRequest> updateList) throws MDLDBException {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("response", psmDashBoardDao.updatePrePollingActivity(updateList));
    	
    	return jsonObject.toString();
    }
}
