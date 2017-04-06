package com.mdl.mdlrestapi.psm.service;

import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.psm.resource.dto.TokenRequest;
import com.mdl.mdlrestapi.psm.resource.dto.VoterDeleteRequest;
import com.mdl.mdlrestapi.psm.resource.dto.VoterInfoRequest;

/**
 * Created with IntelliJ IDEA.
 * User: AnushaP
 * Date: 2/24/17
 * Time: 10:46 PM
 * To change this template use File | Settings | File Templates.
 */
public interface VoterService {
    /**
     * Get Voters list
     * @param request
     * @return
     * @throws MDLDBException
     */
    public String getVotersList(TokenRequest request) throws MDLDBException;

    /**
     * Save Voter
     * @param request
     * @return
     * @throws MDLDBException
     */
    public String saveVoter(VoterInfoRequest request)throws MDLDBException;

    /**
     * Voter Delete
     * @param request
     * @return
     * @throws MDLDBException
     */
    public String deleteVoter(VoterDeleteRequest request)throws MDLDBException;
}
