package com.mdl.mdlrestapi.psm.service.impl;

import com.mdl.mdlrestapi.psm.dao.StatisticDao;
import com.mdl.mdlrestapi.psm.dao.impl.StatisticDaoImpl;
import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.psm.service.StatisticService;
import com.mdl.mdlrestapi.util.models.CloseStatsDto;
import com.mdl.mdlrestapi.util.models.CloseStatsSummeryDto;
import com.mdl.mdlrestapi.util.models.UserDto;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by lasantha on 3/8/2017.
 */
public class StatisticServiceImpl implements StatisticService {
    StatisticDao statisticDao = new StatisticDaoImpl();

    public ArrayList<CloseStatsSummeryDto> getAllCloseStatsSummery(String token, int electionId, int hierarchyId) throws MDLDBException{
        return statisticDao.getAllCloseStatsSummery(token,electionId,hierarchyId);
    }

    public String updateAllCloseStats(String token,int electionId) throws MDLDBException {
        return statisticDao.updateAllCloseStats(token,electionId);
    }

    public ArrayList<CloseStatsDto> getAllCloseStats(String token, int electionId, int hierarchyId) throws MDLDBException{
        return statisticDao.getAllCloseStats(token,electionId,hierarchyId);
    }

    public ArrayList<CloseStatsDto> getUnexportedAllCloseStats(String token,int electionId,int hierarchyId) throws MDLDBException{
        return statisticDao.getUnexportedAllCloseStats(token,electionId,hierarchyId);
    }

}
