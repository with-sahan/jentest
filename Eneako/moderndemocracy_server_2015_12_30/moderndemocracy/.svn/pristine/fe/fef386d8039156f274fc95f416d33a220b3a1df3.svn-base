package com.moderndemocracy.json;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.List;

import com.anaeko.utils.data.mime.json.DefaultJsonMarshaler;
import com.anaeko.utils.io.MarshalerException;
import com.anaeko.utils.json.JsonWriter;
import com.moderndemocracy.pojo.Candidates;

public final class CandidatesMarshaler extends DefaultJsonMarshaler {	
	
	@SuppressWarnings("unchecked")
	@Override
	public void marshal(Object object, JsonWriter writer)
			throws IOException, MarshalerException {

		if (object instanceof List) {
			
			writer.writeStartArray();

			for (Candidates candidates : (Iterable<Candidates>) object) {
				marshalCandidates(candidates, writer);
			}

			writer.writeEndArray();
			
		} else {
			writer.writeStartArray();
			marshalCandidates((Candidates) object, writer);
			writer.writeEndArray();
		}
	}

	private void marshalCandidates(Candidates candidates, JsonWriter writer)
			throws IOException {

		writer.writeStartObject();

		writer.writeField(Candidates.ID, candidates.getId());
		writer.writeField(Candidates.TITLE, candidates.getTitle());
		writer.writeField(Candidates.SUMMARY, candidates.getSummary());
		writer.writeField(Candidates.CONTENT, candidates.getContent());
		writer.writeField(Candidates.PUBLIC_URL, candidates.getPublicUrl());
		writer.writeField(Candidates.TITLE_IMAGE, candidates.getTitleImage());
		writer.writeField(Candidates.FLAG_IMAGE, candidates.getFlagImage());
		writer.writeField(Candidates.PARTY_NAME, candidates.getPartyName());
		writer.writeField(Candidates.WARD_NAME, candidates.getWardName());
		
		String date = new SimpleDateFormat("dd MMM yyyy").format(candidates.getCreated());
		writer.writeField(Candidates.CREATED, date);

		writer.writeEndObject();
	}
	
}