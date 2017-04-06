package com.moderndemocracy.pojo;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.anaeko.utils.data.mime.json.DefaultJsonMarshaler;
import com.anaeko.utils.json.JsonMarshaler;
import com.anaeko.utils.json.ToJSON;
import com.moderndemocracy.json.DashboardChartMarshaler;

public class DashboardChart implements ToJSON {

	protected static final Logger logger = LogManager.getLogger(DashboardChart.class);

	public static final String X = "date";
	public static final String XEPOCH = "date";
	public static final String Y = "value";
	
	private String x;
	private Long xepoch;
	private Integer y;
	

	public String getX() {
		return x;
	}

	public void setX(String x) {
		this.x = x;
	}

	public Long getXepoch() {
		return xepoch;
	}

	public void setXepoch(Long xepoch) {
		this.xepoch = xepoch;
	}

	public Integer getY() {
		return y;
	}

	public void setY(Integer y) {
		this.y = y;
	}

	@Override
	public String toString() {
		
		return " DashboardChart [ "
				
				+ ", x=" + x
				+ ", y=" + y
				+ " ] ";
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.anaeko.utils.json.ToJSON#createMarshaller()
	 */
	@Override
	public JsonMarshaler createMarshaller() {
		return new DashboardChartMarshaler();
	}

	public static final class Marshaler extends DefaultJsonMarshaler {
	}

}
