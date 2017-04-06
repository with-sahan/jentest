package com.moderndemocracy.json;

import java.io.IOException;
import java.util.List;

import com.anaeko.utils.data.mime.json.DefaultJsonMarshaler;
import com.anaeko.utils.io.MarshalerException;
import com.anaeko.utils.json.JsonWriter;
import com.moderndemocracy.pojo.ProgressUpdate;

public final class ProgressUpdateMarshaler extends DefaultJsonMarshaler {	
	
	@SuppressWarnings("unchecked")
	@Override
	public void marshal(Object object, JsonWriter writer)
			throws IOException, MarshalerException {

		if (object instanceof List) {
			
			writer.writeStartArray();

			for (ProgressUpdate progressUpdate : (Iterable<ProgressUpdate>) object) {
				marshalProgressUpdate(progressUpdate, writer);
			}

			writer.writeEndArray();
			
		} else {
			if (object!=null) {
				marshalProgressUpdate((ProgressUpdate) object, writer);
			}
		}
	}

	private void marshalProgressUpdate(ProgressUpdate progressUpdate, JsonWriter writer)
			throws IOException {

		writer.writeStartObject();
		
		writer.writeField(ProgressUpdate.PAPER_ISSUED, progressUpdate.getPapersIssued());
		writer.writeField(ProgressUpdate.POSTAL_PACKS_RECEIVED, progressUpdate.getPostalPacksReceived());
		writer.writeField(ProgressUpdate.POSTAL_PACKS_AWAITING_COLLECTION, progressUpdate.getPostalPacksAwaitingCollection());
		
		writer.writeEndObject();
	}
	
}