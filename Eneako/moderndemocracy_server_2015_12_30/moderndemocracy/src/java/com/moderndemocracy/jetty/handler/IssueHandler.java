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
import com.moderndemocracy.dao.IssueDao;
import com.moderndemocracy.dao.UsersDao;
import com.moderndemocracy.pojo.AuthenticatedUser;
import com.moderndemocracy.pojo.Issue;
import com.moderndemocracy.pojo.User;

public class IssueHandler extends ModernDemocracyHandler {

	private static final Logger logger = Logger.getLogger(IssueHandler.class);

	private static final String REASON = "reason";
	private static final String PRIORITY = "priority";
	private static final String DESCRIPTION = "description";
	
	private static final String ID = "id";
	private static final String STATUS = "status";
	private static final String RESOLUTION = "resolution";
	
	
	@Override
	protected String getSupportedMethods() {
		return "GET,POST,PUT";
	}
	
	@Override
	protected void handleGet(
			String target, HttpServletRequest request,
			HttpServletResponse response) throws MarshalerException,
			IOException {
		
		IssueDao issueDao = new IssueDao(getDataSource());
		
		try {
			
			// DAOs
			UsersDao userDao = new UsersDao(getDataSource());
			
			// Get object for this user
			String id = read(request).sessionId();
			AuthenticatedUser currentUser = (AuthenticatedUser)getServiceContext().getUser(id);
			User user = userDao.getById(currentUser.getId());
			
			List<Issue> res = issueDao.getByCouncilId(user.getCouncilId());
			logger.debug("GET Issues("+user.getCouncilId()+") - issue=" + res);
			send(request, response).json(res);
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
			
			// Get object for this user
			String id = read(request).sessionId();
			AuthenticatedUser currentUser = (AuthenticatedUser)getServiceContext().getUser(id);
			User user = userDao.getById(currentUser.getId());
			
			Configuration payload = readStream(request).asConfiguration();
			String text = payload.getProperty(REASON,"");
			String priority = payload.getProperty(PRIORITY,"");
			String description = payload.getProperty(DESCRIPTION,"");

			DataSource source = getDataSource();
			IssueDao dao = new IssueDao(source);
			
			logger.debug("Post Issue - text="+text+" | priority="+priority+" | description="+description);

			dao.insertIssue( source, user.getCouncilId(), user.getStationId(), text, description, priority );
			
		} catch( SQLException e ) {
			handleSQLError(request,response, e);
		}
		
	}
	
	@Override
	protected void handlePut(String target, HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		try {
			
			Configuration payload = readStream(request).asConfiguration();
			Integer issueId = payload.getIntProperty(ID,0);
			String resolution = payload.getProperty(RESOLUTION);
			Boolean status = payload.getBooleanProperty(STATUS,false);
			
			DataSource source = getDataSource();
			IssueDao dao = new IssueDao(source);
			
			logger.debug("Put Issue - issueId="+issueId+" | resolution="+resolution+" | status="+status);

			dao.updateStatus( source, issueId, resolution, status );
			
		} catch( SQLException e ) {
			handleSQLError(request,response, e);
		}
		
	}

}
