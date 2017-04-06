package com.mdl.mdlrestapi.psm.service.impl;

import com.mdl.mdlrestapi.psm.dao.CommonDao;
import com.mdl.mdlrestapi.psm.dao.impl.CommonDaoImpl;
import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.psm.exception.MDLServiceException;
import com.mdl.mdlrestapi.psm.service.OrganizationService;
import com.mdl.mdlrestapi.psm.utils.SQLUtil;

public class OrganizationServiceImpl implements OrganizationService {

    @Override
    public String getOrganizationInformation(String token) throws MDLServiceException, MDLDBException {
        CommonDao openStationDao = new CommonDaoImpl();
        Object[] st = new Object[1];
        st[0] = token;
        return openStationDao.getResultStringObject(SQLUtil.GET_ORGANIZATION_INFO, st);
    }
}
