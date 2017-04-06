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
import com.moderndemocracy.pojo.Settings;

public class SettingsDao {
	

	protected static final Logger logger = LogManager.getLogger(SettingsDao.class);

	
	/********/
	/* SQL */
	/******/
	private static final String SQL_SELECT_BY_COUNCIL_ID = SettingsExtractor.SQL
			+ " WHERE council_id=? ";
	
	private DataSource pool;

	/**
	 * Constructor.
	 * 
	 * @param pool
	 *            The datasource.
	 */
	public SettingsDao(DataSource pool) {
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
	public List<Settings> getSettingsByCouncilId(final int councilId) throws SQLException {
		
		CacheableQuery<Settings> query = new CacheableQuery<Settings>(pool);
		
		List<Settings> found = query.execute(SQL_SELECT_BY_COUNCIL_ID,
				new SettingsExtractor(), new ParameterDelegate() {
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
