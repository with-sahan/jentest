package com.moderndemocracy.pojo;

import java.io.IOException;
import java.util.List;

import com.anaeko.service.auth.DefaultUser;
import com.anaeko.utils.data.mime.json.DefaultJsonMarshaler;
import com.anaeko.utils.io.MarshalerException;
import com.anaeko.utils.json.JsonMarshaler;
import com.anaeko.utils.json.JsonWriter;
import com.moderndemocracy.json.PollingStationMarshaler;

/**
 * ProProject user. Extended from the Default user to add other fields.
 * 
 **/

public class AuthenticatedUser extends DefaultUser {

	/** Admin role. */
	public static final int ROLE_ADMIN = 1;

	/** Standard User role. */
	public static final int ROLE_USER = 2;

	/** Read-only User role. */
	public static final int ROLE_READ_ONLY_USER = 3;

	/** Session Timeout - 8 hours. */
	private static final int SESSION_TIMEOUT = 43200; // 30 days = 720 hours
	

	private String bitmask;
	private String title;
	
	private String councilLogoUrl;
	private String areaName;
	
	private String pollingStationName;
	private String pollingPlaceName;
	private String pollingDistrictName;
	
	private int pollingPlaceId;
	
	private List<PollingStation> pollingStations;
	
	private String wardName;
	private String ballotBoxNo;
	
	private int councilId;
	private String councilName;


	/**
	 * Default constructor.
	 * <p>
	 * Set the session timeout to SESSION_TIMEOUT.
	 */
	public AuthenticatedUser() {
		super();
		setSessionTimeout(SESSION_TIMEOUT);
	}

	public String getBitmask() {
		return bitmask;
	}

