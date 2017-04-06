package com.moderndemocracy.json;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.anaeko.utils.data.mime.json.DefaultJsonMarshaler;
import com.anaeko.utils.io.MarshalerException;
import com.anaeko.utils.json.JsonReader;
import com.anaeko.utils.json.JsonReader.JsonToken;
import com.anaeko.utils.json.JsonWriter;
import com.moderndemocracy.pojo.User;
//import com.moderndemocracy.pojo.UserHasProject;

public final class UserMarshaler extends DefaultJsonMarshaler {

	@SuppressWarnings("unchecked")
	@Override
	public void marshal(Object object, JsonWriter writer)
			throws IOException, MarshalerException {

		if (object instanceof List) {

			writer.writeStartArray();

			for (User user : (Iterable<User>) object) {
				marshalUser(user, writer);
			}

			writer.writeEndArray();
		} else {
			marshalUser((User) object, writer);
		}
	}

	private void marshalUser(User user, JsonWriter writer)
			throws IOException {

		writer.writeStartObject();

		writer.writeField(User.ID, user.getId());
		writer.writeField(User.LOGIN_NAME, user.getLoginName());
		writer.writeField(User.FIRST_NAME, user.getFirstName());
		writer.writeField(User.LAST_NAME, user.getLastName());

		writer.writeEndObject();
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.anaeko.utils.data.mime.json.DefaultJsonMarshaler#unmarshal(com.anaeko
	 * .utils.data.mime.json.JsonReader)
	 */
	@Override
	public Object unmarshal(JsonReader reader) throws IOException,
			MarshalerException {

		while ((reader.getCurrentToken() != JsonToken.START_ARRAY)
				&& (reader.getCurrentToken() != JsonToken.START_OBJECT)) {
			reader.nextToken();
		}

		if (reader.getCurrentToken() == JsonToken.START_OBJECT) {
			return readUser(reader);
		} else if (reader.getCurrentToken() == JsonToken.START_ARRAY) {
			return readUserArray(reader);
		}
		return null;
	}

	private List<User> readUserArray(JsonReader reader)
			throws IOException {
		ArrayList<User> entries = new ArrayList<User>();
		while (reader.nextToken() != JsonToken.END_ARRAY) {
			if (reader.getCurrentToken() != JsonToken.START_OBJECT) {
				reader.nextToken();
			} else {
				entries.add(readUser(reader));
			}
		}
		return entries;
	}

	protected User readUser(JsonReader reader)
			throws IOException {

		User u = new User();
		while (reader.nextToken() != JsonToken.END_OBJECT) {
			String name = reader.getCurrentName();
			reader.nextToken();

			if (User.LOGIN_NAME.equals(name)) {
				u.setLoginName(reader.getText());
			}
			else if (User.FIRST_NAME.equals(name)) {
				u.setFirstName(reader.getText());
			} 
			else if (User.LAST_NAME.equals(name)) {
				u.setLastName(reader.getText());
			} 
			else if (User.PASSWORD.equals(name)) {
				u.setPassword(reader.getText());
			} 
			else if (User.STATION_ID.equals(name)) {
				u.setStationId(reader.getIntValue());
			} 

		}
		return u;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.anaeko.utils.data.mime.json.DefaultJsonMarshaler#isUnmarshalingSupported
	 * ()
	 */
	@Override
	public boolean isUnmarshalingSupported() {
		return true;
	}

}