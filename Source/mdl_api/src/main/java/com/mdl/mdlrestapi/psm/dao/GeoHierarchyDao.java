package com.mdl.mdlrestapi.psm.dao;

import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.util.database.psm.entities.Hierarchy;
import com.mdl.mdlrestapi.util.database.psm.entities.HierarchyValue;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by lasantha on 3/8/2017.
 */
public interface GeoHierarchyDao {

    /**
     * @param token
     * @return
     * @throws MDLDBException
     */
    public ArrayList<String> prepareHierarchy(String token) throws MDLDBException;

    /**
     * @param orgId
     * @return
     * @throws MDLDBException
     */
    public List<HierarchyValue> findHierarchyValueByOrganizationId(Integer orgId) throws MDLDBException;

    /**
     * @param hierarchyValueList
     * @param probe
     * @return
     */
    public List<HierarchyValue> traverse(List<HierarchyValue> hierarchyValueList,HierarchyValue probe);
}
