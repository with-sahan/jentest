package com.moderndemocracy.json;

import java.io.IOException;
import java.util.List;

import com.anaeko.utils.data.mime.json.DefaultJsonMarshaler;
import com.anaeko.utils.io.MarshalerException;
import com.anaeko.utils.json.JsonWriter;
import com.moderndemocracy.pojo.DashboardAge;

public final class DashboardAgeMarshaler extends DefaultJsonMarshaler {	
	
	@SuppressWarnings("unchecked")
	@Override
	public void marshal(Object object, JsonWriter writer)
			throws IOException, MarshalerException {

		if (object instanceof List) {
			
			writer.writeStartArray();

			for (DashboardAge dashboardAge : (Iterable<DashboardAge>) object) {

				marshalDashboardAge(dashboardAge, writer);
			}

			writer.writeEndArray();
			
		} else {
			
			marshalDashboardAge((DashboardAge) object, writer);
		}
	}

	private void marshalDashboardAge(DashboardAge dashboardAge, JsonWriter writer)
			throws IOException {

		writer.writeStartObject();

		writer.writeField(DashboardAge.RANGE_START, dashboardAge.getRangeStart());
		writer.writeField(DashboardAge.RANGE_END, dashboardAge.getRangeEnd());
		writer.writeField(DashboardAge.TOTAL, dashboardAge.getTotal());

		writer.writeEndObject();
	}
	
}