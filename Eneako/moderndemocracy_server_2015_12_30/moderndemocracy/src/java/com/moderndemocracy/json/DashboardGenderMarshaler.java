package com.moderndemocracy.json;

import java.io.IOException;
import java.util.List;

import com.anaeko.utils.data.mime.json.DefaultJsonMarshaler;
import com.anaeko.utils.io.MarshalerException;
import com.anaeko.utils.json.JsonWriter;
import com.moderndemocracy.pojo.DashboardGender;

public final class DashboardGenderMarshaler extends DefaultJsonMarshaler {	
	
	@SuppressWarnings("unchecked")
	@Override
	public void marshal(Object object, JsonWriter writer)
			throws IOException, MarshalerException {

		if (object instanceof List) {
			
			////writer.writeStartArray();
			writer.writeStartObject();

			for (DashboardGender dashboardGender : (Iterable<DashboardGender>) object) {
				marshalDashboardGender(dashboardGender, writer);
			}

			writer.writeEndObject();
			////writer.writeEndArray();
			
		} else {
			marshalDashboardGender((DashboardGender) object, writer);
		}
	}

	private void marshalDashboardGender(DashboardGender dashboardGender, JsonWriter writer)
			throws IOException {

//		writer.writeStartObject();
//
//		writer.writeField(DashboardGender.GENDER, dashboardGender.getGender());
//		writer.writeField(DashboardGender.TOTAL, dashboardGender.getTotal());
//
//		writer.writeEndObject();
		
		writer.writeField(dashboardGender.getGender(), dashboardGender.getTotal());
	}
	
}