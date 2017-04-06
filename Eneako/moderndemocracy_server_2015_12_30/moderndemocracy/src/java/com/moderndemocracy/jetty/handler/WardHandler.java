package com.moderndemocracy.jetty.handler;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.anaeko.utils.http.Code;
import com.anaeko.utils.io.MarshalerException;
import com.moderndemocracy.dao.DistrictDao;
import com.moderndemocracy.dao.IssueDao;
import com.moderndemocracy.dao.PlaceDao;
import com.moderndemocracy.dao.StationDao;
import com.moderndemocracy.dao.StationSetupStatusDao;
import com.moderndemocracy.dao.UsersDao;
import com.moderndemocracy.dao.WardsDao;
import com.moderndemocracy.pojo.AuthenticatedUser;
import com.moderndemocracy.pojo.Campaign;
import com.moderndemocracy.pojo.District;
import com.moderndemocracy.pojo.Issue;
import com.moderndemocracy.pojo.Place;
import com.moderndemocracy.pojo.Station;
import com.moderndemocracy.pojo.StationSetupStatus;
import com.moderndemocracy.pojo.User;
import com.moderndemocracy.pojo.Ward;

public class WardHandler extends ModernDemocracyHandler {

	private static final Logger logger = Logger.getLogger(WardHandler.class);

	@Override
	protected String getSupportedMethods() {
		return "GET";
	}

