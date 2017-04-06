package com.moderndemocracy.jetty;

import java.util.concurrent.TimeUnit;

import org.apache.http.client.HttpClient;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.protocol.HttpContext;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.anaeko.jetty.SecuredService;
import com.anaeko.service.http.ProvidesHttpClient;
import com.anaeko.service.http.ReusableClient;
import com.anaeko.utils.app.Configuration;
import com.anaeko.utils.app.ConfigurationException;

/**
 * An REST HTTP service class that extends the base Jetty Service class, adding
 * only what is necessary to simplify common SLAMMER code, specifically the
 * deployment of URL handlers.
 * 
 */
public class ModernDemocracyService extends SecuredService implements
		ProvidesHttpClient {

	private static final Logger logger = LogManager
			.getLogger(ModernDemocracyService.class);

	/**
	 * default
	 */
	private static final long serialVersionUID = 1L;

	private ReusableClient client;

	/**
	 * @param config
	 * @throws ConfigurationException
	 */
	public ModernDemocracyService(Configuration config)
			throws ConfigurationException {
		super(config);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.anaeko.jetty.SecuredService#initialiseSessionContext()
	 */
	@Override
	protected void initialiseSessionContext() throws ConfigurationException {
		logger.info("Initialise ProProject Context for [" + getName()
				+ "] at URI[" + getRootURI() + "]");

		ModernDemocracyContext ProProjectContext = new ModernDemocracyContext(this);
		ProProjectContext.initialise();
		this.sessionContext = ProProjectContext;

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.anaeko.service.http.ProvidesHttpClient#getHttpClient()
	 */
	@Override
	public HttpClient getHttpClient() {
		return client.getHttpClient();
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.anaeko.service.http.ProvidesHttpClient#setHttpClient(org.apache.http
	 * .client.HttpClient)
	 */
	@Override
	public void setHttpClient(CloseableHttpClient httpClient) {
		client.setHttpClient(httpClient);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.anaeko.service.http.ProvidesHttpClient#getHttpContext(java.lang.String
	 * )
	 */
	@Override
	public HttpContext getHttpContext(String url) {
		return client.getHttpContext(url);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.anaeko.service.http.ProvidesHttpClient#setHttpContext(java.lang.String
	 * , com.anaeko.service.http.RequestContext)
	 */
	@Override
	public void setHttpContext(String url, HttpContext context) {
		client.setHttpContext(url, context);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.anaeko.service.http.ProvidesHttpClient#clearHttpContext(java.lang
	 * .String)
	 */
	@Override
	public HttpContext clearHttpContext(String url) {
		return client.clearHttpContext(url);
	}

	/**
	 * @return a shared HTTP client resource
	 */
	public ProvidesHttpClient getClient() {
		return this.client;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.anaeko.service.http.ProvidesHttpClient#cachedHttpResponse(java.lang
	 * .String)
	 */
	public Object cachedHttpResponse(String key) {
		return client.cachedHttpResponse(key);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.anaeko.service.http.ProvidesHttpClient#cacheHttpResponse(java.lang
	 * .String, java.lang.Object, long, java.util.concurrent.TimeUnit)
	 */
	public void cacheHttpResponse(String key, Object data, long lifespan,
			TimeUnit units) {
		client.cacheHttpResponse(key, data, lifespan, units);
	}

	@Override
	public HttpClient getHttpClient(boolean arg0) {
		// TODO Auto-generated method stub
		return null;
	}

}
