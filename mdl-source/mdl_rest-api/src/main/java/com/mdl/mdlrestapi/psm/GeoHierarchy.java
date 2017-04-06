package com.mdl.mdlrestapi.psm;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.ws.rs.Consumes;
import javax.ws.rs.OPTIONS;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.apache.log4j.Logger;
import org.json.JSONObject;
import com.mdl.mdlrestapi.util.ErrorCodes;
import com.mdl.mdlrestapi.util.SimpleRequest;
import com.mdl.mdlrestapi.util.TokenValidation;
import com.mdl.mdlrestapi.util.database.DatabaseConnectionManager;
import com.mdl.mdlrestapi.util.database.psm.PsmQuerryHandler;
import com.mdl.mdlrestapi.util.database.psm.entities.Hierarchy;
import com.mdl.mdlrestapi.util.database.psm.entities.HierarchyValue;
import com.mdl.mdlrestapi.util.database.psm.entities.PollingStation;
import com.mdl.mdlrestapi.util.database.security.SecurityQuerryHandler;
import com.mdl.mdlrestapi.util.database.subscription.SubscriptionQuerryHandler;
import com.mdl.mdlrestapi.util.exception.MDLServerException;
import com.mdl.mdlrestapi.util.exception.UnauthorizedException;

@Path("/geohierarchy")
public class GeoHierarchy {
	private static final Logger logger = Logger.getLogger(GeoHierarchy.class);

	public GeoHierarchy(){
		//CTOR
	}

	//this is need to avoid the CORS issues when calling options
	@OPTIONS
	@Path("{path : .*}")
	public Response options() {
		return Response.ok("").header("Access-Control-Allow-Origin", "*")
	            .header("Access-Control-Allow-Headers", "origin, content-type, accept, authorization")
	            .header("Access-Control-Allow-Credentials", "true")
	            .header("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS, HEAD")
				.header("Access-Control-Max-Age", "1209600").build();
	}

	@POST
	@Path("/getgeohierarchy")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public Response getGeoHierarchy(SimpleRequest request) throws MDLServerException, UnauthorizedException{
		if(request == null){
			logger.warn("Request is null");
			JSONObject responseobj = new JSONObject();
			responseobj.put("response", "Error:"+ErrorCodes.INVALID_DATA);
			return Response.ok(responseobj.toString()).build();
		}
			if(!TokenValidation.ValidateToken(request.token)){
				logger.warn("Invalid token,token:" + request.token);
			throw new UnauthorizedException(new Throwable("Invalid token"));
			}
		try{
			ArrayList<String> resultMap=prepareHierarchy(request.token);
			JSONObject responseobj = new JSONObject();
			responseobj.put("response", resultMap);
			return Response.ok(responseobj.toString()).build();

		}catch(Exception ex){
			logger.error(ex);
			throw new MDLServerException(ex);
		}
	}




			//get the list of top gro hierarchy nodes

				//add the first node to the list
				//now get the complete hierarchy below this parent add add to the list


	public List<Hierarchy> findHierarchyByOrganizationId(Integer orgId) throws Exception {
		List<Hierarchy> hierarchyList = new ArrayList<Hierarchy>();
		if (orgId != null && orgId > 0) {
			String query = "SELECT * FROM psm.hierarchy where organization_id =" + orgId;
			ResultSet rs = null;
			Statement statement = null;
			Connection conn = null;
		try {
				conn = DatabaseConnectionManager.getConnection();
				statement = conn.createStatement();

				rs = statement.executeQuery(query);
				while (rs.next()) {
					Hierarchy h =new Hierarchy();
					h.setId(rs.getInt("id")) ;
					h.setSortorder(rs.getInt("sortorder"));
					hierarchyList.add(h);
				}
				//e.printStackTrace();
			}finally {

				if (rs != null) {
					rs.close();
				}
				if (statement != null) {
					statement.close();
			}
				if(conn != null){
				conn.close();
				}
		}
		}
		return hierarchyList;
	}

