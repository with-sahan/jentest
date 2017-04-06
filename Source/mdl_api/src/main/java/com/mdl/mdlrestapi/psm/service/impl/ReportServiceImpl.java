package com.mdl.mdlrestapi.psm.service.impl;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;

import com.google.gson.Gson;
import com.mdl.mdlrestapi.psm.dao.CommonDao;
import com.mdl.mdlrestapi.psm.dao.ReportDao;
import com.mdl.mdlrestapi.psm.dao.impl.CommonDaoImpl;
import com.mdl.mdlrestapi.psm.dao.impl.ReportDaoImpl;
import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.psm.exception.MDLServiceException;
import com.mdl.mdlrestapi.psm.resource.dto.*;
import com.mdl.mdlrestapi.psm.service.ReportService;
import com.mdl.mdlrestapi.psm.utils.GeneratePDFBiteArray;
import com.mdl.mdlrestapi.psm.utils.SQLUtil;
import com.mdl.mdlrestapi.util.SimpleRequest;
import com.mdl.mdlrestapi.util.models.TenderedVotesDTO;
import com.thoughtworks.xstream.XStream;

/**
 * @Author : Rushan
 * @Date : Mar 26, 2017
 * @TIme : 12:00:51 PM
 */
public class ReportServiceImpl implements ReportService {

	/** The XSL_FILE. */
	private static final String XSL_FILE = "hourly-analysis-report.xsl";

	ReportDao reportDao = new ReportDaoImpl();
	CommonDao commonDao = new CommonDaoImpl();

	@Override
	public String getHoulyAnalysisData(SimpleRequest request) throws MDLDBException, MDLServiceException {

		List<GeoStatoinsResponse> page = new ArrayList<GeoStatoinsResponse>();
		page = reportDao.getAllGeoStations(request);
		Gson gson = new Gson();
		return gson.toJson(setHourlyStats(page));
	}

	@Override
	public byte[] getHoulyAnalysisPDF(SimpleRequest request) throws MDLDBException, IOException, MDLServiceException {

		byte[] pdfAsByteArray = null;
		StringBuilder sb = null;

		XStream xstream = new XStream();
		xstream.alias("row", GeoStatoinsResponse.class);
		xstream.alias("timehourly", TimeHourlyDto.class);
		xstream.alias("papersissued", HourlyPapersDto.class);

		List<GeoStatoinsResponse> page = new ArrayList<GeoStatoinsResponse>();
		page = setHourlyStats(reportDao.getAllGeoStations(request));

		if (!page.isEmpty()) {
			sb = new StringBuilder();
			sb.append(xstream.toXML(page));
			pdfAsByteArray = GeneratePDFBiteArray.createPdf(sb.toString(), XSL_FILE);
		}
		return pdfAsByteArray;
	}

	@Override
	public String getHoulyAnalysisDataByUser(TokenRequest request) throws MDLDBException, MDLServiceException {
		
		List<GeoStatoinsResponse> page = new ArrayList<GeoStatoinsResponse>();
		page = reportDao.getAllGeoStationsByUser(request);
		Gson gson = new Gson();
		return gson.toJson(setHourlyStats(page));
	}

	private List<GeoStatoinsResponse> setHourlyStats(List<GeoStatoinsResponse> page) throws MDLDBException, MDLServiceException {

		for (GeoStatoinsResponse geoStatoinsResponse : page) {

			int stationId = geoStatoinsResponse.getStationid();
			List<TimeHourlyDto> timeArray = reportDao.getTimeArrayStatsByStationId(stationId);

			if (timeArray.isEmpty()) {
				timeArray = handleNullTimeArray(stationId);
			} else {
				for (TimeHourlyDto papersArray : timeArray) {
					List<HourlyPapersDto> timeHourlyDto = reportDao.getBallotPaperHourly(stationId, papersArray.getHour());
					papersArray.setHour(setTimeRange(papersArray.getHour()));
					papersArray.setPapersissued(timeHourlyDto);
				}
			}
			geoStatoinsResponse.setTimehourly(timeArray);
		}
		return page;
	}

