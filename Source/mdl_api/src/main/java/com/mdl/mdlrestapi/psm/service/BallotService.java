package com.mdl.mdlrestapi.psm.service;

import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.psm.resource.dto.BallotCloseStatRequest;
import com.mdl.mdlrestapi.psm.resource.dto.ElectionRequest;
import com.mdl.mdlrestapi.psm.resource.dto.ElectionStatusRequest;

/**
 * Created with IntelliJ IDEA.
 * User: AnushaP
 * Date: 2/23/17
 * Time: 12:44 PM
 * To change this template use File | Settings | File Templates.
 */
public interface BallotService {

    /**
     *  Get Ballot type count
     * @param electionStatusRequest
     * @return
     * @throws MDLDBException
     */
    public String getBallotTypeCount(ElectionRequest electionStatusRequest) throws MDLDBException;

    /**
     * Get ballet papers
     * @param electionRequest
     * @return
     * @throws com.mdl.mdlrestapi.psm.exception.MDLDBException
     */
    public String getBallotPapers(ElectionRequest electionRequest) throws MDLDBException;

    /**
     * Get Ballot close status
     * @param electionRequest
     * @return
     * @throws MDLDBException
     */
    public String getBallotCloseStat(BallotCloseStatRequest electionRequest) throws MDLDBException;

    /**
     * Get All close status
     * @param electionRequest
     * @return
     * @throws MDLDBException
     */
    public String getAllCloseStat(ElectionRequest electionRequest) throws MDLDBException;

    /**
     * Get All close status
     * @param electionRequest
     * @return
     * @throws MDLDBException
     */
    public String csvBallotAccExport(ElectionRequest electionRequest) throws MDLDBException;

    /**
     * Get All close stat summary
     * @param electionRequest
     * @return
     * @throws MDLDBException
     */
    public String getAllCloseStatSummary(ElectionRequest electionRequest) throws MDLDBException;
}
