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
import com.moderndemocracy.pojo.Candidates;

public class CandidatesDao {
	

	protected static final Logger logger = LogManager.getLogger(CandidatesDao.class);

	private final Integer USERS_ROLE  = 1;

	/********/
	/* SQL */
	/******/
	private static final String SQL_SELECT_BY_COUNCIL_ID_FOR_USERS = CandidatesExtractor.SQL
			+ "WHERE fc.ward_id=w.id "
			+ " and w.council_id=c.id "
			+ " and fc.council_id=? "
			+ " and publish_date <= CURRENT_TIMESTAMP "
			+ " and fc.status>0 and fc.status<=? "
			+ " ORDER by w.name,fc.title";
			
	private static final String SQL_SELECT_BY_COUNCIL_ID_FOR_TESTERS = CandidatesExtractor.SQL
			+ " WHERE fc.ward_id=w.id "
			+ " and w.council_id=c.id "
			+ " and fc.council_id=? "
			+ " and fc.status>0 and fc.status<=? "
			+ " ORDER by w.name,fc.title";
	
	private DataSource pool;

	/**
	 * Constructor.
	 * 
	 * @param pool
	 *            The datasource.
	 */
	public CandidatesDao(DataSource pool) {
		if (null == pool)
			throw new AnaekoRuntimeException(
					"Cannot create a DAO without a database connection");
		this.pool = pool;
	}


	/**
	 * Get Candidates By Council Id
	 * 
	 * @param councilId
	 * @return
	 * @throws SQLException
	 */
	public List<Candidates> getCandidatesByCouncilId(final int councilId, final int roleId) throws SQLException {
		
		CacheableQuery<Candidates> query = new CacheableQuery<Candidates>(pool);
	
		String SQL_SELECT_BY_COUNCIL_ID = SQL_SELECT_BY_COUNCIL_ID_FOR_USERS;
		if (roleId != USERS_ROLE) {
			SQL_SELECT_BY_COUNCIL_ID = SQL_SELECT_BY_COUNCIL_ID_FOR_TESTERS;
		}
		
		List<Candidates> found = query.execute(SQL_SELECT_BY_COUNCIL_ID,
				new CandidatesExtractor(), new ParameterDelegate() {
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
