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
import com.moderndemocracy.pojo.IssueList;

public class IssueListDao {
	

	protected static final Logger logger = LogManager.getLogger(IssueListDao.class);


	/********/
	/* SQL */
	/******/
	private static final String SQL_SELECT_BY_COUNCIL_ID = 
			IssueListExtractor.SQL
			+ "WHERE council_id=? and status=true "
			+ "ORDER by I.order_id";
	
	private DataSource pool;

	/**
	 * Constructor.
	 * 
	 * @param pool
	 *            The datasource.
	 */
	public IssueListDao(DataSource pool) {
		if (null == pool)
			throw new AnaekoRuntimeException(
					"Cannot create a DAO without a database connection");
		this.pool = pool;
	}

	/**
	 * Get All IsseuList item
	 * 
	 * @return
	 * @throws SQLException
	 */
	public List<IssueList> getByCouncilId(final Integer councilId) throws SQLException {
		CacheableQuery<IssueList> query = new CacheableQuery<IssueList>(pool);
	
		List<IssueList> found = query.execute(SQL_SELECT_BY_COUNCIL_ID,
				new IssueListExtractor(), new ParameterDelegate() {
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
	
}
