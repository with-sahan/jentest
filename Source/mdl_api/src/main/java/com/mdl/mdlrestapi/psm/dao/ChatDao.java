package com.mdl.mdlrestapi.psm.dao;

import com.mdl.mdlrestapi.psm.exception.MDLDBException;

/**
 * Created by lasantha on 3/13/2017.
 */
public interface ChatDao {

    /**
     * @param uploadedFileLocation
     * @param issueid
     * @param pollingstationid
     * @param chatmessage
     * @param token
     * @return
     * @throws MDLDBException
     */
    public int saveToDbChat(String uploadedFileLocation, String issueid, String pollingstationid, String chatmessage,
                            String token) throws MDLDBException;
}
