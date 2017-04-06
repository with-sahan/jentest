package com.mdl.mdlrestapi.psm.dao.impl;

import com.mdl.mdlrestapi.psm.dao.GeoHierarchyDao;
import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.util.database.DatabaseConnectionManager;
import com.mdl.mdlrestapi.util.database.psm.PsmQuerryHandler;
import com.mdl.mdlrestapi.util.database.psm.entities.Hierarchy;
import com.mdl.mdlrestapi.util.database.psm.entities.HierarchyValue;
import com.mdl.mdlrestapi.util.database.psm.entities.PollingStation;
import com.mdl.mdlrestapi.util.database.security.SecurityQuerryHandler;
import com.mdl.mdlrestapi.util.database.subscription.SubscriptionQuerryHandler;
import org.apache.log4j.Logger;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by lasantha on 3/8/2017.
 */
public class GeoHierarchyDaoImpl implements GeoHierarchyDao{
    private static final Logger logger = Logger.getLogger(GeoHierarchyDaoImpl.class);

    //get the list of top gro hierarchy nodes

    //add the first node to the list
    //now get the complete hierarchy below this parent add add to the list

    public List<Hierarchy> findHierarchyByOrganizationId(Integer orgId) throws MDLDBException {
        List<Hierarchy> hierarchyList = new ArrayList<Hierarchy>();
        if (orgId != null && orgId > 0) {
            String query = "SELECT * FROM psm.hierarchy where organization_id=?;";
            try (Connection conn = DatabaseConnectionManager.getConnection();
                PreparedStatement statement = conn.prepareStatement(query)) {
                statement.setInt(1, orgId);
                try (ResultSet rs = statement.executeQuery()) {
                    while (rs.next()) {
                        Hierarchy h = new Hierarchy();
                        h.setId(rs.getInt("id"));
                        h.setSortorder(rs.getInt("sortorder"));
                        hierarchyList.add(h);
                    }
                }
            } catch (SQLException | MDLDBException e) {
                logger.error("Error : "+ e.getMessage());
                throw new MDLDBException("DB Exception " + e.getMessage());
            }
        }
        return hierarchyList;
    }

    public List<HierarchyValue> findHierarchyValueByOrganizationId(Integer orgId) throws MDLDBException {
        List<HierarchyValue> hierarchyList = new ArrayList<HierarchyValue>();
        if(logger.isDebugEnabled()){
        logger.debug("Organzation Id in 'findHierarchyValueByOrganizationId' : " + orgId);
        }
        if (orgId != null && orgId > 0) {
            String query = "SELECT * FROM psm.hierarchy_value where organization_id=?;";
            try (Connection conn = DatabaseConnectionManager.getConnection();
                PreparedStatement statement = conn.prepareStatement(query)) {
                statement.setInt(1, orgId);
                try (ResultSet rs = statement.executeQuery()) {
                    while (rs.next()) {
                        HierarchyValue hv = new HierarchyValue();
                        hv.setId(rs.getInt("id"));
                        Integer parentId = rs.getInt("parent_id");
                        if (parentId == 0) {
                            parentId = null;
                        }
                        hv.setParentId(parentId);
                        hv.setHierarchyId(rs.getInt("hierarchy_id"));
                        hv.setValue(rs.getString("value"));
                        hierarchyList.add(hv);
                    }
                }
            } catch (SQLException | MDLDBException e)  {
                logger.error("Error : "+ e.getMessage());
                throw new MDLDBException("DB Exception " + e.getMessage());
            }
        } else {
            logger.warn("Null value for organization Id");
        }
        return hierarchyList;
    }
    public ArrayList<String> prepareHierarchy(String token) throws MDLDBException{

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
