package com.moderndemocracy.json;

import java.io.IOException;
import java.util.List;

import com.anaeko.utils.data.mime.json.DefaultJsonMarshaler;
import com.anaeko.utils.io.MarshalerException;
import com.anaeko.utils.json.JsonWriter;
import com.moderndemocracy.pojo.Ward;

public final class WardsMarshaler extends DefaultJsonMarshaler {	
	
	DistrictMarshaler districtMarshaler = new DistrictMarshaler();
	
	@SuppressWarnings("unchecked")
	@Override
	public void marshal(Object object, JsonWriter writer)
			throws IOException, MarshalerException {

		if (object instanceof List) {
			
			writer.writeStartArray();

			for (Ward ward : (Iterable<Ward>) object) {
				marshalWard(ward, writer);
			}

			writer.writeEndArray();
			
		} else {
			marshalWard((Ward) object, writer);
		}
	}

	private void marshalWard(Ward ward, JsonWriter writer)
			throws IOException {

		writer.writeStartObject();

		writer.writeField(Ward.WARD_ID, ward.getId());
		writer.writeField(Ward.WARD_NAME, ward.getWardName());
		
		writer.writeFieldName(Ward.DISTRICTS);
		districtMarshaler.marshal(ward.getDistricts(), writer);
		
		writer.writeField(Ward.TOTAL_BALLOT_PAPER_ISSUED, ward.getTotalBallotPapersIssued());
		writer.writeField(Ward.TOTAL_POSTAL_PACKS, ward.getTotalPostalPacks());
		
		writer.writeEndObject();
	}
	
}