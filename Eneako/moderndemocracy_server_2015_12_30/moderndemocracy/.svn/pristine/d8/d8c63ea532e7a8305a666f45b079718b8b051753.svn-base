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
import com.moderndemocracy.pojo.DashboardAge;
import com.moderndemocracy.pojo.DashboardChart;
import com.moderndemocracy.pojo.DashboardGender;
import com.moderndemocracy.pojo.DashboardTotal;
import com.moderndemocracy.pojo.DashboardUsers;

public class DashboardUsersHandler extends ModernDemocracyHandler {

	private static final Logger logger = Logger.getLogger(DashboardUsersHandler.class);

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
			send(request, response).json(getDashboardUsers(councilId, start, end));

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
//			// REQUEST PARAMS
//			Configuration payload = readStream(request).asConfiguration();
//			
//			Integer councilId = payload.getIntProperty(COUNCIL_ID,0);
//
//			DateTimeFormatter format = DateTimeFormat.forPattern("yyyy-MM-dd");
//			Timestamp start = new Timestamp(format.parseDateTime(payload.getProperty(START,"")).getMillis());
//			Timestamp end = new Timestamp(format.parseDateTime(payload.getProperty(END,"")).getMillis()+(((24*60*60))*1000));
//			
//			logger.debug("start="+start+" end="+end);
//			
//			// DahsboardUsers object
//			DashboardUsers dashboardUsers = new DashboardUsers();
//			
//			// Get all DashboardUsers components
//			List<DashboardChart> dashboardChart = dashboardChartDao.getUsers(councilId,start,end);
//			DashboardTotal dashboardTotal = dashboardTotalDao.getUsers(councilId,start, end).get(0);
//			List<DashboardAge> dashboardAge = dashboardAgeDao.getUsers(councilId, start, end);
//			List<DashboardGender> dashboardGender = dashboardGenderDao.getUsers(councilId,start, end);
//			
//			
//			// Include components into DashboardUsers
//			dashboardUsers.setDashboardChart(dashboardChart);
//			dashboardUsers.setDashboardTotal(dashboardTotal);
//			dashboardUsers.setDashboardAge(dashboardAge);
//			dashboardUsers.setDashboardGender(dashboardGender);
//			
//			
//			// Return response
//			send(request, response).json(dashboardUsers);
//			
//		} catch (Exception e) {
//			logger.error("Unexpected Exception", e);
//			send(request, response).status(Code.SERVER_ERROR_INTERNAL);
//		}
//	}
	
	protected DashboardUsers getDashboardUsers (
			Integer councilId, 
			String startStr, 
			String endStr) throws Exception {
		
		// DAOs
		DashboardChartDao dashboardChartDao = new DashboardChartDao(getDataSource());
		DashboardTotalDao dashboardTotalDao = new DashboardTotalDao(getDataSource());
		DashboardAgeDao dashboardAgeDao = new DashboardAgeDao(getDataSource());
		DashboardGenderDao dashboardGenderDao = new DashboardGenderDao(getDataSource());

		DateTimeFormatter format = DateTimeFormat.forPattern("yyyy-MM-dd");
		Timestamp everStart = new Timestamp(format.parseDateTime("2015-01-01").getMillis());
		Timestamp start = new Timestamp(format.parseDateTime(startStr).getMillis());
		Timestamp end = new Timestamp(format.parseDateTime(endStr).getMillis()+(((24*60*60))*1000));
		
		// DahsboardUsers object
		DashboardUsers dashboardUsers = new DashboardUsers();
		
		// Get all DashboardUsers components
		List<DashboardChart> dashboardChart = dashboardChartDao.getUsers(councilId,start,end);
		
		logger.debug("dashboardChart size = "+dashboardChart.size());
		
		DashboardTotal dashboardTotal = dashboardTotalDao.getUsers(councilId,everStart, end).get(0);
		List<DashboardAge> dashboardAge = dashboardAgeDao.getUsers(councilId, everStart, end);
		List<DashboardGender> dashboardGender = dashboardGenderDao.getUsers(councilId,everStart, end);
		
		// Include components into DashboardUsers
		dashboardUsers.setDashboardChart(dashboardChart);
		dashboardUsers.setDashboardTotal(dashboardTotal);
		dashboardUsers.setDashboardAge(dashboardAge);
		dashboardUsers.setDashboardGender(dashboardGender);
		
		
		// Return response
		return dashboardUsers;
	}

}
