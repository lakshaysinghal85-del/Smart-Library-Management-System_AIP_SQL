
package com.library;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DB {

    private static final String URL =
            "jdbc:oracle:thin:@//localhost:1521/FREEPDB1";

    private static final String USER = "SYSTEM";

    // Enter your actual Oracle password here
    private static final String PASSWORD = "20160027969";

    public static Connection getConnection() throws SQLException {

        try {
            // Explicitly load the Oracle JDBC driver
            Class.forName("oracle.jdbc.OracleDriver");

            // Establish database connection
            return DriverManager.getConnection(URL, USER, PASSWORD);

        } catch (ClassNotFoundException e) {
            throw new SQLException(
                    "Oracle JDBC driver not found. Check Maven dependencies.", e);
        }
    }
}
