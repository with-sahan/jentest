package com.mdl.mdlrestapi.psm.service;

import com.mdl.mdlrestapi.psm.resource.dto.*;
import com.mdl.mdlrestapi.psm.exception.MDLDBException;

/**
 * Created by Thara on 3/2/2017.
 */
public interface RoleService {
    /**
     * Process the role requests
     * @param request
     * @return
     * @throws MDLDBException
     */
    public String addRole(AddRoleRequest request) throws MDLDBException;

    public String getAllRoles(TokenRequest request) throws MDLDBException;

    public String updateRole(UpdateRoleRequest request) throws MDLDBException;

    public String getRoleById(GetRoleByIdRequest request) throws MDLDBException;

    public String deleteRole(DeleteRoleRequest request) throws MDLDBException;
}
