package com.mdl.mdlrestapi.psm.service;

import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.psm.exception.MDLServiceException;
import com.mdl.mdlrestapi.psm.utils.JWTClaims;
import com.mdl.mdlrestapi.psm.resource.dto.LoginResponse;

/**
 * Created with IntelliJ IDEA.
 * User: AnushaP
 * Date: 2/16/17
 * Time: 12:59 PM
 * To change this template use File | Settings | File Templates.
 */
public interface LoginService {
    /**
     * Process the login request
     * @param username
     * @param organizationCode
     * @param password
     * @return
     * @throws MDLDBException
     * @throws MDLServiceException
     */
    public LoginResponse processLogin(String username, String organizationCode, String password)  throws MDLDBException, MDLServiceException;

    /**
     * Validate the JWT with the database records
     * @param token
     * @param jwtClaims
     * @return
     */
    public boolean validateJWTTokenWithDB(String token, JWTClaims jwtClaims);

    /**
     * Delete JWT  records from the database
     * @param jwtToken
     * @return
     * @throws MDLServiceException
     */
    public boolean deleteJWTToken(String jwtToken) throws MDLServiceException;
}
