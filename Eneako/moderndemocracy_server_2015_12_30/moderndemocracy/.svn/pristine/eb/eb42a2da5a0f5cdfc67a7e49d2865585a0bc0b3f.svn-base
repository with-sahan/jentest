package com.moderndemocracy.jetty.handler;

import static com.anaeko.jetty.HttpRequest.NaN;
import static com.anaeko.utils.uri.URIHelper.getFirstSegment;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import org.joda.time.DateTime;

import com.anaeko.jetty.handler.ChainedHandler;
import com.anaeko.service.RESTServiceContext;
import com.anaeko.service.auth.Session;
import com.anaeko.service.auth.SessionContext;
import com.anaeko.utils.app.Configuration;
import com.anaeko.utils.data.LocalDateTimeRange;
import com.anaeko.utils.http.Code;
import com.anaeko.utils.http.ErrorResponse;
import com.anaeko.utils.jdbc.error.PostgresError;
import com.anaeko.utils.text.Strings;
import com.anaeko.utils.uri.URIHelper;
import com.moderndemocracy.jetty.ModernDemocracyContext;
import com.moderndemocracy.pojo.AuthenticatedUser;

public abstract class ModernDemocracyHandler extends ChainedHandler {

	/**
	 * The name of the session id cookie
	 */
	public static final String SESSION_ID = "session";

	/** ProProject Context. */
	protected ModernDemocracyContext ProProjectContext;

	/** Configuration. */
	protected Configuration configuration;

	protected static final String DATE_TIME_RANGE_QUERY_STRING = "timerange";

