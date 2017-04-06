package com.moderndemocracy.jetty.handler;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.anaeko.utils.http.Code;
import com.anaeko.utils.io.MarshalerException;
import com.moderndemocracy.dao.SettingsDao;
import com.moderndemocracy.dao.UsersDao;
import com.moderndemocracy.pojo.AuthenticatedUser;
import com.moderndemocracy.pojo.Settings;
import com.moderndemocracy.pojo.User;

public class SettingsHandler extends ModernDemocracyHandler {

	private static final Logger logger = Logger.getLogger(SettingsHandler.class);

	private static final String PLATFORM = "platform";
	private static final String BUILD_NUMBER = "buildNumber";
	
	@Override
	protected String getSupportedMethods() {
		return "GET";
	}

	@Override
	protected void handleGet(String target, HttpServletRequest request,
			HttpServletResponse response) throws MarshalerException,
			IOException {
		

		try {
			
			// DAOs
			UsersDao userDao = new UsersDao(getDataSource());
			SettingsDao settingsDao = new SettingsDao(getDataSource());
						
			// Get user info by sessionId
			String id = read(request).sessionId();
			AuthenticatedUser currentUser = (AuthenticatedUser)getServiceContext().getUser(id);
			User user = userDao.getById(currentUser.getId());
			
			// Get request params
			String platform = request.getParameter(PLATFORM);
			String buildNumber = request.getParameter(BUILD_NUMBER);
			
			logger.debug("Platform="+platform+" BuildNumber="+buildNumber);
			
			// Update user platform and buildNumber
			userDao.updatePlatformAndBuildNumber(user.getId(), platform, buildNumber);
			
			// Get Settings by Council Id
			List<Settings> settings = settingsDao.getSettingsByCouncilId(user.getCouncilId());
			logger.debug("GET Settings for "+user.getLoginName()+" (Council "+user.getCouncilId()+") =" + settings);
			
			// Return news for specific council to client
			send(request, response).json(settings);
			
		} catch (Exception e) {
			logger.error("Unexpected Exception", e);
			send(request, response).status(Code.SERVER_ERROR_INTERNAL);
		}
	}

}
