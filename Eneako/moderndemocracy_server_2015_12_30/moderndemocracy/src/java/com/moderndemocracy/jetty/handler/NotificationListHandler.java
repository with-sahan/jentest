package com.moderndemocracy.jetty.handler;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.anaeko.utils.http.Code;
import com.anaeko.utils.io.MarshalerException;
import com.moderndemocracy.dao.DistrictDao;
import com.moderndemocracy.dao.NotificationListDao;
import com.moderndemocracy.dao.NotificationReceivedDao;
import com.moderndemocracy.dao.PlaceDao;
import com.moderndemocracy.dao.StationDao;
import com.moderndemocracy.dao.UsersDao;
import com.moderndemocracy.dao.WardsDao;
import com.moderndemocracy.pojo.AuthenticatedUser;
import com.moderndemocracy.pojo.District;
import com.moderndemocracy.pojo.NotificationList;
import com.moderndemocracy.pojo.NotificationReceived;
import com.moderndemocracy.pojo.Place;
import com.moderndemocracy.pojo.Station;
import com.moderndemocracy.pojo.User;
import com.moderndemocracy.pojo.Ward;

public class NotificationListHandler extends ModernDemocracyHandler {

	private static final Logger logger = Logger.getLogger(NotificationListHandler.class);

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
			NotificationListDao notificationListDao = new NotificationListDao(getDataSource());
			NotificationReceivedDao notificationReceievedDao = new NotificationReceivedDao(getDataSource());
			
			WardsDao wardsDao = new WardsDao(getDataSource());
			DistrictDao districtDao = new DistrictDao(getDataSource());
			PlaceDao placeDao = new PlaceDao(getDataSource());
			StationDao stationDao = new StationDao(getDataSource());
			
			// Get user info by sessionId
			String id = read(request).sessionId();
			AuthenticatedUser currentUser = (AuthenticatedUser)getServiceContext().getUser(id);
			User user = userDao.getById(currentUser.getId());
			
			int role = user.getRoleId();
			List<NotificationList> notificationLists = new ArrayList<NotificationList>();
			
			if (role==1) {
				notificationLists = notificationListDao.getByTabletStationId(user.getCouncilId(), user.getStationId());
				logger.debug("Get NotificationListByTabletStationId("+user.getStationId()+") - NotificationList = " + notificationLists);
			}
			else {
				notificationLists = notificationListDao.getByWebDashboardUserId(user.getId(), user.getCouncilId());
				logger.debug("Get NotificationListByWebDashboardUserId("+user.getId()+") - NotificationList = " + notificationLists);
			}


			if (notificationLists==null) {
				logger.debug("No notifications");
				send(request, response).status(Code.SUCCESS_NO_CONTENT);
			}
			else {
				
				// Determine STATUS for each Notification
				for (NotificationList notificationList : notificationLists) {
					
					logger.debug("StationId="+notificationList.getStationId());
					
					if (notificationList.getStationId()!=0) {
						
						// Check whether this Private notification has been delivered to the station
						NotificationReceived notificationReceived = notificationReceievedDao.getNotificationReceivedByNotificationIdAndStationId(notificationList.getId(),notificationList.getStationId());
						
						if (notificationReceived!=null) {
							
							logger.debug("STATUS = "+notificationReceived.getStatus());
							
							if (notificationReceived.getStatus()==1) {
								notificationList.setStatus("Comfirmed");
								
							}
							else {
								notificationList.setStatus("Delivered");
							}
						}
						else {
							notificationList.setStatus("Sent");
						}
					}
					else {
						
						// Check whether this Global Notification has been delivered to all stations
						int deliveredCount = 0;
						int confirmedCount = 0;
						int totalCount = 0;
						
						List<Ward> wards = wardsDao.getByCouncilId(user.getCouncilId());
						logger.debug("NumberOfWards = "+wards.size());
						
						for (Ward ward : wards) {
							
							List<District> districts = districtDao.getDistrictByWardId(ward.getId()); //ward.getDistricts();
							logger.debug("NumberOfDistricts = "+districts.size());
							
							for (District district : districts) {
								
								List<Place> places = placeDao.getPlaceByDistrictId(district.getDistrictId());
								logger.debug("NumberOfPlaces = "+places.size());
								
								for (Place place : places) {
									
									List<Station> stations = stationDao.getStationByPlaceId(place.getPlaceId());
									logger.debug("NumberOfStations = "+stations.size());
									
									for (Station station : stations) {
										
										NotificationReceived notificationReceived = notificationReceievedDao.getNotificationReceivedByNotificationIdAndStationId(notificationList.getId(),station.getId());
										
										if (notificationReceived!=null) {
											
											logger.debug("Status = "+notificationReceived.getStatus());
											
											if (notificationReceived.getStatus()==1) {
												totalCount++;
												deliveredCount++;
												confirmedCount++;
												logger.debug("[1]");
											}
											else {
												totalCount++;
												deliveredCount++;
												logger.debug("[2]");
											}
										}
										else {
											totalCount++;
										}
										
										logger.debug("TotalCount = "+totalCount);
										logger.debug("DeliveredCount = "+deliveredCount);
										logger.debug("ConfirmedCount = "+confirmedCount);
									}
								}
							}
						}
						
						notificationList.setStatus(""+confirmedCount
														//+"/"+deliveredCount
															+"/"+totalCount);
					}
				}
			}

			send(request, response).json(notificationLists);
			
		} catch (Exception e) {
			logger.error("Unexpected Exception", e);
			send(request, response).status(Code.SERVER_ERROR_INTERNAL);
		}
	}
}
