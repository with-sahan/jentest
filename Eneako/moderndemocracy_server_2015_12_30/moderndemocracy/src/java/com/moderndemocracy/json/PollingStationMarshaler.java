package com.moderndemocracy.json;

import java.io.IOException;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.anaeko.utils.data.mime.json.DefaultJsonMarshaler;
import com.anaeko.utils.io.MarshalerException;
import com.anaeko.utils.json.JsonWriter;
import com.moderndemocracy.pojo.PollingStation;

public final class PollingStationMarshaler extends DefaultJsonMarshaler {

	protected static final Logger logger = LogManager.getLogger(PollingStationMarshaler.class);

	@SuppressWarnings("unchecked")
	@Override
	public void marshal(Object object, JsonWriter writer)
			throws IOException, MarshalerException {

		if (object instanceof List) {

			writer.writeStartArray();

			for (PollingStation pollingStation : (Iterable<PollingStation>) object) {
				marshalPollingStation(pollingStation, writer);
			}

			writer.writeEndArray();

		} else {
			writer.writeStartArray();
			marshalPollingStation((PollingStation) object, writer);
			writer.writeEndArray();
		}
	}

	private void marshalPollingStation(PollingStation pollingStation, JsonWriter writer)
			throws IOException {

		writer.writeStartObject();

		writer.writeField(PollingStation.ID, pollingStation.getId());
		writer.writeField(PollingStation.NAME, pollingStation.getName());

		writer.writeField(PollingStation.PLACE_NAME, pollingStation.getPlaceName());
		writer.writeField(PollingStation.DISTRICT_NAME, pollingStation.getDistrictName());
		writer.writeField(PollingStation.WARD_NAME, pollingStation.getWardName());
		writer.writeField(PollingStation.COUNCIL_NAME, pollingStation.getCouncilName());
		writer.writeField(PollingStation.STATUS, pollingStation.getStatus());

		writer.writeEndObject();
	}

}