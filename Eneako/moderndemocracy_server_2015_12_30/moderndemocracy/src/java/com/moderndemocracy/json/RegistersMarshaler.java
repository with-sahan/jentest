package com.moderndemocracy.json;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.List;

import com.anaeko.utils.data.mime.json.DefaultJsonMarshaler;
import com.anaeko.utils.io.MarshalerException;
import com.anaeko.utils.json.JsonWriter;
import com.moderndemocracy.pojo.Registers;

public final class RegistersMarshaler extends DefaultJsonMarshaler {	
	
	@SuppressWarnings("unchecked")
	@Override
	public void marshal(Object object, JsonWriter writer)
			throws IOException, MarshalerException {

		if (object instanceof List) {
			
			writer.writeStartArray();

			for (Registers registers : (Iterable<Registers>) object) {
				marshalRegisters(registers, writer);
			}

			writer.writeEndArray();
			
		} else {
			marshalRegisters((Registers) object, writer);
		}
	}

	private void marshalRegisters(Registers registers, JsonWriter writer)
			throws IOException {

		writer.writeStartObject();

		writer.writeField(Registers.ID, registers.getId());
		writer.writeField(Registers.TITLE, registers.getTitle());
		writer.writeField(Registers.SUMMARY, registers.getSummary());
		writer.writeField(Registers.CONTENT, registers.getContent());
		
		String date = new SimpleDateFormat("dd MMM yyyy").format(registers.getCreated());
		writer.writeField(Registers.CREATED, date);

		writer.writeEndObject();
	}
	
}