package com.moderndemocracy.jetty.handler;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;

import com.anaeko.utils.http.Code;
import com.anaeko.utils.io.MarshalerException;
import com.moderndemocracy.dao.DashboardAgeDao;
import com.moderndemocracy.dao.DashboardChartDao;
import com.moderndemocracy.dao.DashboardGenderDao;
import com.moderndemocracy.dao.DashboardTotalDao;
import com.moderndemocracy.dao.SocialsharesDao;
import com.moderndemocracy.pojo.DashboardAge;
import com.moderndemocracy.pojo.DashboardChart;
import com.moderndemocracy.pojo.DashboardGender;
import com.moderndemocracy.pojo.DashboardSocialshares;
import com.moderndemocracy.pojo.DashboardTotal;
import com.moderndemocracy.pojo.Socialshares;

public class DashboardSocialsharesHandler extends ModernDemocracyHandler {

	private static final Logger logger = Logger.getLogger(DashboardSocialsharesHandler.class);

	private static final String COUNCIL_ID  = "councilId";
	private static final String START  = "start";
	private static final String END  = "end";
	
	@Override
	protected String getSupportedMethods() {
		return "GET,POST";
	}

	@Override
	protected void handleGet(String target, HttpServletRequest request,
			HttpServletResponse response) throws MarshalerException,
			IOException {
		
		try {
			
			Integer councilId =  Integer.parseInt(read(request).fromQuery(COUNCIL_ID));
			String start =  read(request).fromQuery(START);
			String end =  read(request).fromQuery(END);
			
			logger.debug("CouncilId="+councilId+" Start="+start+" End="+end);
			
			// Return response
			send(request, response).json(getDashboardSocialNetworks(councilId, start, end));

		} catch (Exception e) {
			logger.error("Unexpected Exception", e);
			send(request, response).status(Code.SERVER_ERROR_INTERNAL);
		}
	}
	
//	@Override
//	protected void handlePost(String target, HttpServletRequest request,
//			HttpServletResponse response) throws MarshalerException,
//			IOException {
//		
//
//		try {
//			
//			// DAOs
//			DashboardChartDao dashboardChartDao = new DashboardChartDao(getDataSource());
//			DashboardTotalDao dashboardTotalDao = new DashboardTotalDao(getDataSource());
//			DashboardAgeDao dashboardAgeDao = new DashboardAgeDao(getDataSource());
//			DashboardGenderDao dashboardGenderDao = new DashboardGenderDao(getDataSource());
//			
//			SocialsharesDao socialsharesDao = new SocialsharesDao(getDataSource());
//						
//			// REQUEST PARAMS
//			Configuration payload = readStream(request).asConfiguration();
//			
//			Integer councilId = payload.getIntProperty(COUNCIL_ID,0);
//
//			DateTimeFormatter format = DateTimeFormat.forPattern("yyyy-MM-dd");
//			Timestamp start = new Timestamp(format.parseDateTime(payload.getProperty(START,"")).getMillis());
//			Timestamp end = new Timestamp(format.parseDateTime(payload.getProperty(END,"")).getMillis());
//			
//			logger.debug("start="+start+" end="+end);
//			
//			// DashboardSocialshares object
//			DashboardSocialshares dashboardSocialshares = new DashboardSocialshares();
//			
//			
//			// Get all DashboardSocialshares components
//			List<DashboardChart> dashboardChart = dashboardChartDao.getSocialshares(councilId, start, end);
//			DashboardTotal dashboardTotal = dashboardTotalDao.getSocialshares(councilId, start, end).get(0);
//			List<DashboardAge> dashboardAge = dashboardAgeDao.getSocialshares(councilId, start, end);
//			List<DashboardGender> dashboardGender = dashboardGenderDao.getSocialshares(councilId, start, end);
//			
//			List<Socialshares> news = socialsharesDao.getSocialTrackings(SocialsharesDao.NEWS_FEED, councilId, start, end);
//			List<Socialshares> events = socialsharesDao.getSocialTrackings(SocialsharesDao.EVENTS_FEED, councilId, start, end);
//			List<Socialshares> candidates = socialsharesDao.getSocialTrackings(SocialsharesDao.CANDIDATES_FEED, councilId, start, end);
//			List<Socialshares> registers = socialsharesDao.getSocialTrackings(SocialsharesDao.REGISTERS_FEED, councilId, start, end);
//			
//			// Include components into DashboardSocialshares
//			dashboardSocialshares.setDashboardChart(dashboardChart);
//			dashboardSocialshares.setDashboardTotal(dashboardTotal);
//			dashboardSocialshares.setDashboardAge(dashboardAge);
//			dashboardSocialshares.setDashboardGender(dashboardGender);
//			
//			dashboardSocialshares.setNews(news);
//			dashboardSocialshares.setEvents(events);
//			dashboardSocialshares.setCandidates(candidates);
//			dashboardSocialshares.setRegisters(registers);
//			
//			// Return response
//			send(request, response).json(dashboardSocialshares);
//			
//		} catch (Exception e) {
//			logger.error("Unexpected Exception", e);
//			send(request, response).status(Code.SERVER_ERROR_INTERNAL);
//		}
//	}
	
