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
import com.moderndemocracy.pojo.Place;

public class PlaceDao {
	

	protected static final Logger logger = LogManager.getLogger(PlaceDao.class);


	/********/
	/* SQL */
	/******/
	private static final String SQL_SELECT_BY_DISTRICT_ID = PlaceExtractor.SQL
			+ "WHERE PP.polling_district_id=? "
			+ "ORDER by PP.name";
	
	private DataSource pool;

	/**
	 * Constructor.
	 * 
	 * @param pool
	 *            The datasource.
	 */
	public PlaceDao(DataSource pool) {
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
	public List<Place> getPlaceByDistrictId(final int districtId) throws SQLException {
		
		CacheableQuery<Place> query = new CacheableQuery<Place>(pool);
	
		logger.debug("GetPlaceByDistrictId("+districtId+")");
		
		List<Place> found = query.execute(SQL_SELECT_BY_DISTRICT_ID,
				new PlaceExtractor(), new ParameterDelegate() {
					@Override
					public void setParameters(PreparedStatement statement) throws SQLException {
						statement.setInt(1, districtId);
					}
				});
		
		if (found.isEmpty()) {
			return null;
		} else {
			return found;
		}
	}
}
