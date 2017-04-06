package com.moderndemocracy.jetty.handler;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.anaeko.utils.http.Code;
import com.moderndemocracy.dao.PollingStationDao;
import com.moderndemocracy.pojo.AuthenticatedUser;
import com.moderndemocracy.pojo.PollingStation;

public class AuthenticatedUserHandler extends ModernDemocracyHandler {

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.anaeko.jetty.handler.ChainedHandler#getSupportedMethods()
	 */
	@Override
	protected String getSupportedMethods() {
		return "GET";
	}

	@Override
	protected void handleGet(
			String target, 
			HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		
		try {
			
			// Get session ID
			String id = read(request).sessionId();
			logger.debug("Session ID = " + id);
			
			// DAOs
			PollingStationDao pollingStationDao = new PollingStationDao(getDataSource());

			// Get DefaultUser object for this user.
			AuthenticatedUser user = (AuthenticatedUser) getServiceContext().getUser(id);
			
			////logger.debug("PollingPlaceId="+user.getPollingPlaceId());
			
			// Get the list of PollingStation for this user by PollingPlace
			////List<PollingStation> pollingStations = pollingStationDao.getByPollingPlaceId(user.getPollingPlaceId());
			List<PollingStation> pollingStations = pollingStationDao.getByUserId(user.getId());
			user.setPollingStations(pollingStations);

			logger.debug("GET AuthenticatedUser - user=" + user.toString());

			send(request, response).json(user);
			
		} catch (Exception e) {
			logger.error("Unexpected Exception", e);
			send(request, response).status(Code.SERVER_ERROR_INTERNAL);
		}
	}

}
