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
import com.moderndemocracy.pojo.DashboardDownloads;
import com.moderndemocracy.pojo.DashboardGender;
import com.moderndemocracy.pojo.DashboardTotal;

public class DashboardDownloadsHandler extends ModernDemocracyHandler {

	private static final Logger logger = Logger.getLogger(DashboardDownloadsHandler.class);

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
			send(request, response).json(getDashboardDownloads(councilId, start, end));

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
//		try {
//			
//			// REQUEST PARAMS
//			Configuration payload = readStream(request).asConfiguration();
//			
//			Integer councilId = payload.getIntProperty(COUNCIL_ID,0);
//			String start = payload.getProperty(START,"");
//			String end = payload.getProperty(END,"");
//			
//			logger.debug("councilId="+councilId+" start="+start+" end="+end);
//			
//			// Return response
//			send(request, response).json(getDashboardDownloads(councilId,start,end));
//			
//		} catch (Exception e) {
//			logger.error("Unexpected Exception", e);
//			send(request, response).status(Code.SERVER_ERROR_INTERNAL);
//		}
//	}
	
	protected DashboardDownloads getDashboardDownloads (
			Integer councilId, 
			String startStr, 
			String endStr) throws Exception {	

		// DashboardDownloads object
		DashboardDownloads dashboardDownloads = new DashboardDownloads();
		
		// DAOs
		DashboardChartDao dashboardChartDao = new DashboardChartDao(getDataSource());
		DashboardTotalDao dashboardTotalDao = new DashboardTotalDao(getDataSource());
		DashboardAgeDao dashboardAgeDao = new DashboardAgeDao(getDataSource());
		DashboardGenderDao dashboardGenderDao = new DashboardGenderDao(getDataSource());
		
		DateTimeFormatter format = DateTimeFormat.forPattern("yyyy-MM-dd");
		Timestamp everStart = new Timestamp(format.parseDateTime("2015-01-01").getMillis());
		Timestamp start = new Timestamp(format.parseDateTime(startStr).getMillis());
		Timestamp end = new Timestamp(format.parseDateTime(endStr).getMillis()+((24*60*60)*1000));
		
		logger.debug("start="+start+" end="+end);
		
		// Get all dashboard downloads components
		List<DashboardChart> dashboardChart = dashboardChartDao.getDownloads(councilId, start,end);
		DashboardTotal dashboardTotal = dashboardTotalDao.getDownloads(councilId, everStart, end).get(0);
		List<DashboardAge> dashboardAge = dashboardAgeDao.getDownloads(councilId, everStart, end);
		List<DashboardGender> dashboardGender = dashboardGenderDao.getDownloads(councilId, everStart, end);
		
		// Include components into DashboardDownloads
		dashboardDownloads.setDashboardChart(dashboardChart);
		dashboardDownloads.setDashboardTotal(dashboardTotal);
		dashboardDownloads.setDashboardAge(dashboardAge);
		dashboardDownloads.setDashboardGender(dashboardGender);
		
		// Return response
		return dashboardDownloads;
	}

}
