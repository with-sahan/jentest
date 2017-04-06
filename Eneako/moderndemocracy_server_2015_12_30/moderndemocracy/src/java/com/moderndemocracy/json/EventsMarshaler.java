package com.moderndemocracy.json;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.List;

import com.anaeko.utils.data.mime.json.DefaultJsonMarshaler;
import com.anaeko.utils.io.MarshalerException;
import com.anaeko.utils.json.JsonWriter;
import com.moderndemocracy.pojo.Events;

public final class EventsMarshaler extends DefaultJsonMarshaler {	
	
	@SuppressWarnings("unchecked")
	@Override
	public void marshal(Object object, JsonWriter writer)
			throws IOException, MarshalerException {

		if (object instanceof List) {
			
			writer.writeStartArray();

			for (Events events : (Iterable<Events>) object) {
				marshalEvents(events, writer);
			}

			writer.writeEndArray();
			
		} else {
			writer.writeStartArray();
			marshalEvents((Events) object, writer);
			writer.writeEndArray();
		}
	}

	private void marshalEvents(Events events, JsonWriter writer)
			throws IOException {

		writer.writeStartObject();

		writer.writeField(Events.ID, events.getId());
		writer.writeField(Events.TITLE, events.getTitle());
		writer.writeField(Events.SUMMARY, events.getSummary());
		writer.writeField(Events.CONTENT, events.getContent());
		writer.writeField(Events.PUBLIC_URL, events.getPublicUrl());
		writer.writeField(Events.TITLE_IMAGE, events.getTitleImage());
		writer.writeField(Events.CONTENT_IMAGE, events.getContentImage());
		
		String date = new SimpleDateFormat("dd MMM yyyy").format(events.getCreated());
		writer.writeField(Events.CREATED, date);

		writer.writeEndObject();
	}
	
}