package com.mdl.mdlrestapi.psm.service.impl;

import com.mdl.mdlrestapi.psm.model.User;
import com.mdl.mdlrestapi.psm.utils.ConfigUtil;
import org.apache.log4j.Logger;
import org.json.JSONObject;
import java.sql.Timestamp;
import java.util.List;

import com.mdl.mdlrestapi.psm.dao.LoginDao;
import com.mdl.mdlrestapi.psm.dao.impl.LoginDaoImpl;
import com.mdl.mdlrestapi.psm.model.JWTAccessToken;
import com.mdl.mdlrestapi.psm.service.LoginService;
import com.mdl.mdlrestapi.psm.utils.JWTClaims;
import com.mdl.mdlrestapi.psm.resource.dto.LoginResponse;
import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.psm.exception.MDLServiceException;
import com.mdl.mdlrestapi.psm.model.JWTTokenStatus;
import com.mdl.mdlrestapi.psm.utils.ErrorCodes;
import com.mdl.mdlrestapi.psm.utils.SecurityUtility;

/**
 * Created with IntelliJ IDEA.
 * User: AnushaP
 * Date: 2/16/17
 * Time: 12:59 PM
 * To change this template use File | Settings | File Templates.
 */
public class LoginServiceImpl implements LoginService {
    private static final Logger logger = Logger.getLogger(LoginServiceImpl.class);
    private static final String UNAUTHORIZED = "unauthorized";

    LoginDao loginDao = new LoginDaoImpl();

    @Override
    public LoginResponse processLogin(String username, String organizationCode, String password) throws MDLServiceException,MDLDBException {
        String token = null;
        LoginResponse loginResponse = new LoginResponse();
        JSONObject jsonObject = new JSONObject();
        try {
            token = loginDao.createAccessToken(username, organizationCode, password);
        } catch (MDLDBException e) {
        }
        if (token == null || token.isEmpty()){
            throw new MDLServiceException(ErrorCodes.TOKEN_CREATION_FAIL);
        } else if (token.equals(UNAUTHORIZED)) {
            throw new MDLServiceException(ErrorCodes.INVALID_CREDENTIALS);
        } else {
            //Validate user
            boolean isValidUser = loginDao.validatePassword(username, organizationCode, password);
            User user = loginDao.findUser(username, organizationCode) ;
            if (isValidUser) {
                JWTClaims jwtClaims = loadJWTClaims(username, organizationCode, user.getRoleId());
                String jwtToken = SecurityUtility.generateToken(jwtClaims);
                if (jwtToken != null && !jwtToken.isEmpty()) {
                    JWTAccessToken jwtAccessToken = setJWTAccessToken(jwtClaims, jwtToken);
                    loginDao.saveJWTTokenInfo(jwtAccessToken);
                    jsonObject.put("jwt", jwtToken);
                } else {
                    throw new MDLServiceException(ErrorCodes.JWT_CREATION_FAIL);
                }
            } else {
                throw new MDLServiceException(ErrorCodes.INVALID_CREDENTIALS);
            }
            jsonObject.put("token", token);
            loginResponse.jsonObject = jsonObject;
        }
        return loginResponse;

    }

    @Override
    public boolean validateJWTTokenWithDB(String token, JWTClaims jwtClaims)  {

        List<JWTAccessToken> jwtAccessTokenList = null;
        try {
            jwtAccessTokenList = loginDao.getJWTTokenInfo(jwtClaims.getName(), jwtClaims.getOrganization(), getSignature(token));
            if (jwtAccessTokenList == null || jwtAccessTokenList.size() == 0) {
                return false;
            }
        } catch (MDLDBException e) {
            return false;
        }
        return true;
    }

    @Override
    public boolean deleteJWTToken(String jwtToken) throws MDLServiceException {
        try {
            JWTClaims jwtClaims = SecurityUtility.validateJWTAndGetClaims(jwtToken);
            List<JWTAccessToken> jwtAccessTokens = loginDao.getJWTTokenInfo(jwtClaims.getName(), jwtClaims.getOrganization(), getSignature(jwtToken));
            if (jwtAccessTokens == null || jwtAccessTokens.isEmpty()) {
                throw new MDLServiceException(ErrorCodes.NO_RECORD_FOUND);
            }
            loginDao.deleteJWTToken(jwtClaims.getName(), jwtClaims.getOrganization(), getSignature(jwtToken));
        } catch ( MDLDBException e) {
            throw new MDLServiceException(e.getMessage());
        }
        return true;
    }

    private JWTAccessToken setJWTAccessToken(JWTClaims jwtClaims, String jwtToken) {
        JWTAccessToken jwtAccessToken = new JWTAccessToken();
        jwtAccessToken.setUserName(jwtClaims.getName());
        jwtAccessToken.setOrganizationCode(jwtClaims.getOrganization());
        jwtAccessToken.setToken(getSignature(jwtToken));
        jwtAccessToken.setStatus(JWTTokenStatus.ACTIVE.getCode());
        jwtAccessToken.setTimeCreated(new Timestamp(jwtClaims.getExpiration() - ConfigUtil.EXPIRE_TIME));
        jwtAccessToken.setValidity(ConfigUtil.EXPIRE_TIME);
        return jwtAccessToken;
    }

    private String getSignature(String jwtToken) {
        String signature = jwtToken.split("[.]")[2];
        if (signature.length() > 100) {
            signature = signature.substring(signature.length() - 100);
        }
        return signature;
    }

    private JWTClaims loadJWTClaims(String username, String organizationCode , int roleId) {
        long currentMilliseconds = SecurityUtility.getCurrentMilliseconds();
        JWTClaims jwtClaims = new JWTClaims();
        jwtClaims.setSubject(username);
        jwtClaims.setIssuer("MDL");
        jwtClaims.setExpiration(currentMilliseconds);
        jwtClaims.setOrganization(organizationCode);
        jwtClaims.setName(username);
        jwtClaims.setRoleId(roleId);
        return jwtClaims;
    }

}
