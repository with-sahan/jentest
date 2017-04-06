package com.mdl.mdlrestapi.util.database.psm.entities;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 * The mapping class for the hierarchy database table.
 *
 */

public class Hierarchy implements Serializable {
	private static final long serialVersionUID = 1L;

	private Integer id;

	private Timestamp createdon;

	private String name;

	private Integer organizationId;

	private Integer parentId;

	private Integer sortorder;

	private Timestamp updatedon;

	public Hierarchy() {
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

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
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

	public Integer getSortorder() {
		return this.sortorder;
	}

	public void setSortorder(Integer sortorder) {
		this.sortorder = sortorder;
	}

	public Timestamp getUpdatedon() {
		return this.updatedon;
	}

	public void setUpdatedon(Timestamp updatedon) {
		this.updatedon = updatedon;
	}
}