	protected static final String INVALID_DATE_TIME_RANGE = "Invalid datetime range query, expected: yyyyMMddhhmm[,yyyyMMddhhmm] or -[0-9](m|h|d|w|M|y) or (thisWeek|thisMonth|...)";

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.anaeko.jetty.handler.ChainedHandler#setSessionContext(com.anaeko.
	 * service.auth.SessionContext)
	 */
	@Override
	public ChainedHandler setServiceContext(RESTServiceContext serviceContext) {
		super.setServiceContext(serviceContext);
		ProProjectContext = (ModernDemocracyContext) serviceContext;
		configuration = ProProjectContext.getConfiguration();
		return this;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.anaeko.jetty.handler.ChainedHandler#getServiceContext()
	 */
	@Override
	public SessionContext getServiceContext() {
		return (SessionContext) super.getServiceContext();
	}

	public ModernDemocracyContext getProProjectContext() {
		return ProProjectContext;
	}

	public DataSource getDataSource() {
		return getServiceContext().getDataSource();
	}

	/**
	 * Terminate a request with an appropriate error response, returning, as far
	 * as possible a useful error message.
	 * <p>
	 * The following SQL Exceptions are specifically supported 4XX errors, all
	 * others are returned as 500:
	 * <ul>
	 * <li>ER_DATA_TRUNCATION - first field name can be returned</li>
	 * <li>ER_FOREGIN_KEY_CONSTRAINT</li>
	 * <li>ER_DUP_ENTRY</li>
	 * <li>ER_NOT_NULL_CONTRAINT</li>
	 * <li>ER_MISSING_PARAM</li>
	 * </ul>
	 * 
	 * @param baseRequest
	 * @param response
	 * @param error
	 * @throws IOException
	 */
	protected void handleSQLError(HttpServletRequest baseRequest,
			HttpServletResponse response, SQLException error)
			throws IOException {
		
		String sessionId = read(baseRequest).sessionId();

		PostgresError code = PostgresError.valueOf(error);
		if (code.isInputError()) {
			logger.info(
					"{} {} :: status=400 reason={} error={} handler={} session={}",
					baseRequest.getMethod(), baseRequest.getRequestURI(), code,
					error, getClass().getSimpleName(), sessionId);

			send(baseRequest, response).json(Code.CLIENT_ERROR_BAD_REQUEST,
					code.name(),
					new ErrorResponse(error, Code.CLIENT_ERROR_BAD_REQUEST));

		} else {
			logger.warn(
					"{} {} :: status=400 reason={} error={} handler={} session={}",
					baseRequest.getMethod(), baseRequest.getRequestURI(), code,
					error, getClass().getSimpleName(), sessionId);

			send(baseRequest, response).json(Code.SERVER_ERROR_INTERNAL,
					code.name(),
					new ErrorResponse(error, Code.SERVER_ERROR_INTERNAL));
		}
	}

	/**
	 * Read the correct cookie, option for inserting validation here.
	 * 
	 * @param baseRequest
	 *            The request.
	 * @return the session id code or null.
	 */
	protected String readSessionId(HttpServletRequest baseRequest) {
		Cookie[] cookies = baseRequest.getCookies();
		if (null != cookies) {
			for (Cookie cookie : cookies) {
				if (SESSION_ID.equals(cookie.getName())) {
					if (logger.isTraceEnabled()) {
						logger.trace(baseRequest.getMethod() + " "
								+ baseRequest.getRequestURI()
								+ " :: Session Cookie " + cookie.getValue()
								+ " set");
					}
					return cookie.getValue();
				}
			}
		}
		if (logger.isTraceEnabled()) {
			logger.trace(baseRequest.getMethod() + " "
					+ baseRequest.getRequestURI()
					+ " :: Session Cookie not set");
		}
		return URIHelper.readParamFromQueryString(SESSION_ID,
				baseRequest.getQueryString(), Strings.DEFAULT_CHARACTERSET);
	}

	/**
	 * Return the Session object for the request, which includes the tenant and
	 * user identity, among other things.
	 * 
	 * @param baseRequest
	 *            The request.
	 * @return the session or null.
	 */
	protected Session getSessionForRequest(HttpServletRequest baseRequest) {

		String sessionCookie = readSessionId(baseRequest);
		if (null != sessionCookie) {
			return ProProjectContext.getSession(sessionCookie);
		}
		return null;
	}

	/**
	 * Get the currently logged in user.
	 * 
	 * @param request
	 *            The http request.
	 * @return The current user, or null if they are not logged in.
	 */
	protected AuthenticatedUser getUser(HttpServletRequest request) {
		// Get session
		Session session = getSessionForRequest(request);

		if (session != null) {
			int userID = session.getUser();
			return (AuthenticatedUser) ProProjectContext.getUser(userID);
		} else {
			return null;
		}
	}

	/**
	 * Read a URL path segment as an integer value. If the text is not an
	 * integer return NaN. If the text passed in contains more than one URL
	 * segment then assume that the first segment contains the identity; in line
	 * with the general URL pattern used in SLAMMER. If the text simply doesn't
	 * have an id - i.e. is null or an empty string then return <b>
	 * <code>null</code></b>.
	 * 
	 * @param text
	 *            a possible integer value in text form, taken from a URL path
	 * @return the id, NaN or <b><code>null</code></b>
	 */
	protected Integer readIdFromPath(String text) {
		if ((null != text) && (-1 != text.indexOf('/'))) {
			text = getFirstSegment(text);
		}
		if (null == Strings.emptyToNull(text)) {
			return null;
		}
		int id = NaN;
		if (Strings.isNumber(text)) {
			try {
				id = Integer.parseInt(text);
			} catch (NumberFormatException e) {
			}
		}
		return id;
	}

	/**
	 * Create a LocalDateTimeRange object to represent the current calendar week
	 * 
	 * @return range
	 */
	protected LocalDateTimeRange getCurrentWeekTimeRange() {
		DateTime now = new DateTime();
		int currentWeekDay = now.dayOfWeek().get();
		DateTime startOfCurrentWeek = now.minusDays(currentWeekDay);
		LocalDateTimeRange range = new LocalDateTimeRange(startOfCurrentWeek,
				now);
		return range;
	}
	
//	
//	@Override
//	protected void handleGet(String target, HttpServletRequest request,
//			HttpServletResponse response) throws MarshalerException,
//			IOException {
//		
//		response = includeMobileAppHeader(response);
//		manageGet(target, request,response);
//	}
//	
//	protected void manageGet(String target, HttpServletRequest request,
//			HttpServletResponse response) throws MarshalerException,
//			IOException {
//		
//	}
//	
//	@Override
//	protected void handlePost(String target, HttpServletRequest request,
//			HttpServletResponse response) throws IOException {
//		
//		response = includeMobileAppHeader(response);
//		managePost(target, request,response);
//	}
//	
//	protected void managePost(String target, HttpServletRequest request,
//			HttpServletResponse response) throws IOException {
//	}
//	
//	
//	@Override
//	protected void handlePut(String target, HttpServletRequest request,
//			HttpServletResponse response) throws IOException {
//		
//		response = includeMobileAppHeader(response);
//		managePut(target, request,response);
//	}
//	
//	protected void managePut(String target, HttpServletRequest request,
//			HttpServletResponse response) throws IOException {
//	}
//	
//	@Override
//	protected void handleDelete(String target, HttpServletRequest request,
//			HttpServletResponse response) throws IOException {
//		
//		response = includeMobileAppHeader(response);
//		managePut(target, request,response);
//	}
//	
//	protected void manageDelete(String target, HttpServletRequest request,
//			HttpServletResponse response) throws IOException {
//	}
//	
//	
//	protected HttpServletResponse includeMobileAppHeader(HttpServletResponse response) {
//		
//		String mobileTest = configuration.getProperty("mobile.test");
//		String mobileDomain = configuration.getProperty("mobile.testdomain");
//		
//		logger.debug("MobileApp header: mobileTest="+mobileTest+", mobileDomian="+mobileDomain);
//		
//		if(mobileTest.equals("true")) {
//			
//			response.setHeader("Access-Control-Allow-Origin", mobileDomain);
//			response.setHeader("Access-Control-Allow-Credentials", "true");
//		}
//		
//		return response;
//	}

}
