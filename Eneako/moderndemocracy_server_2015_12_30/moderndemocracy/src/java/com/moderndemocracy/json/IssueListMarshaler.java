package com.moderndemocracy.json;

import java.io.IOException;
import java.util.List;

import com.anaeko.utils.data.mime.json.DefaultJsonMarshaler;
import com.anaeko.utils.io.MarshalerException;
import com.anaeko.utils.json.JsonWriter;
import com.moderndemocracy.pojo.IssueList;

public final class IssueListMarshaler extends DefaultJsonMarshaler {

	@SuppressWarnings("unchecked")
	@Override
	public void marshal(Object object, JsonWriter writer)
			throws IOException, MarshalerException {

		if (object instanceof List) {

			writer.writeStartArray();

			for (IssueList issueList : (Iterable<IssueList>) object) {
				marshalIssueList(issueList, writer);
			}

			writer.writeEndArray();
		} else {
			marshalIssueList((IssueList) object, writer);
		}
	}

	private void marshalIssueList(IssueList issueList, JsonWriter writer)
			throws IOException {

		writer.writeStartObject();

		writer.writeField(IssueList.ID, issueList.getId());
		writer.writeField(IssueList.TEXT, issueList.getText());
		writer.writeField(IssueList.ORDER_ID, issueList.getOrderId());
		writer.writeField(IssueList.EMAIL, issueList.getEmail());
		writer.writeField(IssueList.STATUS, issueList.getStatus());

		writer.writeEndObject();
	}

}