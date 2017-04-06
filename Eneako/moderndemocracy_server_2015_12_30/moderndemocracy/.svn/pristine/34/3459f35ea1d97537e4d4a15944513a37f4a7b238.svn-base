package com.moderndemocracy.pojo;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.anaeko.utils.data.mime.json.DefaultJsonMarshaler;
import com.anaeko.utils.json.JsonMarshaler;
import com.anaeko.utils.json.ToJSON;
import com.moderndemocracy.json.DashboardChartMarshaler;

public class DashboardAge implements ToJSON {

	protected static final Logger logger = LogManager.getLogger(DashboardAge.class);

	public static final String RANGE_START = "rangeStart";
	public static final String RANGE_END = "rangeEnd";
	public static final String TOTAL = "total";
	
	private Integer rangeStart;
	private Integer rangeEnd;
	private Integer total;
	

	public Integer getRangeStart() {
		return rangeStart;
	}

	public void setRangeStart(Integer rangeStart) {
		this.rangeStart = rangeStart;
	}

	public Integer getRangeEnd() {
		return rangeEnd;
	}

	public void setRangeEnd(Integer rangeEnd) {
		this.rangeEnd = rangeEnd;
	}

	public Integer getTotal() {
		return total;
	}

	public void setTotal(Integer total) {
		this.total = total;
	}

	@Override
	public String toString() {
		
		return " DashboardTotal [ "
				
				+ ", rangeStart=" + rangeStart
				+ ", rangeEnd=" + rangeEnd
				+ ", total=" + total
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
