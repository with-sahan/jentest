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
import com.moderndemocracy.pojo.Station;

public class StationDao {
	

	protected static final Logger logger = LogManager.getLogger(StationDao.class);


	/********/
	/* SQL */
	/******/
	private static final String SQL_SELECT_BY_PLACE_ID = StationExtractor.SQL
			+ "WHERE S.polling_place_id=? and "
			+ "SSS.station_id=S.id and SSS.station_setup_list_id=1 "
			+ "ORDER by name";
	
	private static final String SQL_SELECT_BY_ID = StationExtractor.SQL
			+ "WHERE S.id=? and "
			+ "SSS.station_id=S.id and SSS.station_setup_list_id=1 "
			+ "ORDER by name";
	
	private DataSource pool;

	/**
	 * Constructor.
	 * 
	 * @param pool
	 *            The datasource.
	 */
	public StationDao(DataSource pool) {
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
	public List<Station> getStationByPlaceId(final int placeId) throws SQLException {
		
		CacheableQuery<Station> query = new CacheableQuery<Station>(pool);
	
		logger.debug("GetStationByPlaceId("+placeId+")");
		
		List<Station> found = query.execute(SQL_SELECT_BY_PLACE_ID,
				new StationExtractor(), new ParameterDelegate() {
					@Override
					public void setParameters(PreparedStatement statement) throws SQLException {
						statement.setInt(1, placeId);
					}
				});
		
		if (found.isEmpty()) {
			return null;
		} else {
			return found;
		}
	}
	
	public Station getStationById(final int stationId) throws SQLException {
		
		CacheableQuery<Station> query = new CacheableQuery<Station>(pool);
	
		logger.debug("GetStationById("+stationId+")");
		
		List<Station> found = query.execute(SQL_SELECT_BY_ID,
				new StationExtractor(), new ParameterDelegate() {
					@Override
					public void setParameters(PreparedStatement statement) throws SQLException {
						statement.setInt(1, stationId);
					}
				});
		
		if (found.isEmpty()) {
			return null;
		} else {
			return found.get(0);
		}
	}
}
