package com.mdl.mdlrestapi.util.database;

import org.apache.log4j.Logger;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.mdl.mdlrestapi.psm.exception.MDLDBException;


public class DatabaseConnectionManager {

    private static final Logger logger = Logger.getLogger(DatabaseConnectionManager.class);

    public static Connection getConnection() throws MDLDBException {
        Connection conn = null;

        Context initialContext = null;
        try {
            initialContext = new InitialContext();


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
            conn = dataSource.getConnection();
        } catch (NamingException | SQLException e) {
            logger.error(e.getMessage());
            throw new MDLDBException(e.getMessage());  //To change body of catch statement use File | Settings | File Templates.
        }
        return conn;
    }

    public static DataSource getDataSource() throws MDLDBException {

        Context initialContext = null;
        try {
            initialContext = new InitialContext();

            /**
             * Get Context object for all environment naming (JNDI), such as
             * Resources configured for this web application.
             */
            Context environmentContext = (Context) initialContext.lookup("java:comp/env");
            /**
             * Get the data source for the MySQL to request a connection.
             */
            DataSource dataSource = (DataSource) environmentContext.lookup("jdbc/mdldb");

            return dataSource;
        } catch (NamingException e) {
            logger.error(e.getMessage());
            throw new MDLDBException(e.getMessage());  //To change body of catch statement use File | Settings | File Templates.
        }
    }
}
