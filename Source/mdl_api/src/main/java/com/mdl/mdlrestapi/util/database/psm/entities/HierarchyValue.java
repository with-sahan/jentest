package com.mdl.mdlrestapi.util.database.psm.entities;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 * The mapping class for the hierarchy_value database table.
 *
 */

public class HierarchyValue implements Serializable {
	private static final long serialVersionUID = 1L;


	private Integer id;

	private Timestamp createdon;

	private String geoShapeUrl;

	private Integer hierarchyId;

	private Timestamp lastupdatedon;

	private Integer organizationId;

	private Integer parentId;

	private String value;

	public HierarchyValue() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Timestamp getCreatedon() {
		return this.createdon;
	}

	public void setCreatedon(Timestamp createdon) {
		this.createdon = createdon;
	}

	public String getGeoShapeUrl() {
		return this.geoShapeUrl;
	}

	public void setGeoShapeUrl(String geoShapeUrl) {
		this.geoShapeUrl = geoShapeUrl;
	}

	public Integer getHierarchyId() {
		return this.hierarchyId;
	}

	public void setHierarchyId(Integer hierarchyId) {
		this.hierarchyId = hierarchyId;
	}

	public Timestamp getLastupdatedon() {
		return this.lastupdatedon;
	}

	public void setLastupdatedon(Timestamp lastupdatedon) {
		this.lastupdatedon = lastupdatedon;
	}

	public Integer getOrganizationId() {
		return this.organizationId;
	}

	public void setOrganizationId(Integer organizationId) {
		this.organizationId = organizationId;
	}

	public Integer getParentId() {
		return this.parentId;
	}

	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}

	public String getValue() {
		return this.value;
	}

	public void setValue(String value) {
		this.value = value;
	}

}
