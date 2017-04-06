package com.mdl.mdlrestapi.psm.dao;

import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.util.models.CheckListUpdateEntry;

import java.util.List;

/**
 * Created by lasantha on 3/7/2017.
 */
public interface PSICheckListDao {
    /**
     *
     * @param token
     * @param dataList
     * @return
     * @throws MDLDBException
     */
    public boolean performUpdateCheckList(String token, List<CheckListUpdateEntry> dataList) throws MDLDBException;
}
