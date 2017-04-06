package com.moderndemocracy.json;

import java.io.IOException;
import java.util.List;

import com.anaeko.utils.data.mime.json.DefaultJsonMarshaler;
import com.anaeko.utils.io.MarshalerException;
import com.anaeko.utils.json.JsonWriter;
import com.moderndemocracy.pojo.DashboardTotal;

public final class DashboardTotalMarshaler extends DefaultJsonMarshaler {	
	
	@SuppressWarnings("unchecked")
	@Override
	public void marshal(Object object, JsonWriter writer)
			throws IOException, MarshalerException {

		if (object instanceof List) {
			
			writer.writeStartArray();

			for (DashboardTotal dashboardTotal : (Iterable<DashboardTotal>) object) {
				marshalDashboardChart(dashboardTotal, writer);
			}

			writer.writeEndArray();
			
		} else {
			marshalDashboardChart((DashboardTotal) object, writer);
		}
	}

	private void marshalDashboardChart(DashboardTotal dashboardTotal, JsonWriter writer)
			throws IOException {

		writer.writeStartObject();

		writer.writeField(DashboardTotal.TOTAL, dashboardTotal.getTotal());

		writer.writeEndObject();
	}
	
}