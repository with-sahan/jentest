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
import com.moderndemocracy.pojo.StationSetupList;

public class StationSetupListDao {
	

	protected static final Logger logger = LogManager.getLogger(StationSetupListDao.class);


	/********/
	/* SQL */
	/******/
	private static final String SQL_SELECT_STATION_SETUP_ITEMS_BY_COUNCIL_ID = 
			StationSetupListExtractor.SQL
			+ "WHERE council_id=? "
			+ "ORDER by S.order_id";
	
	private DataSource pool;

	/**
	 * Constructor.
	 * 
	 * @param pool
	 *            The datasource.
	 */
	public StationSetupListDao(DataSource pool) {
		if (null == pool)
			throw new AnaekoRuntimeException(
					"Cannot create a DAO without a database connection");
		this.pool = pool;
	}

	/**
	 * Get All Station Setup item
	 * 
	 * @return
	 * @throws SQLException
	 */
	public List<StationSetupList> getByCouncilId(final Integer councilId) throws SQLException {
		
		CacheableQuery<StationSetupList> query = new CacheableQuery<StationSetupList>(pool);
	
		List<StationSetupList> found = query.execute(SQL_SELECT_STATION_SETUP_ITEMS_BY_COUNCIL_ID,
				new StationSetupListExtractor(), new ParameterDelegate() {
					@Override
					public void setParameters(PreparedStatement statement)
							throws SQLException {
						
						statement.setInt(1,  councilId);
					}
				});
		
		
		if (found.isEmpty()) {
			return null;
		} else {
			return found;
		}
	}
	
}
