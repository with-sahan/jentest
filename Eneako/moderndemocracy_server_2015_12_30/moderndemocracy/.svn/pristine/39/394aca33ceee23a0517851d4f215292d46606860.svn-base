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
import com.moderndemocracy.pojo.District;

public class DistrictDao {
	

	protected static final Logger logger = LogManager.getLogger(DistrictDao.class);


	/********/
	/* SQL */
	/******/
	private static final String SQL_SELECT_BY_WARD_ID = DistrictExtractor.SQL
			+ "WHERE PD.polling_ward_id=? "
			+ "ORDER by PD.name";
	
	private DataSource pool;

	/**
	 * Constructor.
	 * 
	 * @param pool
	 *            The datasource.
	 */
	public DistrictDao(DataSource pool) {
		if (null == pool)
			throw new AnaekoRuntimeException(
					"Cannot create a DAO without a database connection");
		this.pool = pool;
	}


	/**
	 * 
	 * @param wardId
	 * @return
	 * @throws SQLException
	 */
	public List<District> getDistrictByWardId(final int wardId) throws SQLException {
		
		CacheableQuery<District> query = new CacheableQuery<District>(pool);
	
		logger.debug("GetDistrictByWardId("+wardId+")");
		
		List<District> found = query.execute(SQL_SELECT_BY_WARD_ID,
				new DistrictExtractor(), new ParameterDelegate() {
					@Override
					public void setParameters(PreparedStatement statement) throws SQLException {
						statement.setInt(1, wardId);
					}
				});
		
		if (found.isEmpty()) {
			return null;
		} else {
			return found;
		}
	}
}