	public List<HierarchyValue> findHierarchyValueByOrganizationId(Integer orgId) throws Exception {
		List<HierarchyValue> hierarchyList = new ArrayList<HierarchyValue>();
		logger.info("Organzation Id in 'findHierarchyValueByOrganizationId' : "+orgId);
		if (orgId != null && orgId > 0) {
			String query = "SELECT * FROM psm.hierarchy_value where organization_id =" + orgId;
			ResultSet rs = null;
			Statement statement = null;
			Connection conn = null;

		try {
				conn = DatabaseConnectionManager.getConnection();
				statement = conn.createStatement();
				rs = statement.executeQuery(query);
			while(rs.next()){
					HierarchyValue hv =new HierarchyValue();
					hv.setId(rs.getInt("id")) ;
					Integer parentId = rs.getInt("parent_id");
					if(parentId == 0){
						parentId = null;
			}
					hv.setParentId(parentId) ;
					hv.setHierarchyId(rs.getInt("hierarchy_id"));
					hv.setValue(rs.getString("value")) ;
					hierarchyList.add(hv);
				}
				//e.printStackTrace();
			}finally {
				if (rs != null) {
			rs.close();
				}
				if (statement != null) {
					statement.close();
				}
				if(conn != null){
				conn.close();
				}
			}
		} else
		logger.warn("Null value for organization Id");
		return hierarchyList;
	}
	private ArrayList<String> prepareHierarchy(String token) throws Exception{
		logger.info("Token in 'prepareHierarchy' :"+token);
		ArrayList<String> hrc=new ArrayList<>();

			int orgId = SubscriptionQuerryHandler.getOrganizationId(token);
		String[] splited = token.split("\\|");
		String username = splited[0];
		int userRoeId = SecurityQuerryHandler.getRoleIdByUserNameAndOrganizationId(username, orgId);
		int pollingStationInspectorRoleId = SecurityQuerryHandler.getPollingStationInspectorRoleIdByOrganizationId(orgId);
		List<PollingStation> pollingStationList = null;
		if (userRoeId == pollingStationInspectorRoleId) {
			int userId = SecurityQuerryHandler.getUserId(token,orgId);
			pollingStationList = PsmQuerryHandler.findPollingStationIdListByUserId(userId);
		}
			logger.info("Organization Id in 'prepareHierarchy': "+orgId);
			List<Hierarchy> hierarchyList = findHierarchyByOrganizationId(orgId);
			Map<Integer,Integer> sortOrderMap = new HashMap<Integer,Integer>();
			for(Hierarchy h:hierarchyList){
				sortOrderMap.put(h.getId(), h.getSortorder());
			}
			List<HierarchyValue> hierarchyValueList = findHierarchyValueByOrganizationId(orgId);
		List<HierarchyValue> filteredHhierarchyValueList = new ArrayList<HierarchyValue>();
		if (pollingStationList != null && pollingStationList.size() > 0) {
			List<HierarchyValue> psHhierarchyValueList = new ArrayList<HierarchyValue>();
		for (PollingStation ps : pollingStationList) {
			for(HierarchyValue hv:hierarchyValueList){
				if (ps.getHierarchyValueId().intValue() == hv.getId().intValue()) {
						psHhierarchyValueList.add(hv);
					break;
				}
			}

				}
			for(HierarchyValue t:psHhierarchyValueList){
				List<HierarchyValue> temp = traverse(hierarchyValueList, t);
				filteredHhierarchyValueList.addAll(temp);
			}


			hrc.addAll(getAllChildrenList( filteredHhierarchyValueList, sortOrderMap));
		} else {
			hrc.addAll(getAllChildrenList( hierarchyValueList, sortOrderMap));
		}
		return hrc;
	}
	public List<HierarchyValue> traverse(List<HierarchyValue> hierarchyValueList,HierarchyValue probe){
		List<HierarchyValue> list = new ArrayList<HierarchyValue>();
		do{
			if(!list.contains(probe)){
				list.add(probe);
						}
			if( probe.getParentId() != null){
				Integer nextProbeId = probe.getParentId();

				for(HierarchyValue hv:hierarchyValueList){
					if(hv.getId().intValue() == nextProbeId.intValue()){
						probe = hv;
						break;
					}
				}
			}else{
				probe = null;
			}
		}while(probe != null);
		List<HierarchyValue> tempReverse = new ArrayList<HierarchyValue>();
					for (int i = list.size() - 2; i >= 0; i--) {

						tempReverse.add(list.get(i));
		}
		return tempReverse;
	}
	private ArrayList<String> getAllChildrenList( List<HierarchyValue> hierarchyValueList,
			Map<Integer, Integer> sortOrderMap) {
		ArrayList<String> hrc=new ArrayList<>();
		List<Integer> order = new ArrayList<Integer>();
		for(HierarchyValue hv: hierarchyValueList){

			if (!order.contains(hv.getId())) {
				String hrcName = null;
				if (hv.getParentId() == null) {
					hrcName = hv.getValue();
				}
				else{
					int sortIndex = sortOrderMap.get(hv.getHierarchyId());
					hrcName = String.format("%" + sortIndex + "s", "").replace(' ', '-')
							+ hv.getValue();
				}
				hrc.add(hrcName + "|" + hv.getId());
				order.add(hv.getId());
			}



				for (HierarchyValue hv1 : hierarchyValueList) {
					if (order.contains(hv1.getId())) {
						continue;
					} else {
						if (hv1.getParentId() != null && hv1.getParentId().intValue() == hv.getId().intValue()) {
							int sortIndex = sortOrderMap.get(hv1.getHierarchyId());
							String hrcName = String.format("%" + sortIndex + "s", "").replace(' ', '-')
									+ hv1.getValue();
							hrc.add(hrcName + "|" + hv1.getId());
							order.add(hv1.getId());
							hv= hv1;
							break;
						}
					}
				}

		}
		return hrc;
	}
}
