package com.mdl.mdlrestapi.psm.service;


import static org.mockito.Matchers.any;

import com.mdl.mdlrestapi.psm.model.User;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.ExpectedException;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.MockitoAnnotations;

import com.mdl.mdlrestapi.psm.dao.LoginDao;
import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.psm.exception.MDLServiceException;
import com.mdl.mdlrestapi.psm.model.JWTAccessToken;
import com.mdl.mdlrestapi.psm.resource.dto.LoginResponse;
import com.mdl.mdlrestapi.psm.service.impl.LoginServiceImpl;
import com.mdl.mdlrestapi.psm.utils.ErrorCodes;
import com.mdl.mdlrestapi.psm.utils.ConfigUtil;



/**
 * @author niranjan
 *
 */
public class LoginServiceTest {
	
	@InjectMocks
	LoginServiceImpl loginService;
	
	@Mock
	LoginDao loginDao;
	
	private String oriToken = "QA12GEWWWWER222";
	private String username = "testuser";
	private String organizationCode = "2";
	private String password = "testpass";
    private int roleId = 1;
    private User user = null;
	
	@Rule
	public ExpectedException expectedEx = ExpectedException.none();
	
	
	
	
	@Before
    public void initMocks()
    {
		ConfigUtil.SECRET_KEY = "testsecretkey";
        user = new User();
        user. setUsername(username);
        user.setRoleId(roleId);
        MockitoAnnotations.initMocks(this);
    }
	
	@Test
	public void processLoginTestSuccess() throws MDLDBException, MDLServiceException{
		
		
		Mockito.when(loginDao.createAccessToken(any(String.class), any(String.class), any(String.class))).thenReturn(oriToken);
		Mockito.when(loginDao.validatePassword(any(String.class), any(String.class), any(String.class))).thenReturn(true);
		Mockito.doNothing().when(loginDao).saveJWTTokenInfo(any(JWTAccessToken.class));
        Mockito.when(loginDao.findUser(any(String.class), any(String.class))).thenReturn(user);
		
		LoginResponse loginResponse = loginService.processLogin(username, organizationCode, password);
		String token = (String) loginResponse.jsonObject.get("token");
		String jwt = (String) loginResponse.jsonObject.get("jwt");
		
		Assert.assertEquals(oriToken, token);
		Assert.assertNotNull(jwt);
		
	}
	
	
	@Test
	public void processLoginTestNullToken() throws MDLDBException, MDLServiceException{
		
		expectedEx.expect(MDLServiceException.class);
	    expectedEx.expectMessage(ErrorCodes.TOKEN_CREATION_FAIL);
		
		Mockito.when(loginDao.createAccessToken(any(String.class), any(String.class), any(String.class))).thenReturn(null);
		loginService.processLogin(username, organizationCode, password);
		
	}
	
	
	@Test
	public void processLoginTestUnauthorized() throws MDLDBException, MDLServiceException{
		
		expectedEx.expect(MDLServiceException.class);
	    expectedEx.expectMessage(ErrorCodes.INVALID_CREDENTIALS);
		
		Mockito.when(loginDao.createAccessToken(any(String.class), any(String.class), any(String.class))).thenReturn("unauthorized");
		loginService.processLogin(username, organizationCode, password);
		
	}
	
	
	@Test
	public void processLoginTestInvalidUser() throws MDLDBException, MDLServiceException{
		
		expectedEx.expect(MDLServiceException.class);
	    expectedEx.expectMessage(ErrorCodes.INVALID_CREDENTIALS);
		
		Mockito.when(loginDao.createAccessToken(any(String.class), any(String.class), any(String.class))).thenReturn(oriToken);
		Mockito.when(loginDao.validatePassword(any(String.class), any(String.class), any(String.class))).thenReturn(false);
		Mockito.doNothing().when(loginDao).saveJWTTokenInfo(any(JWTAccessToken.class));
		
		loginService.processLogin(username, organizationCode, password);
		
	}
		

}