	protected DashboardSocialshares getDashboardSocialNetworks (
			Integer councilId, 
			String startStr, 
			String endStr) throws Exception {
		
		// DashboardSocialshares object
		DashboardSocialshares dashboardSocialshares = new DashboardSocialshares();
		
		// DAOs
		DashboardChartDao dashboardChartDao = new DashboardChartDao(getDataSource());
		DashboardTotalDao dashboardTotalDao = new DashboardTotalDao(getDataSource());
		DashboardAgeDao dashboardAgeDao = new DashboardAgeDao(getDataSource());
		DashboardGenderDao dashboardGenderDao = new DashboardGenderDao(getDataSource());
		
		SocialsharesDao socialsharesDao = new SocialsharesDao(getDataSource());

		DateTimeFormatter format = DateTimeFormat.forPattern("yyyy-MM-dd");
		Timestamp everStart = new Timestamp(format.parseDateTime("2015-01-01").getMillis());
		Timestamp start = new Timestamp(format.parseDateTime(startStr).getMillis());
		Timestamp end = new Timestamp(format.parseDateTime(endStr).getMillis()+(((24*60*60))*1000));
		
		logger.debug("start="+start+" end="+end);
		
		// Get all DashboardSocialshares components
		List<DashboardChart> dashboardChart = dashboardChartDao.getSocialshares(councilId, start, end);
		DashboardTotal dashboardTotal = dashboardTotalDao.getSocialshares(councilId, everStart, end).get(0);
		List<DashboardAge> dashboardAge = dashboardAgeDao.getSocialshares(councilId, everStart, end);
		List<DashboardGender> dashboardGender = dashboardGenderDao.getSocialshares(councilId, everStart, end);
		
		List<Socialshares> news = socialsharesDao.getSocialTrackings(SocialsharesDao.NEWS_FEED, councilId, everStart, end);
		List<Socialshares> events = socialsharesDao.getSocialTrackings(SocialsharesDao.EVENTS_FEED, councilId, everStart, end);
		List<Socialshares> candidates = socialsharesDao.getSocialTrackings(SocialsharesDao.CANDIDATES_FEED, councilId, everStart, end);
		List<Socialshares> registers = socialsharesDao.getSocialTrackings(SocialsharesDao.REGISTERS_FEED, councilId, everStart, end);
			
		// Include components into DashboardSocialshares
		dashboardSocialshares.setDashboardChart(dashboardChart);
		dashboardSocialshares.setDashboardTotal(dashboardTotal);
		dashboardSocialshares.setDashboardAge(dashboardAge);
		dashboardSocialshares.setDashboardGender(dashboardGender);
		
		dashboardSocialshares.setNews(news);
		dashboardSocialshares.setEvents(events);
		dashboardSocialshares.setCandidates(candidates);
		dashboardSocialshares.setRegisters(registers);
		
		// Return response
		return dashboardSocialshares;
	}

}
