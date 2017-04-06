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
import com.moderndemocracy.pojo.Ward;

public class WardsDao {
	

	protected static final Logger logger = LogManager.getLogger(WardsDao.class);


	/********/
	/* SQL */
	/******/
	private static final String SQL_SELECT_BY_COUNCIL_ID = WardsExtractor.SQL +
			" where W.council_id=? "
			+ "order by W.name";
	
	private static final String SQL_SELECT_BY_COUNCIL_ID_AND_USER_ID = WardsExtractor.SQL +
			", user_ward UW "
			+ " where W.council_id=? "
			+ " and UW.user_id=? "
			+ " and UW.ward_id=W.id "
			+ " order by W.name";
	
	private DataSource pool;

	/**
	 * Constructor.
	 * 
	 * @param pool
	 *            The datasource.
	 */
	public WardsDao(DataSource pool) {
		if (null == pool)
			throw new AnaekoRuntimeException(
					"Cannot create a DAO without a database connection");
		this.pool = pool;
	}


	/**
	 * 
	 * @return
	 * @throws SQLException
	 */
	public List<Ward> getByCouncilId(final Integer councilId) throws SQLException {
		CacheableQuery<Ward> query = new CacheableQuery<Ward>(pool);
	
		List<Ward> found = query.execute(SQL_SELECT_BY_COUNCIL_ID,
				new WardsExtractor(), new ParameterDelegate() {
					@Override
					public void setParameters(PreparedStatement statement)
							throws SQLException {
						statement.setInt(1, councilId);
					}
				});
		
		if (found.isEmpty()) {
			return null;
		} else {
			return found;
		}
	}
	
	/**
	 * 
	 * @param councilId
	 * @return
	 * @throws SQLException
	 */
	public List<Ward> getByCouncilIdAndUserId(final Integer councilId, final Integer userId) throws SQLException {
		CacheableQuery<Ward> query = new CacheableQuery<Ward>(pool);
	
		List<Ward> found = query.execute(SQL_SELECT_BY_COUNCIL_ID_AND_USER_ID,
				new WardsExtractor(), new ParameterDelegate() {
					@Override
					public void setParameters(PreparedStatement statement)
							throws SQLException {
						statement.setInt(1, councilId);
						statement.setInt(2, userId);
					}
				});
		
		if (found.isEmpty()) {
			return null;
		} else {
			return found;
		}
	}
	
}
