package com.moderndemocracy.pojo;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.anaeko.utils.data.mime.json.DefaultJsonMarshaler;
import com.anaeko.utils.json.JsonMarshaler;
import com.anaeko.utils.json.ToJSON;
import com.moderndemocracy.json.DashboardTotalMarshaler;

public class DashboardTotal implements ToJSON {

	protected static final Logger logger = LogManager.getLogger(DashboardTotal.class);

	public static final String TOTAL = "total";
	
	private Integer total;
	


	public Integer getTotal() {
		return total;
	}

	public void setTotal(Integer total) {
		this.total = total;
	}

	@Override
	public String toString() {
		
		return " DashboardTotal [ "
				
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
		return new DashboardTotalMarshaler();
	}

	public static final class Marshaler extends DefaultJsonMarshaler {
	}

}
