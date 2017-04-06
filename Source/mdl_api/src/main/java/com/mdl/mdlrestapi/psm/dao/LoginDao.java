package com.mdl.mdlrestapi.psm.dao;

import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.psm.model.JWTAccessToken;
import com.mdl.mdlrestapi.psm.model.User;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: AnushaP
 * Date: 2/16/17
 * Time: 12:59 PM
 * To change this template use File | Settings | File Templates.
 */
public interface LoginDao {

    /**
     * Validate user credentials
     * @param username
     * @param organizationName
     * @param password
     * @return
     * @throws MDLDBException
     */
    public boolean validatePassword(String username, String organizationName,String password )throws MDLDBException;

    /**
     * Save JWT information
     * @param jwtAccessToken
     * @throws MDLDBException
     */
    public void saveJWTTokenInfo(JWTAccessToken jwtAccessToken)throws MDLDBException;

    /**
     * Get JWT information
     * @param username
     * @param organizationName
     * @param tokenSignature
     * @return
     * @throws MDLDBException
     */
    public List<JWTAccessToken> getJWTTokenInfo(String username, String organizationName, String tokenSignature)throws MDLDBException;

    /**
     * This is call Login_v2 stored procedure: Validate user credentials and save Token
     * @param username
     * @param organizationName
     * @param password
     * @return
     * @throws MDLDBException
     */
    public String createAccessToken(String username, String organizationName, String password)throws MDLDBException;

    /**
     * Delete JWT token Information
     * @param username
     * @param organizationName
     * @param tokenSignature
     * @throws MDLDBException
     */
    public void deleteJWTToken(String username, String organizationName, String tokenSignature)throws MDLDBException;

    /**
     * Find user
     * @param username
     * @param organizationName
     * @return
     * @throws MDLDBException
     */
    public User findUser(String username, String organizationName)throws MDLDBException;
}
