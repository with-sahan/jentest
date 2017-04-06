package com.mdl.mdlrestapi.util.database.psm.entities;

/**
 * The mapping class for the polling_station database table.
 *
 */
public class PollingStation {
	private Integer id;
	private Integer hierarchyValueId;

	public final Integer getId() {
		return id;
	}
	public final void setId(Integer id) {
		this.id = id;
	}
	public final Integer getHierarchyValueId() {
		return hierarchyValueId;
	}
	public final void setHierarchyValueId(Integer hierarchyValueId) {
		this.hierarchyValueId = hierarchyValueId;
	}
}
