package com.moderndemocracy.json;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.anaeko.utils.data.mime.json.DefaultJsonMarshaler;
import com.anaeko.utils.io.MarshalerException;
import com.anaeko.utils.json.JsonWriter;
import com.moderndemocracy.pojo.News;

public final class NewsMarshaler extends DefaultJsonMarshaler {	
	
	protected static final Logger logger = LogManager.getLogger(NewsMarshaler.class);
	
	//String DEFAULT_TITLE_IMAGE = "http://www.moderndemocracy.co.uk/img/mobile/default_news_title.png";
	//String DEFAULT_CONTENT_IMAGE = "http://www.moderndemocracy.co.uk/img/mobile/content_blank.png";
	
	@SuppressWarnings("unchecked")
	@Override
	public void marshal(Object object, JsonWriter writer)
			throws IOException, MarshalerException {

		if (object instanceof List) {
			
			writer.writeStartArray();

			for (News news : (Iterable<News>) object) {
				marshalNews(news, writer);
			}

			writer.writeEndArray();
			
		} else {
			writer.writeStartArray();
			marshalNews((News) object, writer);
			writer.writeEndArray();
		}
	}

	private void marshalNews(News news, JsonWriter writer)
			throws IOException {

		writer.writeStartObject();

		writer.writeField(News.ID, news.getId());
		writer.writeField(News.TITLE, news.getTitle());
		writer.writeField(News.SUMMARY, news.getSummary());
		writer.writeField(News.CONTENT, news.getContent());
		writer.writeField(News.PUBLIC_URL, news.getPublicUrl());
		writer.writeField(News.TITLE_IMAGE, news.getTitleImage());
		writer.writeField(News.CONTENT_IMAGE, news.getContentImage());

		String date = new SimpleDateFormat("dd MMM yyyy").format(news.getCreated());
		writer.writeField(News.CREATED, date);

		writer.writeEndObject();
	}
	
//private String processContent(String input) {
//		
//		String output = "";
//	
//		String protocol_in[] = {"http","mailto:"};
//		String[] protocol_out= { "<a ng-click=\"extUrl('", "')\">", "</a>" };
//		
//		logger.debug(">> ProcessContent - input="+input);
//		
//		/**************************/
//		/* Split into paragraphs */
//		/************************/
//		String[] paragraphs = input.split("\n\n");
//		logger.debug(">> Found "+paragraphs.length+" paragraphs");
//		
//		for (int i=0; i<paragraphs.length; i++) {
//			
//			logger.debug(">> In Paragraph["+i+"] = "+paragraphs[i]);
//			
//			/***************************************/
//			/* Split each paragraph into Sentence */
//			/*************************************/
//			String[] sentences = paragraphs[i].split("\\. ");
//			
//			for (int j=0; j<sentences.length; j++) {
//				
//				logger.debug(">> In Sentence["+i+"]["+j+"] = "+sentences[j]);
//				
//				/*******************/
//				/* Deal with http */
//				/*****************/
//				String outSentence = "";
//				int pos=0;
//				int nextPos=0;
//
//				for (String protocolIn : protocol_in) {
//					
//					while ((nextPos = sentences[j].indexOf(protocolIn, pos))>-1) {
//						
//						String inUrl = sentences[j].substring(nextPos);
//						String[] inUrlItems = inUrl.split(" ");
//						
//						outSentence += sentences[j].substring(pos,nextPos) + 
//											protocol_out[0] + 
//												inUrlItems[0] + 
//													protocol_out[1] + 
//														inUrlItems[0] + 
//															protocol_out[2];
//						
//						pos = nextPos + inUrlItems[0].length();
//					}
//				}
//				
//				/*************************/
//				/* Reconstruct Sentence */
//				/***********************/
//				sentences[j] = outSentence + sentences[j].substring(pos);
//				if (j!=sentences.length-1) {
//					sentences[j] += ". ";
//				}
//				logger.debug(">> OutSentence["+i+"]["+j+"] = "+sentences[j]);
//			
//			}
//			
//			/**************************/
//			/* Reconstruct Paragraph */
//			/************************/
//			paragraphs[i]="";
//			for (String sentence : sentences) {
//				paragraphs[i] += sentence;
//			}
//			logger.debug(">> OutParagraph["+i+"] = "+paragraphs[i]);
//		}
//		
//		/*********************/
//		/* Construct output */
//		/*******************/
//		for (String paragraph : paragraphs) {
//			output += "<p>" + paragraph + "</p>";
//		}
//		
//		logger.debug(">> ProcessContent - output="+output);
//		return output;
//	}
	
}