package com.moderndemocracy.json;

import java.io.IOException;
import java.util.List;

import com.anaeko.utils.data.mime.json.DefaultJsonMarshaler;
import com.anaeko.utils.io.MarshalerException;
import com.anaeko.utils.json.JsonWriter;
import com.moderndemocracy.pojo.NotificationList;

public final class NotificationListMarshaler extends DefaultJsonMarshaler {

	@SuppressWarnings("unchecked")
	@Override
	public void marshal(Object object, JsonWriter writer)
			throws IOException, MarshalerException {

		if (object instanceof List) {

			writer.writeStartArray();

			for (NotificationList notificationList : (Iterable<NotificationList>) object) {
				marshalNotificationList(notificationList, writer);
			}

			writer.writeEndArray();
		} else {
			
			writer.writeStartArray();
			marshalNotificationList((NotificationList) object, writer);
			writer.writeEndArray();
		}
	}

	private void marshalNotificationList(NotificationList notificationList, JsonWriter writer)
			throws IOException {

		writer.writeStartObject();

		writer.writeField(NotificationList.ID, notificationList.getId());
		writer.writeField(NotificationList.TEXT, notificationList.getText());
		writer.writeField(NotificationList.STATION_ID, notificationList.getStationId());
		writer.writeField(NotificationList.STATUS, notificationList.getStatus());
                writer.writeField(NotificationList.URL, notificationList.getUrl());
		
		if (notificationList.getStationId()!=0) {
			
			writer.writeField(NotificationList.STATION_NAME,  notificationList.getStationName());
			writer.writeField(NotificationList.PLACE_NAME,    notificationList.getPlaceName());
			writer.writeField(NotificationList.DISTRICT_NAME, notificationList.getDistrictName());
			writer.writeField(NotificationList.WARD_NAME,     notificationList.getWardName());
		}
		
		writer.writeField(NotificationList.CREATED_ON, notificationList.getCreatedOn());

		writer.writeEndObject();
	}

}