	private List<TimeHourlyDto> handleNullTimeArray(int stationId) throws MDLDBException, MDLServiceException {

		List<TimeHourlyDto> timeArray = new ArrayList<>();
		List<ElectionStartEndDto> elections = reportDao.getElectionStartEndTimes(stationId);

		int start = 0, end = 0;

		start = elections.get(0).getStarttime();
		end = elections.get(0).getEndtime();

		for (; start < end; start++) {
			TimeHourlyDto temp = new TimeHourlyDto();
			temp.setHour(setTimeRange(start + ""));
			temp.setRunningtotal(0);
			temp.setTotalcount(0);
			temp.setPapersissued(getPapperIssuedNullArray(elections));
			timeArray.add(temp);
		}
		return timeArray;
	}

	private List<HourlyPapersDto> getPapperIssuedNullArray(List<ElectionStartEndDto> elections) {
		List<HourlyPapersDto> papersissued = new ArrayList<>();

		for (ElectionStartEndDto election : elections) {

			HourlyPapersDto row = new HourlyPapersDto();
			row.setEname(election.getEname());
			row.setPapers(0);
			papersissued.add(row);
		}

		return papersissued;
	}
	
	private String setTimeRange(String hour) throws MDLServiceException{
		StringBuffer sb = new StringBuffer();
		int h = getValidatedTime(hour);
		if(h<11){
			sb.append(h + "am - " + (h+1) + "am");
		}else if(h==11){
			sb.append("11am - 12noon");
		}else if(h==12){
			sb.append("12noon - 1pm");
		}else
			sb.append((h-12) + "pm - " + (h-11) + "pm");
		return sb.toString();
	}
	
    private int getValidatedTime(String val) throws MDLServiceException {
    	
        if ( val == null || val.isEmpty() || val.equals('0')){
            throw new MDLServiceException(val);
        }
        
        final Pattern pattern = Pattern.compile("^[0-9]++$");
        if (!pattern.matcher(val).matches()) {
            throw new MDLServiceException(val);
        }
        return Integer.parseInt(val);
    }

	@Override
	public String getAllTenderedVotes(TokenRequest request) throws MDLDBException, MDLServiceException {
		Object [] params = new Object[1];
		params[0] =  request.getToken();
		return commonDao.getResultStringArray(SQLUtil.BOF_GETALL_TENDEREDVOTES, params);
	}

	@Override
	public String getTenderedVotesById(TenderedVotesRequest request) throws MDLDBException, MDLServiceException {
		Object [] params = new Object[2];
		params[0] =  request.getToken();
		params[1] =  request.getTvid();
		return commonDao.getResultStringArray(SQLUtil.BOF_GETBYID_TENDEREDVOTES, params);
	}

	@Override
	public String addToTenderedVotes(TenderedVotesRequest request) throws MDLDBException, MDLServiceException {
		Object [] params = new Object[6];
		params[0] =  request.getToken();
		params[1] =  request.getPollingstationid();
		params[2] =  request.getEid();
		params[3] =  request.getVotername();
		params[4] =  request.getElectornumber();
		params[5] =  request.getIsmarked();
		return commonDao.getResultStringObject(SQLUtil.BOF_ADDTO_TENDEREDVOTES, params);
	}

	@Override
	public String updateTenderedVote(TenderedVotesRequest request) throws MDLDBException, MDLServiceException {
		Object [] params = new Object[5];
		params[0] =  request.getToken();
		params[1] =  request.getVotername();
		params[2] =  request.getElectornumber();
		params[3] =  request.getIsmarked();
		params[4] =  request.getTvid();
		return commonDao.getResultStringObject(SQLUtil.BOF_UPDATE_TENDEREDVOTES, params);
	}

	@Override
	public String deleteTenderedVote(TenderedVotesRequest request) throws MDLDBException, MDLServiceException {
		Object [] params = new Object[2];
		params[0] =  request.getToken();
		params[1] =  request.getTvid();
		return commonDao.getResultStringObject(SQLUtil.BOF_DELETE_TENDEREDVOTES, params);
	}

	@Override
	public ArrayList<TenderedVotesDTO> getTenderedVotersByHierarchyId(SimpleRequest request) throws MDLDBException{
		return reportDao.getTenderedVotersByHierarchyId(request);
	}
}