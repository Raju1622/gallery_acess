package com.deshdarshan.util;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

import javax.servlet.ServletContext;

public final class DBUtil {
  private static final Object LOCK = new Object();
  private static volatile Properties cached;

  private DBUtil() {}

  public static Connection getConnection(ServletContext ctx) throws SQLException, IOException {
    Properties p = loadProps(ctx);
    String url = p.getProperty("jdbc.url");
    String user = p.getProperty("jdbc.username");
    String pass = p.getProperty("jdbc.password", "");
    String driver = p.getProperty("jdbc.driver", "com.mysql.cj.jdbc.Driver");
    try {
      Class.forName(driver);
    } catch (ClassNotFoundException e) {
      throw new SQLException("JDBC driver not found: " + driver, e);
    }
    return DriverManager.getConnection(url, user, pass);
  }

  private static Properties loadProps(ServletContext ctx) throws IOException {
    if (cached != null) {
      return cached;
    }
    synchronized (LOCK) {
      if (cached != null) {
        return cached;
      }
      Properties p = new Properties();
      try (InputStream in = ctx.getResourceAsStream("/WEB-INF/db.properties")) {
        if (in == null) {
          throw new IOException(
              "Missing WEB-INF/db.properties. Copy db.properties.example and set MySQL credentials.");
        }
        p.load(in);
      }
      cached = p;
      return p;
    }
  }
}
