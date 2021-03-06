package com.moderndemocracy.json;

import java.io.IOException;
import java.util.List;

import com.anaeko.utils.data.mime.json.DefaultJsonMarshaler;
import com.anaeko.utils.io.MarshalerException;
import com.anaeko.utils.json.JsonWriter;
import com.moderndemocracy.pojo.DashboardTotal;
import com.moderndemocracy.pojo.DashboardUsers;

public final class DashboardUsersMarshaler extends DefaultJsonMarshaler {	
	
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

			for (DashboardUsers dashboardUsers : (Iterable<DashboardUsers>) object) {
				marshalDashboardUsers(dashboardUsers, writer);
			}

			writer.writeEndArray();
			
		} else {
			marshalDashboardUsers((DashboardUsers) object, writer);
		}
	}

	private void marshalDashboardUsers(DashboardUsers dashboardUsers, JsonWriter writer)
			throws IOException {

		writer.writeStartObject();
		
		// Chart
		if (dashboardUsers.getDashboardChart()!=null) {
			writer.writeFieldName(DashboardUsers.CHART);
			dashboardChartMarshaler.marshal(dashboardUsers.getDashboardChart(), writer);
		}

		// Total
		if (dashboardUsers.getDashboardTotal()!=null) {
			writer.writeField(DashboardTotal.TOTAL, dashboardUsers.getDashboardTotal().getTotal());
		}

		// Age
		if (dashboardUsers.getDashboardAge()!=null) {
			writer.writeFieldName(DashboardUsers.AGE);
			dashboardAgeMarshaler.marshal(dashboardUsers.getDashboardAge(), writer);
		}
		
		// Gender
		if (dashboardUsers.getDashboardGender()!=null) {
			writer.writeFieldName(DashboardUsers.GENDER);
			dashboardGenderMarshaler.marshal(dashboardUsers.getDashboardGender(), writer);
		}
		
		writer.writeEndObject();
	}
	
}