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
import com.moderndemocracy.pojo.Events;

public class EventsDao {
	

	protected static final Logger logger = LogManager.getLogger(EventsDao.class);
	
	private final Integer USERS_ROLE  = 1;


	/********/
	/* SQL */
	/******/
	private static final String SQL_SELECT_BY_COUNCIL_ID_FOR_USERS = EventsExtractor.SQL
			+ " WHERE council_id=? "
			+ " and publish_date <= CURRENT_TIMESTAMP "
			+ " and status>0 and status<=? "
			+ " ORDER by display_date";
	
	private static final String SQL_SELECT_BY_COUNCIL_ID_FOR_TESTERS = EventsExtractor.SQL
			+ " WHERE council_id=? "
			+ " and status>0 and status<=? "
			+ " ORDER by display_date";
	
	private DataSource pool;

	/**
	 * Constructor.
	 * 
	 * @param pool
	 *            The datasource.
	 */
	public EventsDao(DataSource pool) {
		if (null == pool)
			throw new AnaekoRuntimeException(
					"Cannot create a DAO without a database connection");
		this.pool = pool;
	}


	/**
	 * Get Events By Council Id
	 * 
	 * @param councilId
	 * @return
	 * @throws SQLException
	 */
	public List<Events> getEventsByCouncilId(final int councilId, final int roleId) throws SQLException {
		
		CacheableQuery<Events> query = new CacheableQuery<Events>(pool);
		
		String SQL_SELECT_BY_COUNCIL_ID = SQL_SELECT_BY_COUNCIL_ID_FOR_USERS;
		if (roleId != USERS_ROLE) {
			SQL_SELECT_BY_COUNCIL_ID = SQL_SELECT_BY_COUNCIL_ID_FOR_TESTERS;
		}
	
		List<Events> found = query.execute(SQL_SELECT_BY_COUNCIL_ID,
				new EventsExtractor(), new ParameterDelegate() {
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
