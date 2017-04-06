package com.mdl.mdlrestapi.util.database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class DatabaseConnectionManager {

	public static Connection getConnection() throws Exception {
		Connection conn = null;

			Context initialContext = new InitialContext();

			/**
			 * Get Context object for all environment naming (JNDI), such as
			 * Resources configured for this web application.
			 */
		Context environmentContext = (Context) initialContext.lookup("java:comp/env");

			/**
			 * Get the data source for the MySQL to request a connection.
			 */
		DataSource dataSource = (DataSource) environmentContext.lookup("jdbc/mdldb");
			/**
			 * Request a Connection from the pool of connection threads.
			 */
			conn =  dataSource.getConnection();

			//e.printStackTrace();
		return conn;
	}
	
	public static void close(Connection conn) 
	{
		try 
		{
			conn.close();
		} 
		catch (SQLException e) 
		{
			e.printStackTrace();
		}
		
	}

	public static void close(PreparedStatement ps) 
	{
		try 
		{
			ps.close();
		} 
		catch (SQLException e) 
		{
			e.printStackTrace();
		}
		
	}

	public static void close(ResultSet rs) 
	{
		try 
		{
			rs.close();
		} 
		catch (SQLException e) 
		{
			e.printStackTrace();
		}
	}
	
}
