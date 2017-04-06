package com.moderndemocracy.jetty.handler;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.anaeko.utils.http.Code;
import com.anaeko.utils.io.MarshalerException;
import com.moderndemocracy.dao.StationDao;
import com.moderndemocracy.dao.UsersDao;
import com.moderndemocracy.pojo.AuthenticatedUser;
import com.moderndemocracy.pojo.Station;
import com.moderndemocracy.pojo.User;

public class BallotPaperAccountHandler extends ModernDemocracyHandler {

	private static final Logger logger = Logger.getLogger(BallotPaperAccountHandler.class);

	@Override
	protected String getSupportedMethods() {
		return "GET";
	}

	@Override
	protected void handleGet(String target, HttpServletRequest request,
			HttpServletResponse response) throws MarshalerException,
			IOException {
		
		try {
			
			String id = read(request).sessionId();
			
			// Get object for this user.
			AuthenticatedUser currentUser = (AuthenticatedUser)getServiceContext().getUser(id);
			UsersDao userDao = new UsersDao(getDataSource());
			User user = userDao.getById(currentUser.getId());
			
			int stationId = user.getStationId();
			
			logger.debug("GET BallotBoxPaperAccount - station="+stationId);
			
			// Get notifications for this user at this station
			StationDao stationDao = new StationDao(getDataSource());
			Station res = stationDao.getStationById(stationId);
			
			if( res == null) {
				// No notifications
				logger.debug("NO Station data For user");
				send(request, response).status(Code.SUCCESS_OK);
			}
			
			send(request, response).json(res);

		}
		catch (Exception e) {
			logger.error("Unexpected Exception", e);
			send(request, response).status(Code.SERVER_ERROR_INTERNAL);
		}
	}
	
}
