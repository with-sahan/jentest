package com.moderndemocracy.json;

import java.io.IOException;
import java.util.List;

import com.anaeko.utils.data.mime.json.DefaultJsonMarshaler;
import com.anaeko.utils.io.MarshalerException;
import com.anaeko.utils.json.JsonWriter;
import com.moderndemocracy.pojo.Campaign;

public final class CampaignMarshaler extends DefaultJsonMarshaler {	
	
	WardsMarshaler wardsMarshaler = new WardsMarshaler();
	
	@SuppressWarnings("unchecked")
	@Override
	public void marshal(Object object, JsonWriter writer)
			throws IOException, MarshalerException {

		if (object instanceof List) {
			
			writer.writeStartArray();

			for (Campaign campaign : (Iterable<Campaign>) object) {
				marshalCampaign(campaign, writer);
			}

			writer.writeEndArray();
			
		} else {
			marshalCampaign((Campaign) object, writer);
		}
	}

	private void marshalCampaign(Campaign campaign, JsonWriter writer)
			throws IOException {

		writer.writeStartObject();

		writer.writeField(Campaign.TOTAL_BALLOT_PAPERS_ISSUED, campaign.getTotalBallotPapersIssued());
		writer.writeField(Campaign.TOTAL_POSTAL_PACKS, campaign.getTotalPostalPacks());
		writer.writeField(Campaign.ORDINARY_TOTAL_ISSUED, campaign.getOrdinaryTotalIssued());
		writer.writeField(Campaign.ORDINARY_NUMBER_OF_REPLACEMENTS, campaign.getOrdinaryNumberOfReplacements());
		writer.writeField(Campaign.ORDINARY_CALS_ISSUED_AND_NOT_SPOILT, campaign.getOrdinaryCalsIssuedAndNotSpoilt());
		writer.writeField(Campaign.ORDINARY_TOTAL_UNUSED, campaign.getOrdinaryTotalUnused());
		writer.writeField(Campaign.TENDERED_TOTAL_ISSUED, campaign.getTenderedTotalIssued());
		writer.writeField(Campaign.TENDERED_TOTAL_SPOILT, campaign.getTenderedTotalSpoilt());
		writer.writeField(Campaign.TENDERED_TOTAL_UNUSED, campaign.getTenderedTotalUnused());

		writer.writeFieldName(Campaign.WARDS);
		wardsMarshaler.marshal(campaign.getWards(), writer);
		
		writer.writeEndObject();
	}
	
}