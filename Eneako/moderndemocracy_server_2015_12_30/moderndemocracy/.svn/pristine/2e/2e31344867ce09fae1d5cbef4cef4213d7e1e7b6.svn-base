package com.moderndemocracy.dao;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.anaeko.error.AnaekoRuntimeException;
import com.anaeko.utils.jdbc.CacheableQuery;
import com.anaeko.utils.jdbc.ParameterDelegate;
import com.moderndemocracy.pojo.DashboardAge;

public class DashboardAgeDao {
	

	protected static final Logger logger = LogManager.getLogger(DashboardAgeDao.class);

	private Integer[] intervalRange = {1,16,25,35,55,75,95,105};

	/********/
	/* SQL */
	/******/
	
	private static final String SQL_SELECT_DOWNLOADS = DashboardAgeExtractor.SQL +
			"from track_install " +
			"where created_on >= ? and created_on <= ? and " +
			"council_id=? ";
	
	private static final String SQL_SELECT_USERS = DashboardAgeExtractor.SQL +
			"from users " +
			"where users.age >= ? and users.age <= ? and " +
			"users.updated_on >= ? and users.updated_on <= ? and " +
			"users.role_id=1 and " +
			"council_id=? ";
	
	private static final String SQL_SELECT_REGISTRATIONS = DashboardAgeExtractor.SQL +
			"from track_register t, users " +
			"where t.user_id=users.id and users.age >= ? and users.age <= ? and " +
			"users.role_id=1 and " +
			"t.created_on >= ? and t.created_on <= ? and " +
			"t.council_id=? ";
	
	private static final String SQL_SELECT_SOCIALSHARES = DashboardAgeExtractor.SQL +
			"from track_socialnetwork t, users " +
			"where t.user_id=users.id and users.age >= ? and users.age <= ? and " +
			"users.role_id=1 and " +
			"t.created_on >= ? and t.created_on <= ? and " +
			"t.council_id=? ";
	
	private DataSource pool;

	/**
	 * Constructor.
	 * 
	 * @param pool
	 *            The datasource.
	 */
	public DashboardAgeDao(DataSource pool) {
		if (null == pool)
			throw new AnaekoRuntimeException(
					"Cannot create a DAO without a database connection");
		this.pool = pool;
	}

	/**
	 * Get Age info on Downloads
	 * 
	 * @param start
	 * @param end
	 * @return
	 * @throws SQLException
	 */
	public List<DashboardAge> getDownloads(
			final Integer councilId,
			final Timestamp start,
			final Timestamp end) throws SQLException {
		
		List<DashboardAge> dashboardAges = getUsers(councilId, start, end);
		
		// Sum up all the known Signup
		Integer knownDownloadsCount = 0;
		for (DashboardAge dashboardAge : dashboardAges) {
			knownDownloadsCount += dashboardAge.getTotal();
		}
		
		CacheableQuery<DashboardAge> query = new CacheableQuery<DashboardAge>(pool);
		
		List<DashboardAge> found = query.execute(SQL_SELECT_DOWNLOADS, 
				new DashboardAgeExtractor(), new ParameterDelegate() {
			@Override
			public void setParameters(PreparedStatement statement) throws SQLException {
				statement.setTimestamp(1, start);
				statement.setTimestamp(2, end);
				statement.setInt(3, councilId);
			}
		});
		
		// Include Unknown Download count
		if (!found.isEmpty()) {
			
			if (found.get(0).getTotal()-knownDownloadsCount>0) {
				
				// Update data based on known downloads count
				found.get(0).setRangeStart(0);
				found.get(0).setRangeEnd(0);
				found.get(0).setTotal(found.get(0).getTotal()-knownDownloadsCount);
				
				dashboardAges.add(found.get(0));
			}
		}
		
		return dashboardAges;
	}
	
	/**
	 * Get Age info on Users
	 * 
	 * @param start
	 * @param end
	 * @return
	 * @throws SQLException
	 */
	public List<DashboardAge> getUsers(
			final Integer councilId,
			final Timestamp start, 
			final Timestamp end) throws SQLException {
		
		List<DashboardAge> dashboardAges = new ArrayList<DashboardAge>();
		
		Integer fromAge=-1;
		Integer toAge=-1;
		
		for (Integer interval : intervalRange) {
			
			if (toAge==-1) {
				toAge=interval-1;
				continue;
			}
			else {
				fromAge=toAge+1;
				toAge=interval-1;
				
				DashboardAge dashboardAge = getUsers(councilId,fromAge,toAge,start,end);
				
				dashboardAges.add(dashboardAge);
			}
		}
		
		return dashboardAges;
	}
	
