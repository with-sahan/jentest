package com.mdl.mdlrestapi.psm.dao;

import com.mdl.mdlrestapi.psm.exception.MDLDBException;

import java.util.Map;

/**
 * Created by AnushaP on 3/22/2017.
 */
public interface UserDao {
    public Map<Integer,String> getPermissions(int roleId) throws MDLDBException;
}
