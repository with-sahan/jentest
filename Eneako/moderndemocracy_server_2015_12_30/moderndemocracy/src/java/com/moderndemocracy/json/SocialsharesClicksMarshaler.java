package com.moderndemocracy.json;

import java.io.IOException;
import java.util.List;

import com.anaeko.utils.data.mime.json.DefaultJsonMarshaler;
import com.anaeko.utils.io.MarshalerException;
import com.anaeko.utils.json.JsonWriter;
import com.moderndemocracy.pojo.SocialsharesClicks;

public final class SocialsharesClicksMarshaler extends DefaultJsonMarshaler {	
	
	@SuppressWarnings("unchecked")
	@Override
	public void marshal(Object object, JsonWriter writer)
			throws IOException, MarshalerException {

		if (object instanceof List) {
			
			writer.writeStartArray();

			for (SocialsharesClicks socialsharesClicks : (Iterable<SocialsharesClicks>) object) {
				marshalSocialsharesClicks(socialsharesClicks, writer);
			}

			writer.writeEndArray();
			
		} else {
			marshalSocialsharesClicks((SocialsharesClicks) object, writer);
		}
	}

	private void marshalSocialsharesClicks(SocialsharesClicks socialsharesClicks, JsonWriter writer)
			throws IOException {

		writer.writeStartObject();

		writer.writeField(SocialsharesClicks.ARTICLE, socialsharesClicks.getArticle());
		writer.writeField(SocialsharesClicks.TOTAL, socialsharesClicks.getTotal());
		writer.writeField(SocialsharesClicks.FACBOOK, socialsharesClicks.getFacebook());
		writer.writeField(SocialsharesClicks.TWITTER, socialsharesClicks.getTwitter());

		writer.writeEndObject();
	}
	
}