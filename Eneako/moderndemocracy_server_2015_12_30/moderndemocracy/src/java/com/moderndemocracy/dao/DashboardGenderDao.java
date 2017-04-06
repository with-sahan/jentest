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
import com.moderndemocracy.pojo.DashboardGender;

public class DashboardGenderDao {
	

	protected static final Logger logger = LogManager.getLogger(DashboardGenderDao.class);

	protected static final String UNKNOWN = "unknown";
	protected static final String MALE = "male";
	protected static final String FEMALE = "female";
	
	/********/
	/* SQL */
	/******/
	private static final String SQL_SELECT_DOWNLOADS = DashboardAgeExtractor.SQL +
			"from track_install "+
			"where created_on >= ? and created_on <= ? and " +
			"council_id=? ";
	
	private static final String SQL_SELECT_USERS = DashboardTotalExtractor.SQL +
			"from users " +
			"where gender=? and "+
			"updated_on >= ? and updated_on < ? and " +
			"users.role_id=1 and " +
			"council_id=? ";
	
	private static final String SQL_SELECT_REGISTRATIONS = DashboardTotalExtractor.SQL +
			"from track_register t, users " +
			"where t.user_id=users.id and users.gender=? and "+
			"users.role_id=1 and " +
			"t.created_on >= ? and t.created_on < ? and " +
			"t.council_id=? ";
	
	private static final String SQL_SELECT_SOCIALSHARES = DashboardTotalExtractor.SQL +
			"from track_socialnetwork t, users " +
			"where t.user_id=users.id and users.gender=? and "+
			"users.role_id=1 and " +
			"t.created_on >= ? and t.created_on < ? and " +
			"t.council_id=? ";
	
	private DataSource pool;

	/**
	 * Constructor.
	 * 
	 * @param pool
	 *            The datasource.
	 */
	public DashboardGenderDao(DataSource pool) {
		if (null == pool)
			throw new AnaekoRuntimeException(
					"Cannot create a DAO without a database connection");
		this.pool = pool;
	}

	
	/**
	 * Get Gender info on Downloads
	 * 
	 * @param start
	 * @param end
	 * @return
	 * @throws SQLException
	 */
	public List<DashboardGender> getDownloads(
			final Integer councilId,
			final Timestamp start,
			final Timestamp end) throws SQLException {
		
		List<DashboardGender> dashboardGenders = getKnownGenderUsers(councilId,start,end);
		
		// Sum up all the known Signup
		Integer knownDownloadsCount = 0;
		for (DashboardGender dashboardGender : dashboardGenders) {
			knownDownloadsCount += dashboardGender.getTotal();
		}
		logger.debug("Total known gender users = "+knownDownloadsCount);
		
		CacheableQuery<DashboardGender> query = new CacheableQuery<DashboardGender>(pool);
		
		List<DashboardGender> found = query.execute(SQL_SELECT_DOWNLOADS, 
				new DashboardGenderExtractor(), new ParameterDelegate() {
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
				
				logger.debug("Total download count = "+found.get(0).getTotal());
				
				// Update data based on known downloads count
				found.get(0).setGender(UNKNOWN);
				found.get(0).setTotal(found.get(0).getTotal()-knownDownloadsCount);
				
				dashboardGenders.add(found.get(0));
			}
			else {
				// Update data based with zero unknown count
				found.get(0).setGender(UNKNOWN);
				found.get(0).setTotal(0);
				
				dashboardGenders.add(found.get(0));
			}
		}
		
		return dashboardGenders;
	}
	
	private List<DashboardGender> getKnownGenderUsers(
			final Integer councilId,
			final Timestamp start, 
			final Timestamp end) throws SQLException {
		
		List<DashboardGender> dashboardGenders = new ArrayList<DashboardGender>();
		
		dashboardGenders.add(getUsers(councilId,MALE,start,end));
		dashboardGenders.add(getUsers(councilId,FEMALE,start,end));
		
		return dashboardGenders;
	}
	
