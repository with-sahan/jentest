package com.moderndemocracy.pojo;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.anaeko.utils.data.mime.json.DefaultJsonMarshaler;
import com.anaeko.utils.json.JsonMarshaler;
import com.anaeko.utils.json.ToJSON;
import com.moderndemocracy.json.StationCloseMarshaler;

public class StationClose implements ToJSON {

	protected static final Logger logger = LogManager.getLogger(StationClose.class);

	public static final String ORDINARY  = "ordinary";
	public static final String TENDERED  = "tendered";
	public static final String STATION_ID  = "stationId";

	private Ordinary ordinary;
	private Tendered tendered;
	private Integer stationId;

	public Ordinary getOrdinary() {
		return ordinary;
	}

	public void setOrdinary(Ordinary ordinary) {
		this.ordinary = ordinary;
	}

	public Tendered getTendered() {
		return tendered;
	}

	public void setTendered(Tendered tendered) {
		this.tendered = tendered;
	}

	public Integer getStationId() {
		return stationId;
	}

	public void setStationId(Integer stationId) {
		this.stationId = stationId;
	}

	@Override
	public String toString() {
		return " StationClose [ "
				+ ordinary.toString()
				+ tendered.toString()
				+ "stationID:" + stationId.toString()
				+ "] ";
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see com.anaeko.utils.json.ToJSON#createMarshaller()
	 */
	@Override
	public JsonMarshaler createMarshaller() {
		return new StationCloseMarshaler();
	}

	public static final class Marshaler extends DefaultJsonMarshaler {
	}

}
