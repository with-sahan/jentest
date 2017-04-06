package com.mdl.mdlrestapi.psm.utils;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;

import javax.ws.rs.core.HttpHeaders;
import javax.xml.bind.DatatypeConverter;
import java.util.Date;
import java.util.List;
import java.util.Properties;
import org.apache.log4j.Logger;

import com.mdl.mdlrestapi.psm.exception.MDLServiceException;


/**
 * Created with IntelliJ IDEA.
 * User: AnushaP
 * Date: 2/16/17
 * Time: 5:18 PM
 * To change this template use File | Settings | File Templates.
 */
public class SecurityUtility {
    private static final Logger logger = Logger.getLogger(SecurityUtility.class);

    public static long getCurrentMilliseconds(){
        return System.currentTimeMillis();
    }

    public static String generateToken(JWTClaims jwtClaims) throws MDLServiceException{
        String jwt;
        try {
            jwt = Jwts.builder()
                    .setSubject(jwtClaims.getSubject())
                    .setIssuer("DML")
                    .claim("name",jwtClaims.getName())
                    .claim("roleId",jwtClaims.getRoleId())
                    .claim("organization",jwtClaims.getOrganization())
                    .setExpiration(new Date(jwtClaims.getExpiration() + ConfigUtil.EXPIRE_TIME))
                    .signWith(
                            SignatureAlgorithm.HS256,
                            getKeySecretBytes()
                    )
                    .compact();
        } catch (Exception e) {
            throw new MDLServiceException(ErrorCodes.JWT_CREATION_FAIL);
        }
        return jwt;

    }
    private static  byte[] getKeySecretBytes(){
        return DatatypeConverter.parseBase64Binary(ConfigUtil.SECRET_KEY);
    }
    public static JWTClaims validateJWTAndGetClaims(String token) throws MDLServiceException {
        JWTClaims jwtClaims = null;
        Claims claims ;
        try{
            claims = Jwts.parser()
                    .setSigningKey(getKeySecretBytes())
                    .parseClaimsJws(token).getBody();
            jwtClaims = new JWTClaims() ;
            jwtClaims.setIssuer(claims.getIssuer());
            jwtClaims.setName((String)claims.get("name"));
            jwtClaims.setOrganization((String)claims.get("organization"));
            jwtClaims.setRoleId((Integer) claims.get("roleId"));
            jwtClaims.setExpiration(claims.getExpiration().getTime());
        }catch (Exception e)   {
            throw new MDLServiceException(ErrorCodes.JWT_VALIDATION_FAIL);
        }
        return jwtClaims;
    }

    public static String getUsernameAndOrganization(HttpHeaders headers) throws MDLServiceException {
        String token = getJWTTokenFromHeaders(headers);
        JWTClaims jwtClaims = validateJWTAndGetClaims(token);
        return jwtClaims.getName() + "|" + jwtClaims.getOrganization() + "|";
    }

    private static String getJWTTokenFromHeaders(HttpHeaders headers) throws MDLServiceException {
        List<String> authHeader = headers.getRequestHeader(HttpHeaders.AUTHORIZATION);
        if (authHeader != null && !authHeader.isEmpty()) {
            String token = authHeader.get(0);
            if (!token.contains("Bearer") || token.split(" ").length != 2) {
                throw new MDLServiceException(ErrorCodes.INCORRECT_HEADER);
            }
            return token.split(" ")[1].trim();
        } else {
            throw new MDLServiceException(ErrorCodes.INCORRECT_HEADER);
        }
    }
}
