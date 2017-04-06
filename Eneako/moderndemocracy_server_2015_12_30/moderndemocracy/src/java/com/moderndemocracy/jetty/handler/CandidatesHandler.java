package com.moderndemocracy.jetty.handler;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.anaeko.utils.http.Code;
import com.anaeko.utils.io.MarshalerException;
import com.moderndemocracy.dao.CandidatesDao;
import com.moderndemocracy.dao.SettingsDao;
import com.moderndemocracy.dao.UsersDao;
import com.moderndemocracy.pojo.AuthenticatedUser;
import com.moderndemocracy.pojo.Candidates;
import com.moderndemocracy.pojo.Settings;
import com.moderndemocracy.pojo.User;

public class CandidatesHandler extends ModernDemocracyHandler {

	private static final Logger logger = Logger.getLogger(CandidatesHandler.class);

	@Override
	protected String getSupportedMethods() {
		return "GET";
	}

	@Override
	protected void handleGet(String target, HttpServletRequest request,
			HttpServletResponse response) throws MarshalerException,
			IOException {
		

		try {
			
			// DAOs
			UsersDao userDao = new UsersDao(getDataSource());
			CandidatesDao candidatesDao = new CandidatesDao(getDataSource());
			SettingsDao settingsDao = new SettingsDao(getDataSource());
						
			// Get user info by sessionId
			String id = read(request).sessionId();
			AuthenticatedUser currentUser = (AuthenticatedUser)getServiceContext().getUser(id);
			User user = userDao.getById(currentUser.getId());
			
			// Get Settings by Council Id
			List<Settings> settings = settingsDao.getSettingsByCouncilId(user.getCouncilId());
			logger.debug("Settings for Council "+user.getCouncilId()+" = "+settings.get(0));
						
			// Get Candidates by Council Id
			List<Candidates> candidates = candidatesDao.getCandidatesByCouncilId(user.getCouncilId(),user.getRoleId());
			logger.debug("GET Candidates for "+user.getLoginName()+" (Council "+user.getCouncilId()+") =" + candidates);
			
			if (candidates!=null) {
				
				// Update according to Settings
				for (int i=0; i<candidates.size(); i++) {
					
					// Convert Content into the right format if it is not formatted
					if (candidates.get(i).getContent().indexOf("<p>")==-1) {
						candidates.get(i).setContent(processContent(candidates.get(i).getContent()));
					}
					
					// Title Image
					if (candidates.get(i).getTitleImage()==null) {
						logger.debug("Inserting default Title Image");
						candidates.get(i).setTitleImage(settings.get(0).getDefaultCandidatesTitleImage());
					}
					
					// Title = WardName - Title
					//candidates.get(i).setTitle(candidates.get(i).getWardName()+" - "+candidates.get(i).getTitle());
					
					// Set PartyName = WardName
					candidates.get(i).setPartyName(candidates.get(i).getWardName());
				}
			}
			
			// Return candidates for specific council to client
			send(request, response).json(candidates);
			
		} catch (Exception e) {
			logger.error("Unexpected Exception", e);
			send(request, response).status(Code.SERVER_ERROR_INTERNAL);
		}
	}
	
private String processContent(String input) {
		
		String output = "";
	
		String protocol_in[] = {"http","mailto:"};
		String[] protocol_out= { "<a ng-click=\"extUrl('", "')\">", "</a>" };
		
		logger.debug(">> ProcessContent - input="+input);
		
		/**************************/
		/* Split into paragraphs */
		/************************/
		String[] paragraphs = input.split("\n\n");
		logger.debug(">> Found "+paragraphs.length+" paragraphs");
		
		for (int i=0; i<paragraphs.length; i++) {
			
			logger.debug(">> In Paragraph["+i+"] = "+paragraphs[i]);
			
			/***************************************/
			/* Split each paragraph into Sentence */
			/*************************************/
			String[] sentences = paragraphs[i].split("\\. ");
			
			for (int j=0; j<sentences.length; j++) {
				
				logger.debug(">> In Sentence["+i+"]["+j+"] = "+sentences[j]);
				
				/**********************************************/
				/* Replace SINGLE CARRIAGE RETURN with </br> */
				/********************************************/
				sentences[j] = sentences[j].replace("\n", "</br>");
				
				/*******************/
				/* Deal with http */
				/*****************/
				String outSentence = "";
				int pos=0;
				int nextPos=0;

				for (String protocolIn : protocol_in) {
					
					while ((nextPos = sentences[j].indexOf(protocolIn, pos))>-1) {
						
						String inUrl = sentences[j].substring(nextPos);
						String[] inUrlItems = inUrl.split(" ");
						
						outSentence += sentences[j].substring(pos,nextPos) + 
											protocol_out[0] + 
												inUrlItems[0] + 
													protocol_out[1] + 
														inUrlItems[0] + 
															protocol_out[2];
						
						pos = nextPos + inUrlItems[0].length();
					}
				}
				
				/*************************/
				/* Reconstruct Sentence */
				/***********************/
				sentences[j] = outSentence + sentences[j].substring(pos);
				if (j!=sentences.length-1) {
					sentences[j] += ". ";
				}
				logger.debug(">> OutSentence["+i+"]["+j+"] = "+sentences[j]);
			
			}
			
			/**************************/
			/* Reconstruct Paragraph */
			/************************/
			paragraphs[i]="";
			for (String sentence : sentences) {
				paragraphs[i] += sentence;
			}
			logger.debug(">> OutParagraph["+i+"] = "+paragraphs[i]);
		}
		
		/*********************/
		/* Construct output */
		/*******************/
		for (String paragraph : paragraphs) {
			output += "<p>" + paragraph + "</p>";
		}
		
		logger.debug(">> ProcessContent - output="+output);
		return output;
	}

}
