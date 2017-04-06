package com.moderndemocracy.dao;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.anaeko.error.AnaekoRuntimeException;
import com.anaeko.utils.jdbc.CacheableQuery;
import com.anaeko.utils.jdbc.ParameterDelegate;
import com.moderndemocracy.pojo.News;

public class NewsDao {
	

	protected static final Logger logger = LogManager.getLogger(NewsDao.class);

	private final Integer USERS_ROLE  = 1;

	
	/********/
	/* SQL */
	/******/
	private static final String SQL_SELECT_BY_COUNCIL_ID_FOR_USERS = NewsExtractor.SQL
			+ " WHERE council_id=? "
			+ " and publish_date <= CURRENT_TIMESTAMP "
			+ " and status>0 and status<=? "
			+ " ORDER by publish_date desc";
	
	private static final String SQL_SELECT_BY_COUNCIL_ID_FOR_TESTERS = NewsExtractor.SQL
			+ " WHERE council_id=? "
			+ " and status>0 and status<=? "
			+ " ORDER by publish_date desc";
	
	private DataSource pool;

	/**
	 * Constructor.
	 * 
	 * @param pool
	 *            The datasource.
	 */
	public NewsDao(DataSource pool) {
		if (null == pool)
			throw new AnaekoRuntimeException(
					"Cannot create a DAO without a database connection");
		this.pool = pool;
	}


	/**
	 * Get News By Council Id
	 * 
	 * @param councilId
	 * @return
	 * @throws SQLException
	 */
	public List<News> getNewsByCouncilId(final int councilId, final int roleId) throws SQLException {
		
		CacheableQuery<News> query = new CacheableQuery<News>(pool);
	
		String SQL_SELECT_BY_COUNCIL_ID = SQL_SELECT_BY_COUNCIL_ID_FOR_USERS;
		if (roleId != USERS_ROLE) {
			SQL_SELECT_BY_COUNCIL_ID = SQL_SELECT_BY_COUNCIL_ID_FOR_TESTERS;
		}
		
		List<News> found = query.execute(SQL_SELECT_BY_COUNCIL_ID,
				new NewsExtractor(), new ParameterDelegate() {
					@Override
					public void setParameters(PreparedStatement statement) throws SQLException {
						statement.setInt(1, councilId);
						statement.setInt(2, roleId);
					}
				});
		
		if (found.isEmpty()) {
			return null;
		} else {
			return found;
		}
	}
}
