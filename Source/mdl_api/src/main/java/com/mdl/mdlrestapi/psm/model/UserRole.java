package com.mdl.mdlrestapi.psm.model;

/**
 * Created by AnushaP on 3/28/2017.
 */
public enum UserRole {
    PRESIDING_OFFICER(1,"Presiding Officer"),
    ELECTION_MANAGER(2, "Election Manager"),
    POLLING_STATION_INSPECTOR(3, "Polling Station Inspector"),
    ISSUE_RESOLVER(4, "Issue Resolver"),
    RETURNING_OFFICER(5, "Returning officer"),
    POLLING_CLERKS(6, "Polling clerks"),
    SUPER_ADMIN(7, "Super Admin");



    private int roleId;
    private String roleName;

    UserRole(int roleId, String roleName){
    this.roleId =  roleId;
    this.roleName = roleName;
    }

    public String getRoleName(){
        return roleName;
    }
    public int getRoleId(){
        return roleId;
    }

}
