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
import com.moderndemocracy.pojo.Registers;

public class RegistersDao {
	

	protected static final Logger logger = LogManager.getLogger(RegistersDao.class);


	/********/
	/* SQL */
	/******/
	private static final String SQL_SELECT_BY_COUNCIL_ID = RegistersExtractor.SQL
			+ " WHERE council_id=? "
			+ " and status=1 "
			+ " ORDER by created_on desc";
	
	private DataSource pool;

	/**
	 * Constructor.
	 * 
	 * @param pool
	 *            The datasource.
	 */
	public RegistersDao(DataSource pool) {
		if (null == pool)
			throw new AnaekoRuntimeException(
					"Cannot create a DAO without a database connection");
		this.pool = pool;
	}


	/**
	 * Get Registers By Council Id
	 * 
	 * @param councilId
	 * @return
	 * @throws SQLException
	 */
	public List<Registers> getRegistersByCouncilId(final int councilId) throws SQLException {
		
		CacheableQuery<Registers> query = new CacheableQuery<Registers>(pool);
	
		List<Registers> found = query.execute(SQL_SELECT_BY_COUNCIL_ID,
				new RegistersExtractor(), new ParameterDelegate() {
					@Override
					public void setParameters(PreparedStatement statement) throws SQLException {
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
