package com.moderndemocracy.pojo;

import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.anaeko.utils.data.mime.json.DefaultJsonMarshaler;
import com.anaeko.utils.json.JsonMarshaler;
import com.anaeko.utils.json.ToJSON;
import com.moderndemocracy.json.PlaceMarshaler;

public class Place implements ToJSON {

	protected static final Logger logger = LogManager.getLogger(Place.class);

	public static final String PLACE_ID = "placeId";
	public static final String PLACE_NAME = "placeName";
	public static final String DISTRICT_ID = "districtId";
	public static final String STATIONS = "stations";
	
	private int placeId;
	private String placeName;
	private int districtId;
	private List<Station> stations;
	

	public int getPlaceId() {
		return placeId;
	}

	public void setId(int placeId) {
		this.placeId = placeId;
	}
	
	public String getPlaceName() {
		return placeName;
	}

	public void setPlaceName(String placeName) {
		this.placeName = placeName;
	}

	public int getDistrictId() {
		return districtId;
	}

	public void setDistrictId(int districtId) {
		this.districtId = districtId;
	}

	public List<Station> getStations() {
		return stations;
	}

	public void setStations(List<Station> stations) {
		this.stations = stations;
	}

	@Override
	public String toString() {
		
		return " Place [ "
				
				+ ", placeId=" + placeId
				+ ", placeName=" + placeName
				+ ", districtId=" + districtId
				+ ", stations=" + stations
				+ " ] ";
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.anaeko.utils.json.ToJSON#createMarshaller()
	 */
	@Override
	public JsonMarshaler createMarshaller() {
		return new PlaceMarshaler();
	}

	public static final class Marshaler extends DefaultJsonMarshaler {
	}

}
