package com.moderndemocracy.json;

import java.io.IOException;
import java.util.List;

import com.anaeko.utils.data.mime.json.DefaultJsonMarshaler;
import com.anaeko.utils.io.MarshalerException;
import com.anaeko.utils.json.JsonWriter;
import com.moderndemocracy.pojo.Socialshares;

public final class SocialsharesMarshaler extends DefaultJsonMarshaler {	
	
	@SuppressWarnings("unchecked")
	@Override
	public void marshal(Object object, JsonWriter writer)
			throws IOException, MarshalerException {

		if (object instanceof List) {
			
			writer.writeStartArray();

			for (Socialshares socialshares : (Iterable<Socialshares>) object) {
				marshalSocialshares(socialshares, writer);
			}

			writer.writeEndArray();
			
		} else {
			marshalSocialshares((Socialshares) object, writer);
		}
	}

	private void marshalSocialshares(Socialshares socialshares, JsonWriter writer)
			throws IOException {

		writer.writeStartObject();

		writer.writeField(Socialshares.TITLE, socialshares.getTitle());
		writer.writeField(Socialshares.SOCIAL_NETWORK, socialshares.getSocialNetwork());
		writer.writeField(Socialshares.TOTAL, socialshares.getTotal());

		writer.writeEndObject();
	}
	
}