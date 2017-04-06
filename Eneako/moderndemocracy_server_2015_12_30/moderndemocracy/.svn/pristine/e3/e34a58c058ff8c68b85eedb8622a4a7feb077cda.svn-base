package com.moderndemocracy.jetty.handler;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import org.apache.log4j.Logger;

import com.anaeko.utils.http.Code;
import com.moderndemocracy.dao.StationSetupStatusDao;
import com.moderndemocracy.dao.UsersDao;
import com.moderndemocracy.pojo.AuthenticatedUser;
import com.moderndemocracy.pojo.User;

public class StationDeliveredHandler extends ModernDemocracyHandler {

	private static final Logger logger = Logger.getLogger(StationDeliveredHandler.class);

	@Override
	protected String getSupportedMethods() {
		return "POST";
	}

	
	@Override
	protected void handlePost(String target, HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		try {
			
			String id = read(request).sessionId();
			
			// Get object for this user.
			AuthenticatedUser currentUser = (AuthenticatedUser)getServiceContext().getUser(id);
			UsersDao userDao = new UsersDao(getDataSource());
			User user = userDao.getById(currentUser.getId());
			
			int stationId = user.getStationId();
						
			DataSource source = getDataSource();
			StationSetupStatusDao dao = new StationSetupStatusDao(source);
			
			logger.debug("POST StationDelivered - stationId="+stationId);
			
			dao.insertDeliveredTime( source, stationId );
			
		} catch( SQLException e ) {
			handleSQLError(request,response, e);
		} catch (Exception e) {
			logger.error("Unexpected Exception", e);
			send(request, response).status(Code.SERVER_ERROR_INTERNAL);
		}
		
	}
}
