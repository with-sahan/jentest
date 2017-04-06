package com.moderndemocracy.jetty.handler;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import org.apache.log4j.Logger;

import com.anaeko.utils.app.Configuration;
import com.anaeko.utils.http.Code;
import com.anaeko.utils.io.MarshalerException;
import com.moderndemocracy.dao.ProgressUpdateDao;
import com.moderndemocracy.dao.UsersDao;
import com.moderndemocracy.pojo.AuthenticatedUser;
import com.moderndemocracy.pojo.ProgressUpdate;
import com.moderndemocracy.pojo.User;

public class StationProgressHandler extends ModernDemocracyHandler {

	private static final Logger logger = Logger.getLogger(StationProgressHandler.class);

	private static final String NUMBER_PAPERS_ISSUED_PAYLOAD_NAME = "numberPapersIssued";
	private static final String NUMBER_POSTAL_PACKS_RECEIVED_PAYLOAD_NAME = "numberPostalPacksReceived";
	private static final String NUMBER_POSTAL_PACKS_AWAITING_COLLECTION_PAYLOAD_NAME = "numberPostalPacksAwaitingCollection";
	

	@Override
	protected String getSupportedMethods() {
		return "GET,POST";
	}

	@Override
	protected void handleGet(
			String target, HttpServletRequest request,
			HttpServletResponse response) throws MarshalerException,
			IOException {
		
		try {
			
			// Get object for this user
			String id = read(request).sessionId();
			AuthenticatedUser currentUser = (AuthenticatedUser)getServiceContext().getUser(id);
			UsersDao userDao = new UsersDao(getDataSource());
			User user = userDao.getById(currentUser.getId());
			
			// DAOs
			ProgressUpdateDao progressUpdateDao = new ProgressUpdateDao(getDataSource());
			
			ProgressUpdate res = progressUpdateDao.getProgressUpdateByStationId(user.getStationId());
			
			logger.debug("GET ProgressUpdateByStationId("+user.getStationId()+") = " + res);
			
			send(request, response).json(res);

		} catch (Exception e) {
			logger.error("Unexpected Exception", e);
			send(request, response).status(Code.SERVER_ERROR_INTERNAL);
		}
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
			
			Configuration payload = readStream(request).asConfiguration();
			int numberPapersIssued = payload.getIntProperty(NUMBER_PAPERS_ISSUED_PAYLOAD_NAME,0);
			int numberPostalPacksReceived = payload.getIntProperty(NUMBER_POSTAL_PACKS_RECEIVED_PAYLOAD_NAME,0);
			int numberPostalPacksAwaitingCollection = payload.getIntProperty(NUMBER_POSTAL_PACKS_AWAITING_COLLECTION_PAYLOAD_NAME,0);
			
			DataSource source = getDataSource();
			ProgressUpdateDao progressUpdateDao = new ProgressUpdateDao(getDataSource());
			
			logger.debug("POST StationProgress - stationId="+stationId+" | numberPapersIssued="+numberPapersIssued+" | numberPostalPacksReceived="+numberPapersIssued+" | numberPostalPacksAwaitingCollection="+numberPostalPacksAwaitingCollection);
			
			// Get PaperIssued and PostalPacksReceived from Database
			//ProgressUpdate progressUpdate = progressUpdateDao.getProgressUpdateByStationId(stationId);
			
			// Update PaperIssued and PostalPacksReceived
			//progressUpdateDao.insertProgressUpdate( source, stationId, numberPapersIssued, numberPostalPacksReceived+progressUpdate.getPostalPacksReceived() );
			progressUpdateDao.insertProgressUpdate( source, stationId, numberPapersIssued, numberPostalPacksReceived, numberPostalPacksAwaitingCollection );
			
			
		} catch( SQLException e ) {
			handleSQLError(request,response, e);
		}
		
	}
}
