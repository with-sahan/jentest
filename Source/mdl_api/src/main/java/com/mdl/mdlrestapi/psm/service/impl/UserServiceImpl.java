package com.mdl.mdlrestapi.psm.service.impl;

import java.util.Map;

import com.mdl.mdlrestapi.psm.dao.CommonDao;
import com.mdl.mdlrestapi.psm.dao.UserDao;
import com.mdl.mdlrestapi.psm.dao.impl.CommonDaoImpl;
import com.mdl.mdlrestapi.psm.dao.impl.UserDaoImpl;
import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.psm.resource.dto.TokenRequest;
import com.mdl.mdlrestapi.psm.utils.SQLUtil;
import com.mdl.mdlrestapi.psm.resource.dto.*;
import com.mdl.mdlrestapi.psm.service.UserService;

/**
 * Created by Thara on 3/1/2017.
 */
public class UserServiceImpl implements UserService {
    CommonDao commonDao = new CommonDaoImpl();
    UserDao userDao = new UserDaoImpl();
    /**
     * user management
     *
     * @param request
     * @return
     * @throws MDLDBException
     *
     */
    @Override
    public String addUser(AddUserRequest request) throws MDLDBException {
        Object [] params = new Object[7];
        params[0] =  request.getToken();
        params[1] =  request.getFirstname();
        params[2] =  request.getLastname();
        params[3] =  request.getEmail();
        params[4] =  request.getUsername();
        params[5] =  request.getUserpassword();
        params[6] =  request.getLanguage_id();
        return commonDao.getResultStringObject(SQLUtil.ADD_USER, params);

    }

    @Override
    public String getAllUsers(TokenRequest request) throws MDLDBException {
        Object [] params = new Object[1];
        params[0] =  request.getToken();
        return commonDao.getResultStringArray(SQLUtil.GET_ALL_SECURITY_USERS, params);

    }

    @Override
    public String updateUser(UpdateUserRequest request) throws MDLDBException {
        Object [] params = new Object[7];
        params[0] =  request.getToken();
        params[1] =  request.getUserid();
        params[2] =  request.getFirstname();
        params[3] =  request.getLastname();
        params[4] =  request.getEmail();
        params[5] =  request.getUsername();
        params[6] =  request.getRoleid();
        return commonDao.getResultStringObject(SQLUtil.UPDATE_USER, params);
    }

    @Override
    public String getUserById(GetUserByIdRequest request) throws MDLDBException {
        Object [] params = new Object[2];
        params[0] =  request.getToken();
        params[1] =  request.getUserid();
        return commonDao.getResultStringObject(SQLUtil.GET_USER_BY_ID, params);
    }

    @Override
    public String deleteUser(GetUserByIdRequest request) throws MDLDBException {
        Object [] params = new Object[2];
        params[0] =  request.getToken();
        params[1] =  request.getUserid();
        return commonDao.getResultStringObject(SQLUtil.DELETE_USER, params);
    }

    @Override
    public String updatePassword(PasswordUpdateRequest request) throws MDLDBException {
        Object [] params = new Object[4];
        params[0] =  request.getToken();
        params[1] =  request.getNewpass();
        params[2] =  request.getAdminpass();
        params[3] =  request.getUserid();
        return commonDao.getResultStringObject(SQLUtil.UPDATE_PASSWORD, params);
    }

    /**
     * Get permissions of the role
     * @param roleId
     * @return
     * @throws MDLDBException
     */
    @Override
    public Map<Integer, String> getPermissions(int roleId) throws MDLDBException {
        return userDao.getPermissions(roleId);
    }
}
