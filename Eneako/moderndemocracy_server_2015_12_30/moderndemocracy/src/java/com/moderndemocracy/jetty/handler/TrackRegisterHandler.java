package com.moderndemocracy.jetty.handler;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.anaeko.utils.app.Configuration;
import com.anaeko.utils.http.Code;
import com.anaeko.utils.io.MarshalerException;
import com.moderndemocracy.dao.TrackRegisterDao;
import com.moderndemocracy.dao.UsersDao;
//import com.moderndemocracy.json.UserMarshaler;
//import com.moderndemocracy.pojo.FormDesign;
//import com.moderndemocracy.pojo.FormResponse;
import com.moderndemocracy.pojo.AuthenticatedUser;
import com.moderndemocracy.pojo.User;

public class TrackRegisterHandler extends ModernDemocracyHandler {

	private static final Logger logger = Logger.getLogger(TrackRegisterHandler.class);

	private static final String COUNCIL_ID  = "councilid";
	
	@Override
	protected String getSupportedMethods() {
		return "POST";
	}

	@Override
	protected void handlePost(String target, HttpServletRequest request,
			HttpServletResponse response) throws MarshalerException,
			IOException {

		try {
			
			// DAOs
			UsersDao userDao = new UsersDao(getDataSource());
			TrackRegisterDao trackRegisterDao = new TrackRegisterDao(getDataSource());
						
			// Get user info by sessionId
			String id = read(request).sessionId();
			AuthenticatedUser currentUser = (AuthenticatedUser)getServiceContext().getUser(id);
			User user = userDao.getById(currentUser.getId());
			
			Integer userId = user.getId();
			
			// Get Parameters
			Configuration payload = readStream(request).asConfiguration();
			Integer councilId  = payload.getIntProperty(COUNCIL_ID,0);
			
			trackRegisterDao.insert(userId, councilId);
			
		} catch (Exception e) {
			logger.error("Unexpected Exception", e);
			send(request, response).status(Code.SERVER_ERROR_INTERNAL);
		}
	}
}
