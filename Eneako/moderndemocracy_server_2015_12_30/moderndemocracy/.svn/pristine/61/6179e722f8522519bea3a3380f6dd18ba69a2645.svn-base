package com.moderndemocracy.json;

import java.io.IOException;
import java.util.List;

import com.anaeko.utils.data.mime.json.DefaultJsonMarshaler;
import com.anaeko.utils.io.MarshalerException;
import com.anaeko.utils.json.JsonWriter;
import com.moderndemocracy.pojo.DashboardDownloads;
import com.moderndemocracy.pojo.DashboardTotal;

public final class DashboardDownloadsMarshaler extends DefaultJsonMarshaler {	
	
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

			for (DashboardDownloads dashboardDownloads : (Iterable<DashboardDownloads>) object) {
				marshalDashboardDownloads(dashboardDownloads, writer);
			}

			writer.writeEndArray();
			
		} else {
			marshalDashboardDownloads((DashboardDownloads) object, writer);
		}
	}

	private void marshalDashboardDownloads(DashboardDownloads dashboardDownloads, JsonWriter writer)
			throws IOException {

		writer.writeStartObject();
		
		// Chart
		if (dashboardDownloads.getDashboardChart()!=null) {
			writer.writeFieldName(DashboardDownloads.CHART);
			dashboardChartMarshaler.marshal(dashboardDownloads.getDashboardChart(), writer);
		}

		// Total
		if (dashboardDownloads.getDashboardTotal()!=null) {
			writer.writeField(DashboardTotal.TOTAL, dashboardDownloads.getDashboardTotal().getTotal());
		}
		
		// Age
		if (dashboardDownloads.getDashboardAge()!=null) {
			writer.writeFieldName(DashboardDownloads.AGE);
			dashboardAgeMarshaler.marshal(dashboardDownloads.getDashboardAge(), writer);
		}
		
		// Gender
		if (dashboardDownloads.getDashboardGender()!=null) {
			writer.writeFieldName(DashboardDownloads.GENDER);
			dashboardGenderMarshaler.marshal(dashboardDownloads.getDashboardGender(), writer);
		}
		
		writer.writeEndObject();
	}
	
}