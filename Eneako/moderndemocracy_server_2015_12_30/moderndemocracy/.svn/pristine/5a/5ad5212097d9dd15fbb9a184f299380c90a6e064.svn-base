package com.moderndemocracy.jetty.handler;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.anaeko.utils.http.Code;
import com.anaeko.utils.io.MarshalerException;
import com.moderndemocracy.dao.UsersDao;
import com.moderndemocracy.json.UserMarshaler;
//import com.moderndemocracy.json.UserMarshaler;
import com.moderndemocracy.pojo.AuthenticatedUser;
//import com.moderndemocracy.pojo.FormDesign;
//import com.moderndemocracy.pojo.FormResponse;
import com.moderndemocracy.pojo.User;

public class UserHandler extends ModernDemocracyHandler {

	private static final Logger logger = Logger.getLogger(UserHandler.class);

	@Override
	protected String getSupportedMethods() {
		return "GET,POST";
	}

	@Override
	protected void handleGet(String target, HttpServletRequest request,
			HttpServletResponse response) throws MarshalerException,
			IOException {

		String sessionId = read(request).sessionId();
		AuthenticatedUser currentUser = (AuthenticatedUser) getServiceContext().getUser(sessionId);
		int userId = currentUser.getId();

		UsersDao usersDao = new UsersDao(getDataSource());

		try {
			User res = usersDao.getById(userId);
			
			logger.debug("GET User - userId="+userId + res);
			
			send(request, response).json(res);
			
		} catch (Exception e) {
			logger.error("Unexpected Exception", e);
			send(request, response).status(Code.SERVER_ERROR_INTERNAL);
		}
	}
	
	@Override
	protected void handlePost(String target, HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		// Unmarshal StationSetupState from request
		UserMarshaler userMarshaler = new UserMarshaler();
		User newUser = (User) userMarshaler.unmarshal(request.getInputStream());
		
		logger.debug("inputStream = "+request.getInputStream().toString());
		logger.debug("newUser = "+newUser.toString());
		
		// Update StationSetupStatus
		try {
			
			// DAOs
			UsersDao userDao = new UsersDao(getDataSource());
			
			// Get session ID
			String id = read(request).sessionId();
			AuthenticatedUser currentUser = (AuthenticatedUser)getServiceContext().getUser(id);
			User user = userDao.getById(currentUser.getId());
			logger.debug("Updating user="+user.getId()+" StationId="+user.getStationId()+" to "+newUser.getStationId());
			
			// Update StationSetup status
			userDao.updateStationId(user.getId(), newUser.getStationId());
			
			
		} catch (Exception e) {
			logger.error("Unexpected Exception", e);
			send(request, response).status(Code.SERVER_ERROR_INTERNAL);
		}
	}
}
