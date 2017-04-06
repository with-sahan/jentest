package com.moderndemocracy.jetty.handler;

import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import org.apache.log4j.Logger;

import com.anaeko.utils.app.Configuration;
import com.anaeko.utils.http.Code;
import com.anaeko.utils.io.MarshalerException;
import com.moderndemocracy.dao.TrackingDao;
import com.moderndemocracy.dao.UsersDao;
import com.moderndemocracy.pojo.AuthenticatedUser;
import com.moderndemocracy.pojo.Tracking;
import com.moderndemocracy.pojo.User;

public class TrackingHandler extends ModernDemocracyHandler {

	private static final Logger logger = Logger.getLogger(TrackingHandler.class);

	private static final String STATUS = "status";
	private static final String LAT = "lat";
	private static final String LNG = "lng";
	
	
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
			TrackingDao trackingDao = new TrackingDao(getDataSource());
			
			// Get object for this user.
			String id = read(request).sessionId();
			AuthenticatedUser currentUser = (AuthenticatedUser)getServiceContext().getUser(id);
			User user = userDao.getById(currentUser.getId());
			
			int councilId = user.getCouncilId();
			
			List<Tracking> retrackings = trackingDao.getByCouncilId(councilId);
			
			// Set EAT = DispatchedTime + EstimatedTravelTime
			for (Tracking tracking : retrackings) {
				if (tracking.getDispatchTime()!=null) {	
					logger.debug("DispatchTime="+tracking.getDispatchTime());
					Timestamp eta = new Timestamp(tracking.getEta().getTime()+tracking.getDispatchTime().getTime());
					tracking.setEta(eta);
				}
				else {
					tracking.setEta(null);
				}
			}
			
			logger.debug("GET Tracking("+councilId+") - add=" + retrackings);
			send(request, response).json(retrackings);
			
		} catch (Exception e) {
			logger.error("Unexpected Exception", e);
			send(request, response).status(Code.SERVER_ERROR_INTERNAL);
		}
	}
	
	
	@Override
	protected void handlePost(String target, HttpServletRequest request, HttpServletResponse response) throws IOException {
		

		
		try {
			
			// DAOs
			UsersDao userDao = new UsersDao(getDataSource());
			
			// Get object for this user.
			String id = read(request).sessionId();
			AuthenticatedUser currentUser = (AuthenticatedUser)getServiceContext().getUser(id);
			User user = userDao.getById(currentUser.getId());
			
			int stationId = user.getStationId();
			int councilId = user.getCouncilId();
			
			Configuration payload = readStream(request).asConfiguration();
			int status = payload.getIntProperty(STATUS,0);
			double lat = payload.getDoubleProperty(LAT,0.0);
			double lng = payload.getDoubleProperty(LNG,0.0);
						
			DataSource source = getDataSource();
			TrackingDao trackingDao = new TrackingDao(source);
			
			logger.debug("POST Tracking - status="+status+" | lat="+lat+" | lng="+lng);
			
			trackingDao.updateByStationIdAndCouncilId( source, stationId, councilId, status, lat, lng );
			
		} catch( SQLException e ) {
			handleSQLError(request,response, e);
		}
		
	}
}
