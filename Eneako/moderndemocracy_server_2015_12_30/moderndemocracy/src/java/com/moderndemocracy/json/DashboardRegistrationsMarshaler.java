package com.moderndemocracy.json;

import java.io.IOException;
import java.util.List;

import com.anaeko.utils.data.mime.json.DefaultJsonMarshaler;
import com.anaeko.utils.io.MarshalerException;
import com.anaeko.utils.json.JsonWriter;
import com.moderndemocracy.pojo.DashboardRegistrations;
import com.moderndemocracy.pojo.DashboardTotal;
import com.moderndemocracy.pojo.DashboardUsers;

public final class DashboardRegistrationsMarshaler extends DefaultJsonMarshaler {	
	
	DashboardChartMarshaler dashboardChartMarshaler = new DashboardChartMarshaler();
	DashboardTotalMarshaler dashboardTotalMarshaler = new DashboardTotalMarshaler();
	DashboardAgeMarshaler dashboardAgeMarshaler = new DashboardAgeMarshaler();
	DashboardGenderMarshaler dashboardGenderMarshaler = new DashboardGenderMarshaler();
	
	@SuppressWarnings("unchecked")
	@Override
	public void marshal(Object object, JsonWriter writer)
			throws IOException, MarshalerException {

		if (object instanceof List) {
			
			writer.writeStartArray();

			for (DashboardRegistrations dashboardRegistrations : (Iterable<DashboardRegistrations>) object) {
				marshalDashboardRegistrations(dashboardRegistrations, writer);
			}

			writer.writeEndArray();
			
		} else {
			marshalDashboardRegistrations((DashboardRegistrations) object, writer);
		}
	}

	private void marshalDashboardRegistrations(DashboardRegistrations dashboardRegistrations, JsonWriter writer)
			throws IOException {

		writer.writeStartObject();
		
		// Chart
		if (dashboardRegistrations.getDashboardChart()!=null) {
			writer.writeFieldName(DashboardUsers.CHART);
			dashboardChartMarshaler.marshal(dashboardRegistrations.getDashboardChart(), writer);
		}

		// Total
		if (dashboardRegistrations.getDashboardTotal()!=null) {
			writer.writeField(DashboardTotal.TOTAL, dashboardRegistrations.getDashboardTotal().getTotal());
		}

		// Age
		if (dashboardRegistrations.getDashboardAge()!=null) {
			writer.writeFieldName(DashboardUsers.AGE);
			dashboardAgeMarshaler.marshal(dashboardRegistrations.getDashboardAge(), writer);
		}
		
		// Gender
		if (dashboardRegistrations.getDashboardGender()!=null) {
			writer.writeFieldName(DashboardUsers.GENDER);
			dashboardGenderMarshaler.marshal(dashboardRegistrations.getDashboardGender(), writer);
		}
		
		writer.writeEndObject();
	}
	
}