package com.mdl.mdlrestapi.util.database.security.entities;

import java.io.Serializable;

public class User implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private Integer id;
	private Integer organizationId;
	private String firstName;
	private String lastName;
	private String email;

	public final Integer getId() {
		return id;
	}

	public final void setId(Integer id) {
		this.id = id;
	}
	
	public final Integer getOrganizationId() {
		return organizationId;
	}

	public final void setOrganizationId(Integer organizationId) {
		this.organizationId = organizationId;
	}

	public final String getFirstName() {
		return firstName;
	}

	public final void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public final String getLastName() {
		return lastName;
	}

	public final void setLastName(String lastName) {
		this.lastName = lastName;
	}
	
	public final String getEmail() {
		return email;
	}

	public final void setEmail(String email) {
		this.email = email;
	}
	

	
}
