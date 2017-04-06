package com.moderndemocracy.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

import com.anaeko.utils.jdbc.ResultExtractor;
import com.moderndemocracy.pojo.AuthenticatedUser;

/**
 * User Extractor.
 */
public class AuthenticatedUsersExtractor implements
		ResultExtractor<AuthenticatedUser> {

	/** Custom SELECT query. */
	public static final String SQL = 
			"SELECT U.id, " +
			"U.login_name, U.created_on, U.updated_on, " +
			"U.secret, U.api_key, U.encryption, " +
			"U.locale, U.uri, U.role_id, " +
			"U.login_count, R.bitMask, R.title, PS.name as pollingstationname, PP.id as pollingplaceid, PP.name as pollingplacename, PD.name as pollingdistrictname, W.name as wardname, PS.ballot_box_no as ballotBoxNumber, " +
			"U.council_id as councilId, C.title as councilName, C.logo_url, C.area_name " +
			"FROM users U , role R , ward W, polling_district PD, polling_place PP, polling_station PS, council C ";


	/** ID column index. */
	public static final int IDX_ID = 1;
	/** Login name column index. */
	public static final int IDX_USER_NAME = 2;
	/** Created on column index. */
	public static final int IDX_CREATED_ON = 3;
	/** Updated on column index. */
	public static final int IDX_UPDATED_ON = 4;
	/** Password secret column index. */
	public static final int IDX_SECRET = 5;
	/** API key column index. */
	public static final int IDX_API_KEY = 6;
	/** Encryption column index. */
	public static final int IDX_ENCRYPTION = 7;
	/** Locale column index. */
	public static final int IDX_LOCALE = 8;
	/** Home URL column index. */
	public static final int IDX_HOME_URL = 9;
	/** Role column index. */
	public static final int IDX_ROLE = 10;
	
	/** Login count column index. */
	public static final int IDX_LOGIN_COUNT = 11;

	public static final int IDX_BITMASK = 12;
	public static final int IDX_TITLE = 13;
	
	public static final int IDX_POLLING_STATION_NAME = 14;
	public static final int IDX_POLLING_PLACE_ID = 15;
	public static final int IDX_POLLING_PLACE_NAME = 16;
	public static final int IDX_POLLING_DISTRICT_NAME = 17;
	
	public static final int IDX_WARD_NAME = 18;
	
	public static final int IDX_BALLOT_BOX_NUMBER = 19;
	
	public static final int IDX_COUNCIL_ID = 20;
	public static final int IDX_COUNCIL_NAME = 21;
	public static final int IDX_COUNCIL_LOGO_URL = 22;
	public static final int IDX_COUNCIL_AREA_NAME = 23;


	/*
	 * (non-Javadoc)
	 * 
	 * @see com.anaeko.utils.jdbc.ResultExtractor#extract(java.sql.ResultSet,
	 * int)
	 */
	@Override
	public AuthenticatedUser extract(ResultSet data, int index)
			throws SQLException {
		AuthenticatedUser u = new AuthenticatedUser();

		u.setId(data.getInt(IDX_ID));
		u.setLoginName(data.getString(IDX_USER_NAME));

		u.setBitmask(data.getString(IDX_BITMASK));
		u.setTitle(data.getString(IDX_TITLE));

		Object ts = data.getObject(IDX_CREATED_ON);
		if (ts instanceof Timestamp) {
			u.setCreatedOn((Timestamp) ts);
		} else if (ts instanceof Number) {
			u.setCreatedOn(((Number) ts).longValue());
		}

		ts = data.getObject(IDX_CREATED_ON);
		if (ts instanceof Timestamp) {
			u.setUpdatedOn((Timestamp) ts);
		} else if (ts instanceof Number) {
			u.setUpdatedOn(((Number) ts).longValue());
		}

		u.setSecret(data.getString(IDX_SECRET));

		Object key = data.getObject(IDX_API_KEY);
		if (key instanceof String) {
			u.setAPIKey(key.toString());
		} else if (key instanceof byte[]) {
			u.setAPIKey((byte[]) key);
		}

		u.setEncryption(data.getString(IDX_ENCRYPTION));
		u.setLocale(data.getString(IDX_LOCALE));
		u.setHomeURL(data.getString(IDX_HOME_URL));
		u.setRole(data.getInt(IDX_ROLE));
		u.setLoginCount(data.getInt(IDX_LOGIN_COUNT));
		
		u.setPollingStationName(data.getString(IDX_POLLING_STATION_NAME));
		u.setPollingPlaceId(data.getInt(IDX_POLLING_PLACE_ID));
		u.setPollingPlaceName(data.getString(IDX_POLLING_PLACE_NAME));
		u.setPollingDistrictName(data.getString(IDX_POLLING_DISTRICT_NAME));
		
		u.setWardName(data.getString(IDX_WARD_NAME));
		
		u.setBallotBoxNo(data.getString(IDX_BALLOT_BOX_NUMBER));
		
		u.setCouncilId(data.getInt(IDX_COUNCIL_ID));
		u.setCouncilName(data.getString(IDX_COUNCIL_NAME));
		u.setCouncilLogoUrl(data.getString(IDX_COUNCIL_LOGO_URL));
		u.setAreaName(data.getString(IDX_COUNCIL_AREA_NAME));

		return u;
	}

}
