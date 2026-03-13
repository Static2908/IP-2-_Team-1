package com.skillgap.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String URL = "jdbc:oracle:thin:@//localhost:1521/XEPDB1";
    private static final String USER = "amith";
    private static final String PASSWORD = "123456789";

    static {
        try {
            // Prefer modern class name first, then legacy alias for compatibility.
            Class.forName("oracle.jdbc.OracleDriver");
            System.out.println("Oracle JDBC driver loaded");
        } catch (ClassNotFoundException e) {
            try {
                Class.forName("oracle.jdbc.driver.OracleDriver");
                System.out.println("Oracle JDBC legacy driver loaded");
            } catch (ClassNotFoundException ignored) {
                // Do not fail class initialization; DriverManager may auto-load via JDBC SPI.
                System.err.println("Oracle JDBC driver class not preloaded. Will rely on DriverManager SPI.");
            }
        }
    }

    // IMPORTANT: create NEW connection every time
    public static Connection getConnection() throws SQLException {
        try {
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (SQLException e) {
            throw new SQLException("Failed to connect to Oracle DB at " + URL + " with user '" + USER + "'. " +
                    "Ensure ojdbc8.jar is present under WEB-INF/lib and DB is running.", e);
        }
    }
}
