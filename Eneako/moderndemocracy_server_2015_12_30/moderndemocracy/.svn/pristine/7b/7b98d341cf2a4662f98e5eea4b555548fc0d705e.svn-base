package com.moderndemocracy.json;

import java.io.IOException;
import java.util.List;

import com.anaeko.utils.data.mime.json.DefaultJsonMarshaler;
import com.anaeko.utils.io.MarshalerException;
import com.anaeko.utils.json.JsonWriter;
import com.moderndemocracy.pojo.District;

public final class DistrictMarshaler extends DefaultJsonMarshaler {	
	
	PlaceMarshaler placeMarshaler = new PlaceMarshaler();
	
	@SuppressWarnings("unchecked")
	@Override
	public void marshal(Object object, JsonWriter writer)
			throws IOException, MarshalerException {

		if (object instanceof List) {
			
			writer.writeStartArray();

			for (District district : (Iterable<District>) object) {
				marshalDistrict(district, writer);
			}

			writer.writeEndArray();
			
		} else {
			marshalDistrict((District) object, writer);
		}
	}

	private void marshalDistrict(District district, JsonWriter writer)
			throws IOException {

		writer.writeStartObject();

		writer.writeField(District.DISTRICT_ID, district.getDistrictId());
		writer.writeField(District.DISTRICT_NAME, district.getDistrictName());
		writer.writeField(District.WARD_ID, district.getWardId());
		
		writer.writeFieldName(District.PLACES);
		placeMarshaler.marshal(district.getPlaces(), writer);
		
		writer.writeEndObject();
	}
	
}