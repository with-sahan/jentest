package com.moderndemocracy.jetty.handler;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.anaeko.utils.http.Code;
import com.anaeko.utils.io.MarshalerException;
import com.moderndemocracy.dao.RegistersDao;
import com.moderndemocracy.dao.UsersDao;
import com.moderndemocracy.pojo.AuthenticatedUser;
import com.moderndemocracy.pojo.Registers;
import com.moderndemocracy.pojo.User;

public class RegistersHandler extends ModernDemocracyHandler {

	private static final Logger logger = Logger.getLogger(RegistersHandler.class);

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
			RegistersDao registersDao = new RegistersDao(getDataSource());
						
			// Get user info by sessionId
			String id = read(request).sessionId();
			AuthenticatedUser currentUser = (AuthenticatedUser)getServiceContext().getUser(id);
			User user = userDao.getById(currentUser.getId());
			
			// Get Registers by Council Id
			List<Registers> registers = registersDao.getRegistersByCouncilId(user.getCouncilId());
			logger.debug("GET Registers =" + registers);
			
			// Return registers for specific council to client
			send(request, response).json(registers);
			
		} catch (Exception e) {
			logger.error("Unexpected Exception", e);
			send(request, response).status(Code.SERVER_ERROR_INTERNAL);
		}
	}

}
