package com.moderndemocracy.json;

import java.io.IOException;
import java.util.List;

import com.anaeko.utils.data.mime.json.DefaultJsonMarshaler;
import com.anaeko.utils.io.MarshalerException;
import com.anaeko.utils.json.JsonWriter;
import com.moderndemocracy.pojo.Notification;

public final class NotificationMarshaler extends DefaultJsonMarshaler {

	@SuppressWarnings("unchecked")
	@Override
	public void marshal(Object object, JsonWriter writer)
			throws IOException, MarshalerException {

		if (object instanceof List) {

			writer.writeStartArray();

			for (Notification notification : (Iterable<Notification>) object) {
				marshalNotification(notification, writer);
			}

			writer.writeEndArray();
		} else {
			
			// Force it to an ARRAY
			writer.writeStartArray();
			marshalNotification((Notification) object, writer);
			writer.writeEndArray();
		}
	}

	private void marshalNotification(Notification notification, JsonWriter writer)
			throws IOException {

		writer.writeStartObject();

		writer.writeField(Notification.ID, notification.getNotificationId());
		writer.writeField(Notification.TEXT, notification.getText());
		writer.writeField(Notification.DATETIME, notification.getCreatedOn());
		writer.writeField(Notification.PRIVATE, notification.isPrivate_notification());
		writer.writeField(Notification.URL, notification.getUrl());
				
		writer.writeEndObject();
	}

}