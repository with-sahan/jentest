package com.moderndemocracy.json;

import java.io.IOException;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.anaeko.utils.data.mime.json.DefaultJsonMarshaler;
import com.anaeko.utils.io.MarshalerException;
import com.anaeko.utils.json.JsonWriter;
import com.moderndemocracy.pojo.Settings;

public final class SettingsMarshaler extends DefaultJsonMarshaler {	
	
	protected static final Logger logger = LogManager.getLogger(SettingsMarshaler.class);
	
	@SuppressWarnings("unchecked")
	@Override
	public void marshal(Object object, JsonWriter writer)
			throws IOException, MarshalerException {

		if (object instanceof List) {
			
			writer.writeStartArray();

			for (Settings settings : (Iterable<Settings>) object) {
				marshalSettings(settings, writer);
			}

			writer.writeEndArray();
			
		} else {

			marshalSettings((Settings) object, writer);

		}
	}

	private void marshalSettings(Settings settings, JsonWriter writer)
			throws IOException {

		writer.writeStartObject();

		writer.writeField(Settings.ID, settings.getId());
		
//		String tabItems[] = settings.getTabs().split(",");
//		
//		writer.writeFieldName("tabs");
//		writer.writeStartObject();
//		for (String tabItem : tabItems) {
//				writer.writeField(tabItem+"Tab",true);
//		}
//		writer.writeEndObject();
		
		writer.writeField(Settings.DEFAULT_TAB, settings.getTabs());
		
		writer.writeField(Settings.REGISTRATION_DEADLINE, settings.getRegistrationDeadline());
		writer.writeField(Settings.MIN_BUILD_NUMBER, settings.getMinBuildNumber());
		writer.writeField(Settings.UPGRADE_MESSAGE, settings.getUpgradeMessage());
		writer.writeField(Settings.FACEBOOK_APP_ID, settings.getFacebookAppId());
		writer.writeField(Settings.IOS_APP_STORE_URL, settings.getIosAppStoreUrl());
		writer.writeField(Settings.ANDROID_GOOGLE_PLAY_STORE_URL, settings.getAndroidGooglePlayStoreUrl());
		
		writer.writeField(Settings.CREATED_ON, settings.getCreatedOn());
		writer.writeField(Settings.UPDATED_ON, settings.getUpdatedOn());

		writer.writeEndObject();
	}
	
}