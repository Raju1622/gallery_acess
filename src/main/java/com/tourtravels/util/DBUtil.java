package com.tourtravels.util;

import javax.servlet.ServletContext;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DBUtil {

    public static Connection getConnection(ServletContext context) throws SQLException {
        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Load database properties
            Properties props = new Properties();
            try (InputStream in = context.getResourceAsStream("/WEB-INF/db.properties")) {
                if (in != null) {
                    props.load(in);
                }
            } catch (IOException e) {
                throw new SQLException("Could not load db.properties", e);
            }

            String url = props.getProperty("jdbc.url", "jdbc:mysql://localhost:3306/tour_travels?useSSL=false&serverTimezone=UTC");
            String username = props.getProperty("jdbc.username", "root");
            String password = props.getProperty("jdbc.password", "");

            return DriverManager.getConnection(url, username, password);

        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL JDBC Driver not found", e);
        }
    }
}
