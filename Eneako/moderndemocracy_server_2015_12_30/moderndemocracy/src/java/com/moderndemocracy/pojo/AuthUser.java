package com.moderndemocracy.pojo;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.anaeko.service.auth.User;
import com.anaeko.service.utils.HMACHeader;
import com.anaeko.utils.text.PasswordHash;

public class AuthUser implements User {

	protected static final Logger logger = LogManager.getLogger(AuthUser.class);

	@Override
	public String getAPIKey() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Timestamp getCreatedOn() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String getEncryption() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String getHomeURL() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int getId() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public String getLocale() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int getLoginCount() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public String getLoginName() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int getRole() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public String getSecret() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int getSessionTimeout() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Timestamp getUpdatedOn() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean hasValidSecret() {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public int incrementLoginCount() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public boolean isActive() {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public User setAPIKey(byte[] arg0) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public User setAPIKey(String arg0) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public User setCreatedOn(Timestamp arg0) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public User setCreatedOn(long arg0) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public User setEncryption(String arg0) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public User setEncryption(PasswordHash arg0) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public User setHomeURL(String arg0) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public User setId(int arg0) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public User setLocale(String arg0) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public User setLoginCount(int arg0) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public User setLoginName(String arg0) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public User setRole(int arg0) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public User setSecret(String arg0) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public User setSecret(String arg0, String arg1) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public User setSecret(String arg0, PasswordHash arg1) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void setSessionTimeout(int arg0) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public User setUpdatedOn(Timestamp arg0) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public User setUpdatedOn(long arg0) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean validateSecret(String arg0) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean validateSignature(HttpServletRequest arg0, HMACHeader arg1) {
		// TODO Auto-generated method stub
		return false;
	}


}
