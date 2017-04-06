package com.moderndemocracy.json;

import java.io.IOException;
import java.util.List;

import com.anaeko.utils.data.mime.json.DefaultJsonMarshaler;
import com.anaeko.utils.io.MarshalerException;
import com.anaeko.utils.json.JsonWriter;
import com.moderndemocracy.pojo.Place;

public final class PlaceMarshaler extends DefaultJsonMarshaler {	
	
	StationMarshaler stationMarshaler = new StationMarshaler();
	
	@SuppressWarnings("unchecked")
	@Override
	public void marshal(Object object, JsonWriter writer)
			throws IOException, MarshalerException {

		if (object instanceof List) {
			
			writer.writeStartArray();

			for (Place place : (Iterable<Place>) object) {
				marshalPlace(place, writer);
			}

			writer.writeEndArray();
			
		} else {
			marshalPlace((Place) object, writer);
		}
	}

	private void marshalPlace(Place place, JsonWriter writer)
			throws IOException {

		writer.writeStartObject();

		writer.writeField(Place.PLACE_ID, place.getPlaceId());
		writer.writeField(Place.PLACE_NAME, place.getPlaceName());
		writer.writeField(Place.DISTRICT_ID, place.getDistrictId());
		
		if (place.getStations()!=null) {
			writer.writeFieldName(Place.STATIONS);
			stationMarshaler.marshal(place.getStations(), writer);
		}
		writer.writeEndObject();
	}
	
}