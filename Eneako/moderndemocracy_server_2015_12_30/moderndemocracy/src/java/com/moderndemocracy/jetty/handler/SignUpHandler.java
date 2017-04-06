package com.moderndemocracy.jetty.handler;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.joda.time.LocalDate;
import org.joda.time.Years;

import com.anaeko.utils.app.Configuration;
import com.anaeko.utils.http.Code;
import com.anaeko.utils.io.MarshalerException;
import com.moderndemocracy.dao.UsersDao;

public class SignUpHandler extends ModernDemocracyHandler {

	private static final Logger logger = Logger.getLogger(SignUpHandler.class);

	private static final String COUNCILID  = "councilid";
	private static final String LOGINNAME  = "loginname";
	private static final String PASSWORD   = "password";
	private static final String AGE        = "age";
	private static final String BIRTHDAY   = "birthday";
	private static final String GENDER     = "gender";
	
	@Override
	protected String getSupportedMethods() {
		return "POST";
	}

	@Override
	protected void handlePost(String target, HttpServletRequest request,
			HttpServletResponse response) throws MarshalerException,
			IOException {

		UsersDao usersDao = new UsersDao(getDataSource());
		

		try {
			
			Configuration payload = readStream(request).asConfiguration();
			
			Integer councilId  = payload.getIntProperty(COUNCILID,0);
			String  loginName  = payload.getProperty(LOGINNAME,"");
			String  password   = payload.getProperty(PASSWORD,"");
			Integer age        = payload.getIntProperty(AGE,0);
			String  birthday   = payload.getProperty(BIRTHDAY,"");
			String  gender     = payload.getProperty(GENDER,"");
			
			// Set gender='unknown' if it is not known
			if (gender==null) {
				gender="unknown";
			}
			
			// Set gender to lower case
			gender=gender.toLowerCase();
			
			/*******************************************************************/
			/* Check whether user already exist in DB by email and facebookId */
			/*****************************************************************/
			if (!loginName.equals("")) {
				
				if (usersDao.getByEmail(loginName)!=null) {
					
					// Cope with Facebook Registration - Assumption was made that Age will always be zero when SigUp via Facebook
					if (age!=0) {
						
						logger.error("Account already exist, unable to register new user with email: "+loginName);
						send(request, response).status(Code.SERVER_ERROR_INTERNAL);
					}
				}
				else {


					/********************************/
					/* Determine Age from Birthday */
					/******************************/
					if (age==0) {
						
						String[] dateComponents = birthday.split("/");
						for (String dataComponent : dateComponents) {
							logger.debug("Birthday = "+dataComponent);
						}
						
						if (dateComponents.length==3) {
							LocalDate birthdate = new LocalDate (Integer.parseInt(dateComponents[2]), Integer.parseInt(dateComponents[1]), Integer.parseInt(dateComponents[0])); // Year/Month/Day
							LocalDate now = new LocalDate();
							age = Years.yearsBetween(birthdate, now).getYears();
							logger.debug("Age = "+age);
						}
					}
					

					/**********************/
					/* Register New User */
					/********************/
					usersDao.insert(councilId, loginName, password, age, birthday, gender);

				}
			}
			

			/***************/
			/* Login User */
			/*************/
			//AuthUser user = new AuthUser();
			//user.setLoginName(loginName);
			//user.setSecret(password);
			//loginHandler.login(request, response, user);
			
			
		} catch (Exception e) {
			logger.error("Unexpected Exception", e);
			send(request, response).status(Code.SERVER_ERROR_INTERNAL);
		}
	}
}
