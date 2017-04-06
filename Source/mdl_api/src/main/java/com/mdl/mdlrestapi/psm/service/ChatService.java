package com.mdl.mdlrestapi.psm.service;

import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.psm.resource.dto.TokenRequest;
import com.mdl.mdlrestapi.psm.resource.dto.VoterDeleteRequest;

import java.io.InputStream;

/**
 * Created with IntelliJ IDEA.
 * User: AnushaP
 * Date: 2/25/17
 * Time: 12:08 AM
 * To change this template use File | Settings | File Templates.
 */
public interface ChatService {

    /**
     * Get Chat count alert
     * @param request
     * @return
     * @throws MDLDBException
     */
    public String getChatCountAlert(TokenRequest request) throws MDLDBException;

    /**
     * Get Chat count alert v1
     * @param request
     * @return
     * @throws MDLDBException
     */
    public String getChatCountAlertV1(TokenRequest request)throws MDLDBException;

    /**
     * @param uploadedInputStream
     * @param relativePath
     * @throws Exception
     */
    public void writeToFile(InputStream uploadedInputStream, String relativePath) throws Exception;

    /**
     * @param uploadedFileLocation
     * @param issueid
     * @param pollingstationid
     * @param chatmessage
     * @param token
     * @return
     * @throws Exception
     */
    public int saveToDbChat(String uploadedFileLocation, String issueid, String pollingstationid, String chatmessage,
                            String token) throws Exception;

    /**
     * @param token
     * @param issueId
     * @param chatId
     * @return
     * @throws Exception
     */
    public boolean createIssueNotificationsForChat(String token,int issueId,int chatId) throws Exception;
}