	public void setBitmask(String bitmask) {
		this.bitmask = bitmask;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
	
	public String getCouncilLogoUrl() {
		return councilLogoUrl;
	}

	public void setCouncilLogoUrl(String councilLogoUrl) {
		this.councilLogoUrl = councilLogoUrl;
	}
	
	public String getAreaName() {
		return areaName;
	}

	public void setAreaName(String areaName) {
		this.areaName = areaName;
	}

	public String getPollingStationName() {
		return pollingStationName;
	}

	public void setPollingStationName(String pollingStationName) {
		this.pollingStationName = pollingStationName;
	}

	public String getPollingPlaceName() {
		return pollingPlaceName;
	}

	public void setPollingPlaceName(String pollingPlaceName) {
		this.pollingPlaceName = pollingPlaceName;
	}

	public String getPollingDistrictName() {
		return pollingDistrictName;
	}

	public void setPollingDistrictName(String pollingDistrictName) {
		this.pollingDistrictName = pollingDistrictName;
	}

	public int getPollingPlaceId() {
		return pollingPlaceId;
	}

	public void setPollingPlaceId(int pollingPlaceId) {
		this.pollingPlaceId = pollingPlaceId;
	}

	public List<PollingStation> getPollingStations() {
		return pollingStations;
	}

	public void setPollingStations(List<PollingStation> pollingStations) {
		this.pollingStations = pollingStations;
	}

	public String getWardName() {
		return wardName;
	}

	public void setWardName(String wardName) {
		this.wardName = wardName;
	}
	
	public String getBallotBoxNo() {
		return ballotBoxNo;
	}

	public void setBallotBoxNo(String ballotBoxNo) {
		this.ballotBoxNo = ballotBoxNo;
	}
	
	public int getCouncilId() {
		return councilId;
	}

	public void setCouncilId(int councilId) {
		this.councilId = councilId;
	}

	public String getCouncilName() {
		return councilName;
	}

	public void setCouncilName(String councilName) {
		this.councilName = councilName;
	}

	@Override
	public String toString() {
		return "AuthenticatedUser [" + ", getId()=" + getId()
				+ ", getCreatedOn()=" + getCreatedOn() + ", getUpdatedOn()="
				+ getUpdatedOn() + ", getLocale()=" + getLocale()
				+ ", getRole()=" + getRole() + ", getLoginName()="
				+ getLoginName() + ", getEncryption()=" + getEncryption()
				+ ", getHomeURL()=" + getHomeURL() + ", getSecret()="
				+ getSecret() + ", getAPIKey()=" + getAPIKey()
				+ ", getSessionTimeout()=" + getSessionTimeout()
				+ ", getLoginCount()=" + getLoginCount()
				+ ", incrementLoginCount()=" + incrementLoginCount()
				+ ", hasValidSecret()=" + hasValidSecret() + ", toString()="
				+ super.toString() + ", hashCode()=" + hashCode()
				+ ", createMarshaller()=" + createMarshaller()
				+ ", getClass()=" + getClass() 
				//+ ", PollingStationName = "+pollingStationName
				//+ ", PollingPlaceName = "+pollingPlaceName
				//+ ", PollingDistrictName = "+pollingDistrictName
				//+ ", PollingWardName = "+wardName
				//+ ", PollingStations = "+pollingStations
				+ "]";
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.anaeko.utils.json.ToJSON#createMarshaller()
	 */
	@Override
	public JsonMarshaler createMarshaller() {
		return new Marshaler();
	}

	public static final class Marshaler extends DefaultJsonMarshaler {

		/*
		 * Property Names for JSON
		 */
		
		public static final String USER_NAME = "username";
		
		public static final String TITLE = "title";
		public static final String BITMASK = "bitMask";
		public static final String ROLE_ID = "roleId";
		
		public static final String POLLING_STATION_NAME = "pollingStationName";
		public static final String POLLING_PLACE_ID = "pollingPlaceId";
		public static final String POLLING_PLACE_NAME = "pollingPlaceName";
		public static final String POLLING_DISTRICT_NAME = "pollingDistrictName";
		public static final String WARD_NAME = "wardName";
		public static final String BALLOT_BOX_NUMBER = "ballotBoxNumber";
		
		public static final String COUNCIL_ID = "councilId";
		public static final String COUNCIL_NAME = "councilName";
		public static final String COUNCIL_LOGO_URL = "councilLogoUrl";
		public static final String COUNCIL_AREA_NAME = "areaName";
		
		public static final String POLLING_STATIONS = "pollingStations";

		public static final String ALERT = "alert";
		public static final String TYPE = "type";
		public static final String MESSAGE = "message";

		PollingStationMarshaler pollingStationMarshaler = new PollingStationMarshaler();
		
		/*
		 * (non-Javadoc)
		 * 
		 * @see
		 * com.anaeko.utils.data.mime.json.DefaultJsonMarshaler#marshal(java
		 * .lang.Object, com.anaeko.utils.json.JsonWriter)
		 */
		@SuppressWarnings("unchecked")
		@Override
		public void marshal(Object object, JsonWriter writer)
				throws IOException, MarshalerException {
			if (object instanceof Iterable) {
				marshalCollection((Iterable<AuthenticatedUser>) object, writer);
			} else {
				marshalObject((AuthenticatedUser) object, writer);
			}
		}

		private void marshalObject(AuthenticatedUser object, JsonWriter writer)
				throws IOException {

			AuthenticatedUser u = (AuthenticatedUser) object;
			writer.writeStartObject();

			writer.writeFieldName(ID);
			writer.writeNumber(u.getId());

			writer.writeFieldName(USER_NAME);
			writer.writeString(u.getLoginName());
			
			if (!u.getPollingStationName().equals("NA")) {
				writer.writeFieldName(POLLING_STATION_NAME);
				writer.writeString(u.getPollingStationName());
			}

			if (u.getPollingPlaceId()!=0) {
				writer.writeFieldName(POLLING_PLACE_ID);
				writer.writeNumber(u.getPollingPlaceId());
			}

			if (!u.getPollingPlaceName().equals("NA")) {
				writer.writeFieldName(POLLING_PLACE_NAME);
				writer.writeString(u.getPollingPlaceName());
			}

			if (!u.getPollingDistrictName().equals("NA")) {
				writer.writeFieldName(POLLING_DISTRICT_NAME);
				writer.writeString(u.getPollingDistrictName());
			}

			if (!u.getWardName().equals("NA")) {
				writer.writeFieldName(WARD_NAME);
				writer.writeString(u.getWardName());
			}

			if (!u.getPollingStationName().equals("NA")) {
				writer.writeFieldName(BALLOT_BOX_NUMBER);
				writer.writeString(u.getBallotBoxNo());
			}

			writer.writeFieldName(COUNCIL_ID);
			writer.writeNumber(u.getCouncilId());
			
			writer.writeFieldName(COUNCIL_NAME);
			writer.writeString(u.getCouncilName());
			
			writer.writeFieldName(COUNCIL_LOGO_URL);
			writer.writeString(u.getCouncilLogoUrl());
			
			writer.writeFieldName(COUNCIL_AREA_NAME);
			writer.writeString(u.getAreaName());
			
			if (u.getPollingStations()!=null && !u.getPollingStationName().equals("NA")) {
				writer.writeFieldName(POLLING_STATIONS);
				pollingStationMarshaler.marshal(u.getPollingStations(), writer);
			}
			
			writeRoleFields(u, writer);

			writer.writeEndObject();

		}

		protected void writeRoleFields(AuthenticatedUser u, JsonWriter writer)
				throws IOException, MarshalerException {

			writer.writeFieldName(ROLE);

			writer.writeStartObject();

			writer.writeFieldName(TITLE);
			writer.writeString(u.getTitle());
			
			writer.writeFieldName(ROLE_ID);
			writer.writeNumber(u.getRole());

			writer.writeEndObject();
		}

		private void marshalCollection(Iterable<AuthenticatedUser> object,
				JsonWriter writer) throws IOException {
			writer.writeStartArray();

			for (AuthenticatedUser authenticatedUser : object) {
				marshalObject(authenticatedUser, writer);
			}

			writer.writeEndArray();
		}

	}

	
}
