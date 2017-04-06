package com.moderndemocracy.pojo;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.anaeko.utils.data.mime.json.DefaultJsonMarshaler;
import com.anaeko.utils.json.JsonMarshaler;
import com.anaeko.utils.json.ToJSON;
import com.moderndemocracy.json.PollingStationMarshaler;

public class PollingStation implements ToJSON {

	protected static final Logger logger = LogManager.getLogger(PollingStation.class);

	public static final String ID = "id";
	public static final String NAME = "name";

	public static final String PLACE_NAME = "place_name";
	public static final String DISTRICT_NAME = "district_name";
	public static final String WARD_NAME = "ward_name";
	public static final String COUNCIL_NAME = "council_name";
	public static final String STATUS = "status";

	private int id;
	private String name;

	private String placeName;
	private String districtName;
	private String wardName;
	private String councilName;
	private Boolean status;


	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPlaceName() {
		return placeName;
	}

	public void setPlaceName(String placeName) {
		this.placeName = placeName;
	}

	public String getDistrictName() {
		return districtName;
	}

	public void setDistrictName(String districtName) {
		this.districtName = districtName;
	}

	public String getWardName() {
		return wardName;
	}

	public void setWardName(String wardName) {
		this.wardName = wardName;
	}

	public String getCouncilName() {
		return councilName;
	}

	public void setCouncilName(String councilName) {
		this.councilName = councilName;
	}

	public Boolean getStatus() {
		return status;
	}

	public void setStatus(Boolean status) {
		this.status = status;
	}

	@Override
	public String toString() {

		return " PollingStation [ "
				+ ", id=" + id
				+ ", name=" + name
				+ " ] ";
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see com.anaeko.utils.json.ToJSON#createMarshaller()
	 */
	@Override
	public JsonMarshaler createMarshaller() {
		return new PollingStationMarshaler();
	}

	public static final class Marshaler extends DefaultJsonMarshaler {
	}

}
