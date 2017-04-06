package com.mdl.mdlrestapi.psm.service;

import com.mdl.mdlrestapi.util.database.psm.entities.Hierarchy;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by lasantha on 3/8/2017.
 */
public interface GeoHierarchyService {
    public ArrayList<String> prepareHierarchy(String token) throws Exception;
}
