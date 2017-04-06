package com.moderndemocracy.jetty.handler;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.anaeko.utils.http.Code;
import com.anaeko.utils.io.MarshalerException;
import com.moderndemocracy.dao.IssueListDao;
import com.moderndemocracy.dao.UsersDao;
import com.moderndemocracy.pojo.AuthenticatedUser;
import com.moderndemocracy.pojo.IssueList;
import com.moderndemocracy.pojo.User;

public class IssueListHandler extends ModernDemocracyHandler {

	private static final Logger logger = Logger.getLogger(IssueListHandler.class);

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
			IssueListDao issueListDao = new IssueListDao(getDataSource());
			
			// Get user info by sessionId
			String id = read(request).sessionId();
			AuthenticatedUser currentUser = (AuthenticatedUser)getServiceContext().getUser(id);
			User user = userDao.getById(currentUser.getId());
			Integer councilId = user.getCouncilId();
			
			List<IssueList> res = issueListDao.getByCouncilId(councilId);
			
			logger.debug("Get IssueList("+councilId+") - IssueList = " + res);
			
			send(request, response).json(res);
			
		} catch (Exception e) {
			logger.error("Unexpected Exception", e);
			send(request, response).status(Code.SERVER_ERROR_INTERNAL);
		}
	}
}
