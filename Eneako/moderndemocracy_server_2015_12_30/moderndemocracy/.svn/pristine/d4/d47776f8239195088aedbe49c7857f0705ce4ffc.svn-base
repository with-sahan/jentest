package com.moderndemocracy.jetty.handler;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.anaeko.utils.app.Configuration;
import com.anaeko.utils.http.Code;
import com.anaeko.utils.io.MarshalerException;
import com.moderndemocracy.dao.TrackInstallDao;

public class TrackInstallHandler extends ModernDemocracyHandler {

	private static final Logger logger = Logger.getLogger(TrackInstallHandler.class);

	private static final String COUNCIL_ID  = "councilid";
	
	@Override
	protected String getSupportedMethods() {
		return "POST";
	}

	@Override
	protected void handlePost(String target, HttpServletRequest request,
			HttpServletResponse response) throws MarshalerException,
			IOException {

		try {
			
			// DAOs
			TrackInstallDao trackInstallDao = new TrackInstallDao(getDataSource());	

			// Get Parameters
			Configuration payload = readStream(request).asConfiguration();
			Integer councilId  = payload.getIntProperty(COUNCIL_ID,0);
			
			trackInstallDao.insert(councilId);
			
		} catch (Exception e) {
			logger.error("Unexpected Exception", e);
			send(request, response).status(Code.SERVER_ERROR_INTERNAL);
		}
	}
}
