package com.mdl.mdlrestapi.psm.service;

import java.util.Map;

import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.psm.resource.dto.TokenRequest;
import com.mdl.mdlrestapi.psm.resource.dto.*;

/**
 * Created with IntelliJ IDEA.
 * User: Thara
 * Date: 2/28/17
 * Time: 12:59 PM
 * To change this template use File | Settings | File Templates.
 */
public interface UserService {
    /**
     * Process the user requests
     * @param request
     * @return
     * @throws MDLDBException
     */
    public String addUser(AddUserRequest request) throws MDLDBException;

    public String getAllUsers(TokenRequest request) throws MDLDBException;

    public String updateUser(UpdateUserRequest request) throws MDLDBException;

    public String getUserById(GetUserByIdRequest request) throws MDLDBException;

    public String deleteUser(GetUserByIdRequest request) throws MDLDBException;

    public String updatePassword(PasswordUpdateRequest request) throws MDLDBException;

    /**
     * Get permissions of the role
     * @param roleId
     * @return
     * @throws MDLDBException
     */
    public Map<Integer,String> getPermissions(int roleId)throws MDLDBException;
}
