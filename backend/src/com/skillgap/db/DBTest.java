package com.skillgap.db;

import java.sql.Connection;
import java.sql.DatabaseMetaData;

public class DBTest {

    public static void main(String[] args) {
        try {
            Connection con = DBConnection.getConnection();

            if (con != null && !con.isClosed()) {
                System.out.println("✅ Connected Successfully!");

                DatabaseMetaData meta = con.getMetaData();
                System.out.println("DB Name: " + meta.getDatabaseProductName());
                System.out.println("DB Version: " + meta.getDatabaseProductVersion());

                con.close();
            } else {
                System.out.println("❌ Connection Failed");
            }

        } catch (Exception e) {
            System.out.println("❌ Error Occurred:");
            e.printStackTrace();
        }
    }
}
