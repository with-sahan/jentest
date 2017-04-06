package com.moderndemocracy.json;

import java.io.IOException;
import java.util.List;

import com.anaeko.utils.data.mime.json.DefaultJsonMarshaler;
import com.anaeko.utils.io.MarshalerException;
import com.anaeko.utils.json.JsonWriter;
import com.moderndemocracy.pojo.NotificationReceived;

public final class NotificationReceivedMarshaler extends DefaultJsonMarshaler {

	@SuppressWarnings("unchecked")
	@Override
	public void marshal(Object object, JsonWriter writer)
			throws IOException, MarshalerException {

		if (object instanceof List) {

			writer.writeStartArray();

			for (NotificationReceived notificationReceived : (Iterable<NotificationReceived>) object) {
				marshalNotificationReceived(notificationReceived, writer);
			}

			writer.writeEndArray();
		} else {
			
			// Force it to an ARRAY
			writer.writeStartArray();
			marshalNotificationReceived((NotificationReceived) object, writer);
			writer.writeEndArray();
		}
	}

	private void marshalNotificationReceived(NotificationReceived notificationReceived, JsonWriter writer)
			throws IOException {

		writer.writeStartObject();

		writer.writeField(NotificationReceived.NOTIFICATION_ID, notificationReceived.getNotificationId());
		writer.writeField(NotificationReceived.STATION_ID, notificationReceived.getStationId());
		writer.writeField(NotificationReceived.USER_ID, notificationReceived.getUserId());
		writer.writeField(NotificationReceived.STATUS, notificationReceived.getStatus());
				
		writer.writeEndObject();
	}

}