	/**
	 * Get Gender info on Users
	 * 
	 * @param start
	 * @param end
	 * @return
	 * @throws SQLException
	 */
	public List<DashboardGender> getUsers(
			final Integer councilId,
			final Timestamp start, 
			final Timestamp end) throws SQLException {
		
		List<DashboardGender> dashboardGenders = new ArrayList<DashboardGender>();
		
		dashboardGenders.add(getUsers(councilId,MALE,start,end));
		dashboardGenders.add(getUsers(councilId,FEMALE,start,end));
		dashboardGenders.add(getUsers(councilId,UNKNOWN,start,end));
		
		return dashboardGenders;
	}
	
	private DashboardGender getUsers(
			final Integer councilId,
			final String gender,
			final Timestamp start, 
			final Timestamp end) throws SQLException {
		
		CacheableQuery<DashboardGender> query = new CacheableQuery<DashboardGender>(pool);
		
		List<DashboardGender> found = query.execute(SQL_SELECT_USERS, 
				new DashboardGenderExtractor(), new ParameterDelegate() {
			@Override
			public void setParameters(PreparedStatement statement) throws SQLException {
				statement.setString(1, gender);
				statement.setTimestamp(2, start);
				statement.setTimestamp(3, end);
				statement.setInt(4, councilId);
			}
		});
		
		
		if (found.isEmpty()) {
			return null;
		} else {
			found.get(0).setGender(gender);
			return found.get(0);
		}
	}
	
	/**
	 * Get Gender info on Registrations
	 * 
	 * @param start
	 * @param end
	 * @return
	 * @throws SQLException
	 */
	public List<DashboardGender> getRegistrations(
			final Integer councilId,
			final Timestamp start, 
			final Timestamp end) throws SQLException {
		
		List<DashboardGender> dashboardGenders = new ArrayList<DashboardGender>();
		
		dashboardGenders.add(getRegistrations(councilId,MALE,start,end));
		dashboardGenders.add(getRegistrations(councilId,FEMALE,start,end));
		dashboardGenders.add(getRegistrations(councilId,UNKNOWN,start,end));
		
		return dashboardGenders;
	}
	
	private DashboardGender getRegistrations(
			final Integer councilId,
			final String gender,
			final Timestamp start, 
			final Timestamp end) throws SQLException {
		
		CacheableQuery<DashboardGender> query = new CacheableQuery<DashboardGender>(pool);
		
		List<DashboardGender> found = query.execute(SQL_SELECT_REGISTRATIONS, 
				new DashboardGenderExtractor(), new ParameterDelegate() {
			@Override
			public void setParameters(PreparedStatement statement) throws SQLException {
				statement.setString(1, gender);
				statement.setTimestamp(2, start);
				statement.setTimestamp(3, end);
				statement.setInt(4, councilId);
			}
		});
		
		
		if (found.isEmpty()) {
			return null;
		} else {
			found.get(0).setGender(gender);
			return found.get(0);
		}
	}
	
	
	/**
	 * Get Gender info on Socialshares
	 * 
	 * @param start
	 * @param end
	 * @return
	 * @throws SQLException
	 */
	public List<DashboardGender> getSocialshares(
			final Integer councilId,
			final Timestamp start, 
			final Timestamp end) throws SQLException {
		
		List<DashboardGender> dashboardGenders = new ArrayList<DashboardGender>();
		
		dashboardGenders.add(getSocialshares(councilId,MALE,start,end));
		dashboardGenders.add(getSocialshares(councilId,FEMALE,start,end));
		dashboardGenders.add(getSocialshares(councilId,UNKNOWN,start,end));
		
		return dashboardGenders;
	}
	
	private DashboardGender getSocialshares(
			final Integer councilId,
			final String gender,
			final Timestamp start, 
			final Timestamp end) throws SQLException {
		
		CacheableQuery<DashboardGender> query = new CacheableQuery<DashboardGender>(pool);
		
		List<DashboardGender> found = query.execute(SQL_SELECT_SOCIALSHARES, 
				new DashboardGenderExtractor(), new ParameterDelegate() {
			@Override
			public void setParameters(PreparedStatement statement) throws SQLException {
				statement.setString(1, gender);
				statement.setTimestamp(2, start);
				statement.setTimestamp(3, end);
				statement.setInt(4,councilId);
			}
		});
		
		
		if (found.isEmpty()) {
			return null;
		} else {
			found.get(0).setGender(gender);
			return found.get(0);
		}
	}
	
}
