package com.mdl.mdlrestapi.psm.service.impl;

import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.psm.resource.dto.*;
import com.mdl.mdlrestapi.psm.service.RoleService;
import com.mdl.mdlrestapi.psm.utils.SQLUtil;
import com.mdl.mdlrestapi.psm.dao.CommonDao;
import com.mdl.mdlrestapi.psm.dao.impl.CommonDaoImpl;

/**
 * Created by Thara on 3/2/2017.
 */
public class RoleServiceImpl implements RoleService {
    CommonDao commonDao = new CommonDaoImpl();

    @Override
    public String addRole(AddRoleRequest request) throws MDLDBException {
        Object [] params = new Object[3];
        params[0] =  request.getToken();
        params[1] =  request.getRolename();
        params[2] =  request.getDescription();
        return commonDao.getResultStringObject(SQLUtil.ADD_ROLE, params);
    }

    @Override
    public String getAllRoles(TokenRequest request) throws MDLDBException {
        Object [] params = new Object[1];
        params[0] =  request.getToken();
        return commonDao.getResultStringArray(SQLUtil.GET_ALL_ROLES, params);
    }

    @Override
    public String updateRole(UpdateRoleRequest request) throws MDLDBException {
        Object [] params = new Object[4];
        params[0] =  request.getToken();
        params[1] =  request.getRoleid();
        params[2] =  request.getRolename();
        params[3] =  request.getDescription();
        return commonDao.getResultStringObject(SQLUtil.UPDATE_ROLE, params);
    }

    @Override
    public String getRoleById(GetRoleByIdRequest request) throws MDLDBException {
        Object [] params = new Object[2];
        params[0] =  request.getToken();
        params[1] =  request.getRoleid();
        return commonDao.getResultStringObject(SQLUtil.GET_ROLE_BY_ID, params);
    }

    @Override
    public String deleteRole(DeleteRoleRequest request) throws MDLDBException {
        Object [] params = new Object[3];
        params[0] =  request.getToken();
        params[1] =  request.getOldroleid();
        params[2] =  request.getNewroleid();
        return commonDao.getResultStringObject(SQLUtil.DELETE_ROLE, params);
    }
}
