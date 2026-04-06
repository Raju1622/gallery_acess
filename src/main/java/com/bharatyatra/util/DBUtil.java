package com.bharatyatra.util;

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
            Properties props = new Properties();
            try (InputStream is = context.getResourceAsStream("/WEB-INF/bharatyatra-db.properties")) {
                if (is == null) {
                    throw new IOException("Database properties file not found");
                }
                props.load(is);
            }

            String driver = props.getProperty("jdbc.driver");
            String url = props.getProperty("jdbc.url");
            String username = props.getProperty("jdbc.username");
            String password = props.getProperty("jdbc.password");

            Class.forName(driver);
            return DriverManager.getConnection(url, username, password);
        } catch (ClassNotFoundException | IOException e) {
            throw new SQLException("Database connection error: " + e.getMessage(), e);
        }
    }
}
