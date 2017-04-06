package com.mdl.mdlrestapi.psm.service.impl;

import com.mdl.mdlrestapi.psm.dao.GeoHierarchyDao;
import com.mdl.mdlrestapi.psm.dao.IssueDao;
import com.mdl.mdlrestapi.psm.dao.impl.GeoHierarchyDaoImpl;
import com.mdl.mdlrestapi.psm.dao.impl.IssueDaoImpl;
import com.mdl.mdlrestapi.psm.service.GeoHierarchyService;
import com.mdl.mdlrestapi.util.database.psm.entities.Hierarchy;
import com.mdl.mdlrestapi.util.models.UserDto;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by lasantha on 3/8/2017.
 */
public class GeoHierarchyServiceImpl implements GeoHierarchyService {
    GeoHierarchyDao geoHierarchyDao = new GeoHierarchyDaoImpl();

    public ArrayList<String> prepareHierarchy(String token) throws Exception{
        return geoHierarchyDao.prepareHierarchy(token);
    }
}
