package com.mdl.mdlrestapi.util;

public final class TokenValidation {
	public static boolean ValidateToken(String token){
		 if ( token == null || token.isEmpty()){
	            return false;
	        }
	        return true;
	}

	public static String GetUserName(String token){
		return "";
	}
	
	public static String GetOrganizationCode(String token){
		return "";
	}
}
