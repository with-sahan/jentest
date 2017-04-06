package com.moderndemocracy.pojo;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.anaeko.utils.data.mime.json.DefaultJsonMarshaler;
import com.anaeko.utils.json.JsonMarshaler;
import com.anaeko.utils.json.ToJSON;
import com.moderndemocracy.json.UserMarshaler;

public class User implements ToJSON {

	protected static final Logger logger = LogManager.getLogger(User.class);

	public static final String ID = "id";
	public static final String ROLE_ID = "roleId";
	public static final String COUNCIL_ID = "councilId";
	public static final String COUNCIL_LOGO_URL = "councilLogoUrl";
	public static final String LOGIN_NAME = "loginName";
	public static final String FIRST_NAME = "firstName";
	public static final String LAST_NAME = "lastName";
	public static final String PASSWORD = "password";
	public static final String STATION_ID = "stationId";
	public static final String PROJECTS = "projects";
	
	private int id;
	private int roleId;
	private int councilId;
	private String loginName;
	private String firstName;
	private String lastName;
	private String password;
	private int stationId;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getRoleId() {
		return roleId;
	}

	public void setRoleId(int roleId) {
		this.roleId = roleId;
	}
	
	public int getCouncilId() {
		return councilId;
	}

	public void setCouncilId(int councilId) {
		this.councilId = councilId;
	}

	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	
	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public int getStationId() {
		return stationId;
	}

	public void setStationId(int stationId) {
		this.stationId = stationId;
	}

	

	@Override
	public String toString() {
		return "User [id=" + id + ", roleId=" + roleId + ", loginName="
				+ loginName + ", firstName=" + firstName + ", lastName="
				+ lastName + ", stationId="+stationId
				+ "]";
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.anaeko.utils.json.ToJSON#createMarshaller()
	 */
	@Override
	public JsonMarshaler createMarshaller() {
		return new UserMarshaler();
	}

	public static final class Marshaler extends DefaultJsonMarshaler {

		
	}

}
