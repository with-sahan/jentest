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
import com.moderndemocracy.pojo.PollingStation;

public class PollingStationDao {


	protected static final Logger logger = LogManager.getLogger(PollingStationDao.class);


	/********/
	/* SQL */
	/******/
	private static final String SQL_SELECT_BY_POLLING_PLACE = PollingStationExtractor.SQL
			+ " WHERE PS.polling_place_id=? order by name";

//	private static final String SQL_SELECT_BY_USER_ID = PollingStationExtractor.SQL
//			+ " , user_station US"
//			+ " WHERE PS.id=US.station_id and "
//			+ " US.user_id=? order by name";

	private static final String SQL_SELECT_BY_USER_ID = PollingStationExtractor.SQL
			+ " , user_station US"
			+ " WHERE "
			+ " PS.polling_place_id=PP.id and "
			+ " PP.polling_district_id=PD.id and "
			+ " PD.polling_ward_id=W.id and "
			+ " W.council_id=C.id and "
			+ " PS.id=US.station_id and "
			+ " SS.station_id=PS.id and SS.station_setup_list_id = 1 and"
			+ " US.user_id=? order by name";

	private DataSource pool;

	/**
	 * Constructor.
	 *
	 * @param pool
	 *            The datasource.
	 */
	public PollingStationDao(DataSource pool) {
		if (null == pool)
			throw new AnaekoRuntimeException(
					"Cannot create a DAO without a database connection");
		this.pool = pool;
	}


	public List<PollingStation> getByPollingPlaceId(final int pollingPlaceId) throws SQLException {

		CacheableQuery<PollingStation> query = new CacheableQuery<PollingStation>(pool);

		List<PollingStation> found = query.execute(SQL_SELECT_BY_POLLING_PLACE,
				new PollingStationExtractor(), new ParameterDelegate() {
					@Override
					public void setParameters(PreparedStatement statement) throws SQLException {
						statement.setInt(1, pollingPlaceId);
					}
				});

		if (found.isEmpty()) {
			return null;
		} else {
			return found;
		}
	}

	public List<PollingStation> getByUserId(final int userId) throws SQLException {

		CacheableQuery<PollingStation> query = new CacheableQuery<PollingStation>(pool);

		List<PollingStation> found = query.execute(SQL_SELECT_BY_USER_ID,
				new PollingStationExtractor(), new ParameterDelegate() {
					@Override
					public void setParameters(PreparedStatement statement) throws SQLException {
						statement.setInt(1, userId);
					}
				});

		if (found.isEmpty()) {
			return null;
		} else {
			return found;
		}
	}
}