	private DashboardAge getUsers(
			final Integer councilId,
			final Integer fromAge,
			final Integer toAge,
			final Timestamp start, 
			final Timestamp end) throws SQLException {
		
		CacheableQuery<DashboardAge> query = new CacheableQuery<DashboardAge>(pool);
		
		List<DashboardAge> found = query.execute(SQL_SELECT_USERS, 
				new DashboardAgeExtractor(), new ParameterDelegate() {
			@Override
			public void setParameters(PreparedStatement statement) throws SQLException {
				statement.setInt(1, fromAge);
				statement.setInt(2, toAge);
				statement.setTimestamp(3, start);
				statement.setTimestamp(4, end);
				statement.setInt(5, councilId);
			}
		});
		
		
		if (found.isEmpty()) {
			return null;
		} else {
			found.get(0).setRangeStart(fromAge);
			found.get(0).setRangeEnd(toAge);
			return found.get(0);
		}
	}
	
	
	/**
	 * Get Age info on Registrations
	 * 
	 * @param start
	 * @param end
	 * @return
	 * @throws SQLException
	 */
	public List<DashboardAge> getRegistrations(
			final Integer councilId,
			final Timestamp start, 
			final Timestamp end) throws SQLException {
		
		List<DashboardAge> dashboardAges = new ArrayList<DashboardAge>();
		
		Integer fromAge=-1;
		Integer toAge=-1;
		
		for (Integer interval : intervalRange) {
			
			if (toAge==-1) {
				toAge=interval-1;
				continue;
			}
			else {
				fromAge=toAge+1;
				toAge=interval-1;
				
				DashboardAge dashboardAge = getRegistrations(councilId,fromAge,toAge,start,end);
				
				dashboardAges.add(dashboardAge);
			}
		}
		
		return dashboardAges;
	}
	
	private DashboardAge getRegistrations(
			final Integer councilId,
			final Integer fromAge,
			final Integer toAge,
			final Timestamp start, 
			final Timestamp end) throws SQLException {
		
		CacheableQuery<DashboardAge> query = new CacheableQuery<DashboardAge>(pool);
		
		List<DashboardAge> found = query.execute(SQL_SELECT_REGISTRATIONS, 
				new DashboardAgeExtractor(), new ParameterDelegate() {
			@Override
			public void setParameters(PreparedStatement statement) throws SQLException {
				statement.setInt(1, fromAge);
				statement.setInt(2, toAge);
				statement.setTimestamp(3, start);
				statement.setTimestamp(4, end);
				statement.setInt(5,councilId);
			}
		});
		
		
		if (found.isEmpty()) {
			return null;
		} else {
			found.get(0).setRangeStart(fromAge);
			found.get(0).setRangeEnd(toAge);
			return found.get(0);
		}
	}
	
	
	/**
	 * Get Age info on Socialshares
	 * 
	 * @param start
	 * @param end
	 * @return
	 * @throws SQLException
	 */
	public List<DashboardAge> getSocialshares(
			final Integer councilId,
			final Timestamp start, 
			final Timestamp end) throws SQLException {
		
		List<DashboardAge> dashboardAges = new ArrayList<DashboardAge>();
		
		Integer fromAge=-1;
		Integer toAge=-1;
		
		for (Integer interval : intervalRange) {
			
			if (toAge==-1) {
				toAge=interval-1;
				continue;
			}
			else {
				fromAge=toAge+1;
				toAge=interval-1;
				
				DashboardAge dashboardAge = getSocialshares(councilId,fromAge,toAge,start,end);
				
				dashboardAges.add(dashboardAge);
			}
		}
		
		return dashboardAges;
	}
	
	private DashboardAge getSocialshares(
			final Integer councilId,
			final Integer fromAge,
			final Integer toAge,
			final Timestamp start, 
			final Timestamp end) throws SQLException {
		
		CacheableQuery<DashboardAge> query = new CacheableQuery<DashboardAge>(pool);
		
		List<DashboardAge> found = query.execute(SQL_SELECT_SOCIALSHARES, 
				new DashboardAgeExtractor(), new ParameterDelegate() {
			@Override
			public void setParameters(PreparedStatement statement) throws SQLException {
				statement.setInt(1, fromAge);
				statement.setInt(2, toAge);
				statement.setTimestamp(3, start);
				statement.setTimestamp(4, end);
				statement.setInt(5,councilId);
			}
		});
		
		
		if (found.isEmpty()) {
			return null;
		} else {
			found.get(0).setRangeStart(fromAge);
			found.get(0).setRangeEnd(toAge);
			return found.get(0);
		}
	}
	
}
