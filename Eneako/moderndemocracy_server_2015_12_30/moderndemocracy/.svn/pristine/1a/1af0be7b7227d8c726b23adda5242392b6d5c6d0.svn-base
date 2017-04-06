package com.moderndemocracy.jetty.handler;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import org.apache.log4j.Logger;

import com.anaeko.utils.app.Configuration;
import com.anaeko.utils.http.Code;
import com.anaeko.utils.io.MarshalerException;
import com.moderndemocracy.dao.NotificationDao;
import com.moderndemocracy.dao.UsersDao;
import com.moderndemocracy.pojo.AuthenticatedUser;
import com.moderndemocracy.pojo.Notification;
import com.moderndemocracy.pojo.User;

public class NotificationHandler extends ModernDemocracyHandler {

	private static final Logger logger = Logger.getLogger(NotificationHandler.class);

	private static final String STATION_ID = "stationId";
	private static final String TEXT = "text";
	private static final String STATUS = "status";
	private static final String NOTIFICATION_ID = "notificationId";
	private static final String URL = "url";
	
	@Override
	protected String getSupportedMethods() {
		return "GET,POST";
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
			
			int userId = user.getId();
			int stationId = user.getStationId();
			int councilId = user.getCouncilId();
			
			logger.debug("GET Notification - user "+userId+" | station="+stationId);
			
			// Get notifications for this user at this station
			DataSource source = getDataSource();
			NotificationDao notificationDao = new NotificationDao(source);
			List<Notification> res = notificationDao.getByStationId(stationId, userId, councilId);
			
			if( res == null || res.size() == 0 ) {
				// No notifications
				logger.debug("NO Notifications For User");
				send(request, response).status(Code.SUCCESS_OK);
			}
			
			int lastNotificationId = 0;
			
			for (Notification notification : res) {
				
				logger.debug("NOTIFICATION LIST: " + notification.toString() );
				
				// Update LastNotificationId
				lastNotificationId=notification.getNotificationId();
				
				// Determine Notification Type (Private or Global)
				if (notification.getStationId()==stationId) {
					logger.debug("Setting Notification Type: PRIVATE");
					notification.setPrivate_notification(true);
				}
				else {
					logger.debug("Setting Notification Type: GLOBAL");
					notification.setPrivate_notification(false);
				}
				
				// Update Notifications Received
				if (lastNotificationId>0) {
					notificationDao.updateNotificationReceived(source, lastNotificationId, stationId, userId);
				}
			}

			logger.debug("GET Notification - notification=" + res);
			
			send(request, response).json(res);
			
		}
		catch (Exception e) {
			logger.error("Unexpected Exception", e);
			send(request, response).status(Code.SERVER_ERROR_INTERNAL);
		}
	}
	
	@Override
	protected void handlePost(String target, HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		try {
			
			// Get object for this user
			String id = read(request).sessionId();
			AuthenticatedUser currentUser = (AuthenticatedUser)getServiceContext().getUser(id);
			UsersDao userDao = new UsersDao(getDataSource());
			User user = userDao.getById(currentUser.getId());
			
			Configuration payload = readStream(request).asConfiguration();
			Integer stationId = payload.getIntProperty(STATION_ID,0);
			String text = payload.getProperty(TEXT,"");
                        String url = payload.getProperty(URL,"");
			
			// DAOs
			DataSource source = getDataSource();
			NotificationDao notificationDao = new NotificationDao(source);
			
			logger.debug("POST Notification - text="+text);
			notificationDao.insert( source, user.getId(), user.getCouncilId(), stationId, text,url );
			
		} catch( SQLException e ) {
			handleSQLError(request,response, e);
		}
		
	}
	
	@Override
	protected void handlePut(String target, HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		try {
			
			// Get object for this user.
			String id = read(request).sessionId();
			AuthenticatedUser currentUser = (AuthenticatedUser)getServiceContext().getUser(id);
			UsersDao userDao = new UsersDao(getDataSource());
			User user = userDao.getById(currentUser.getId());
			
			// Get request params
			Configuration payload = readStream(request).asConfiguration();
			Integer status = payload.getIntProperty(STATUS,0);
			Integer notificationId = payload.getIntProperty(NOTIFICATION_ID, 0);
			
			// Get StationId for User
			Integer stationId = user.getStationId();
			
			DataSource source = getDataSource();
			NotificationDao notificationDao = new NotificationDao(source);
			
			logger.debug("Put Notification - status="+status);

			notificationDao.updateStatus( source, notificationId, stationId, status );
			
		} catch( SQLException e ) {
			handleSQLError(request,response, e);
		}
		
	}
}
