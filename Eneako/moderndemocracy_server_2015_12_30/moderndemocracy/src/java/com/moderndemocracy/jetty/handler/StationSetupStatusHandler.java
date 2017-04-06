package com.moderndemocracy.jetty.handler;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.anaeko.utils.http.Code;
import com.anaeko.utils.io.MarshalerException;
import com.moderndemocracy.dao.StationSetupStatusDao;
import com.moderndemocracy.dao.UsersDao;
import com.moderndemocracy.json.StationSetupListMarshaler;
import com.moderndemocracy.pojo.AuthenticatedUser;
import com.moderndemocracy.pojo.StationSetupList;
import com.moderndemocracy.pojo.StationSetupStatus;
import com.moderndemocracy.pojo.User;

public class StationSetupStatusHandler extends ModernDemocracyHandler {

	private static final Logger logger = Logger.getLogger(StationSetupStatusHandler.class);

	@Override
	protected String getSupportedMethods() {
		return "GET,POST";
	}
	
	@Override
	protected void handleGet(String target, HttpServletRequest request,
			HttpServletResponse response) throws MarshalerException,
			IOException {

		try {
			
			// DAOs
			UsersDao userDao = new UsersDao(getDataSource());
			StationSetupStatusDao stationProgressDao = new StationSetupStatusDao(getDataSource());
			
			// Get user info by sessionId
			String id = read(request).sessionId();
			AuthenticatedUser currentUser = (AuthenticatedUser)getServiceContext().getUser(id);
			User user = userDao.getById(currentUser.getId());
			Integer stationId = user.getStationId();
			
			// Get request params
			String dashboardStationId = request.getParameter("stationId");
			if (dashboardStationId!=null) {
				stationId=Integer.parseInt(dashboardStationId);
				logger.debug("Received stationId parameter = "+stationId);
			}
			
			// Retrieve StationSetupStatus
			List<StationSetupStatus> res = stationProgressDao.getStationSetupStateByStationId(stationId);
			
			logger.debug("GET StationSetupStatus("+stationId+") - stationSetupStatus=" + res);
			
			send(request, response).json(res);
			
		} catch (Exception e) {
			logger.error("Unexpected Exception", e);
			send(request, response).status(Code.SERVER_ERROR_INTERNAL);
		}
	}

	
	@SuppressWarnings("unchecked")
	@Override
	protected void handlePost(String target, HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		// Unmarshal StationSetupState from request
		StationSetupListMarshaler stationSetupListMarshaler = new StationSetupListMarshaler();
		List<StationSetupList> stationSetupLists = (List<StationSetupList>) stationSetupListMarshaler.unmarshal(request.getInputStream());
		
		// Update StationSetupStatus
		try {
			
			// DAOs
			UsersDao userDao = new UsersDao(getDataSource());
			StationSetupStatusDao stationProgressDao = new StationSetupStatusDao(getDataSource());
			
			// Get session ID
			String id = read(request).sessionId();
			logger.debug("Session ID = " + id);
					
			// Get DefaultUser object for this user.
			AuthenticatedUser currentUser = (AuthenticatedUser)getServiceContext().getUser(id);
			
			// Get StationId By UserId
			User user = userDao.getById(currentUser.getId());
			logger.debug("UserId="+user.getId()+", StationId="+user.getStationId());
			
			// Update StationSetup status
			stationProgressDao.updateStatus(user.getStationId(), stationSetupLists);
			
			
		} catch (Exception e) {
			logger.error("Unexpected Exception", e);
			send(request, response).status(Code.SERVER_ERROR_INTERNAL);
		}
	}

}
