package com.skillgap.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String URL =
        "jdbc:oracle:thin:@localhost:1521:ORCL";
    private static final String USER = "amith";
    private static final String PASSWORD = "123456789";

    static {
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            System.out.println("Oracle Driver Loaded");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Oracle Driver not found!", e);
        }
    }

    // 🔥 IMPORTANT: create NEW connection every time
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