	@Override
	protected void handleGet(String target, HttpServletRequest request,
			HttpServletResponse response) throws MarshalerException,
			IOException {

		// Calculate the TotalBallotPapersIssued and TotalPostalPacks
		int totalBallotPapersIssued = 0;
		int totalPostalPacks = 0;
		int ordinaryTotalIssued = 0;
		int ordinaryNumberOfReplacements = 0;
		int ordinaryCalsIssuedAndNotSpoilt = 0;
		int ordinaryTotalUnused = 0;
		int tenderedTotalIssued = 0;
		int tenderedTotalSpoilt = 0;
		int tenderedTotalUnused = 0;
		
		try {
			
			// DAOs
			UsersDao userDao = new UsersDao(getDataSource());
			
			WardsDao wardDao = new WardsDao(getDataSource());
			DistrictDao districtDao = new DistrictDao(getDataSource());
			PlaceDao placeDao = new PlaceDao(getDataSource());
			StationDao stationDao = new StationDao(getDataSource());
			
			StationSetupStatusDao stationSetupStatusDao = new StationSetupStatusDao(getDataSource());
			
			// Get session ID
			String id = read(request).sessionId();
			AuthenticatedUser currentUser = (AuthenticatedUser)getServiceContext().getUser(id);
			User user = userDao.getById(currentUser.getId());
			logger.debug("GetWardsByCouncilId "+user.getCouncilId());
			
			// Declare the Campaign
			Campaign campaign = new Campaign();
			
			// Insert Wards into Campaign
			List<Ward> wards;
			
			//if (user.getRoleId()>1) {
				logger.debug("GetWardByCouncilIdAndUserId - RoleId="+user.getRoleId());
				wards = wardDao.getByCouncilIdAndUserId(user.getCouncilId(),user.getId());
			//}
//			else {
//				logger.debug("GetWardByCouncilId - RoleId="+user.getRoleId());
//				wards = wardDao.getByCouncilId(user.getCouncilId());
//			}
			
			campaign.setWards(wards);
			
			if (wards!=null) {
				
				// Insert Districts into each Ward
				for (Ward ward : wards) {
					
					List<District> districts = districtDao.getDistrictByWardId(ward.getId());
					int wardTotalBallotPapersIssued = 0;
					int wardTotalPostalPackReceived = 0;
					
					if (districts!=null) {
						
						// Insert Place into each District
						for (District district : districts) {
							
							List<Place> places = placeDao.getPlaceByDistrictId(district.getDistrictId());
							
							if (places!=null) {
								
								// Insert Station into each Place
								for (Place place : places) {
									
									List<Station> stations = stationDao.getStationByPlaceId(place.getPlaceId());
									
									if (stations!=null) {
										
										for (Station station : stations) {
											
											List<StationSetupStatus> stationSetupStatusList = stationSetupStatusDao.getStationSetupStateByStationId(station.getId());
											
											for (StationSetupStatus stationSetupStatus : stationSetupStatusList) {
												if (stationSetupStatus.getStationSetupListId()==1 && stationSetupStatus.getStatus()==true) {
													station.setStationOpen(true);
												}
												else {
													station.setStationOpen(false);
												}
											}
											
											 // NEW CODE TO SET GREEN/ORANGE/RED STATUS BY OPEN ISSUES FOR A STATION
											int highIssue = 0;
											int mediumIssue = 0;
											
											IssueDao issueDao = new IssueDao(getDataSource());
											List<Issue> issues = issueDao.getByStationId(station.getId());
											logger.debug("Retrieved IssueList: " + issues);
											
											if( issues != null ) {
												for (Issue issue : issues) {
													
													if( issue.getStation().equals(station.getStationName()) ) {
														
														if (issue.getStatus()==false) {
															logger.debug("ISSUE OPEN");
															
															if( issue.getPriority().equals("Medium") || issue.getPriority().equals("Low") ) {
																logger.debug("ISSUE Medium or Low");
																mediumIssue++;
															} else if( issue.getPriority().equals("High") ) {
																logger.debug("ISSUE High");
																highIssue++;
															}
														}
														else {
															logger.debug("Issue closed");
														}
													}
												}
											}
											
											if( highIssue > 0 ) {
												station.setStationStatus(Station.RED);
											} else if( mediumIssue > 0 ) { 
												station.setStationStatus(Station.ORANGE);
											} else {
												station.setStationStatus(Station.GREEN);
											}
											
											// Cummulate TotalBallotPapersIssued and TotalPostalPacks
											totalBallotPapersIssued += station.getBallotPapersIssued();
											totalPostalPacks += station.getPostalPacksReceived();
											ordinaryTotalIssued += station.getOrdinaryTotalIssued();
											ordinaryNumberOfReplacements += station.getOrdinaryNumberOfReplacements();
											ordinaryCalsIssuedAndNotSpoilt += station.getOrdinaryCalsIssuedAndNotSpoilt();
											ordinaryTotalUnused += station.getOrdinaryTotalUnused();
											tenderedTotalIssued += station.getTenderedTotalIssued();
											tenderedTotalSpoilt += station.getTenderedTotalSpoilt();
											tenderedTotalUnused += station.getTenderedTotalUnused();
											
											// Cummulate WardTotalBallotPaperIssued and WardTotalPostalPacks
											wardTotalBallotPapersIssued += station.getBallotPapersIssued();
											wardTotalPostalPackReceived += station.getPostalPacksReceived();
										}
									}
									else {
										logger.debug("stations = null");
									}
									
									place.setStations(stations);
								}
							}
							else {
								logger.debug("places = null");
							}
							
							
							district.setPlaces(places);		
						}
					}
					else {
						logger.debug("districts = null");
					}

					ward.setDistricts(districts);
					ward.setTotalBallotPapersIssued(wardTotalBallotPapersIssued);
					ward.setTotalPostalPacks(wardTotalPostalPackReceived);
					
					wardTotalBallotPapersIssued=0;
					wardTotalPostalPackReceived=0;
				}
			}
			else {
				logger.debug("wards = null");
			}
			
			campaign.setTotalBallotPapersIssued(totalBallotPapersIssued);
			campaign.setTotalPostalPacks(totalPostalPacks);
			campaign.setOrdinaryTotalIssued(ordinaryTotalIssued);
			campaign.setOrdinaryNumberOfReplacements(ordinaryNumberOfReplacements);
			campaign.setOrdinaryCalsIssuedAndNotSpoilt(ordinaryCalsIssuedAndNotSpoilt);
			campaign.setOrdinaryTotalUnused(ordinaryTotalUnused);
			campaign.setTenderedTotalIssued(tenderedTotalIssued);
			campaign.setTenderedTotalSpoilt(tenderedTotalSpoilt);
			campaign.setTenderedTotalUnused(tenderedTotalUnused);
			
			logger.debug("GET Ward with council "+user.getCouncilId()+" =" + campaign.toString());
			send(request, response).json(campaign);
			
		} catch (Exception e) {
			logger.error("Unexpected Exception", e);
			send(request, response).status(Code.SERVER_ERROR_INTERNAL);
		}
	}
}
