package com.moderndemocracy.pojo;

import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.anaeko.utils.data.mime.json.DefaultJsonMarshaler;
import com.anaeko.utils.json.JsonMarshaler;
import com.anaeko.utils.json.ToJSON;
import com.moderndemocracy.json.DistrictMarshaler;

public class District implements ToJSON {

	protected static final Logger logger = LogManager.getLogger(District.class);

	public static final String DISTRICT_NAME = "districtName";
	public static final String WARD_ID = "wardId";
	public static final String DISTRICT_ID = "districtId";
	public static final String PLACES = "places";
	
	private int districtId;
	private String districtName;
	private int wardId;
	private List<Place> places;
	

	public int getDistrictId() {
		return districtId;
	}

	public void setDistrictId(int id) {
		this.districtId = id;
	}
	
	public String getDistrictName() {
		return districtName;
	}

	public void setDistrictName(String districtName) {
		this.districtName = districtName;
	}

	public int getWardId() {
		return wardId;
	}

	public void setWardId(int wardId) {
		this.wardId = wardId;
	}

	public List<Place> getPlaces() {
		return places;
	}

	public void setPlaces(List<Place> places) {
		this.places = places;
	}

	@Override
	public String toString() {
		
		return " District [ "
				
				+ ", id=" + districtId
				+ ", districtName=" + districtName
				+ ", wardId=" + wardId
				+ ", places=" + places
				+ " ] ";
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.anaeko.utils.json.ToJSON#createMarshaller()
	 */
	@Override
	public JsonMarshaler createMarshaller() {
		return new DistrictMarshaler();
	}

	public static final class Marshaler extends DefaultJsonMarshaler {
	}

}
