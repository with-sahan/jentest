package com.mdl.mdlrestapi.util.database.security.entities;

import java.io.Serializable;

public class Role implements Serializable{

	
	private static final long serialVersionUID = 1L;

	private Integer id;
	private String name;

	private Integer organizationId;

	public final Integer getId() {
		return id;
	}

	public final void setId(Integer id) {
		this.id = id;
	}

	public final String getName() {
		return name;
	}

	public final void setName(String name) {
		this.name = name;
	}

	public final Integer getOrganizationId() {
		return organizationId;
	}

	public final void setOrganizationId(Integer organizationId) {
		this.organizationId = organizationId;
	}



}
