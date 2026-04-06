package com.deshdarshan.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Optional;

import com.deshdarshan.model.AdminUser;

public class AdminDAO {

  public Optional<AdminUser> findByUsername(Connection conn, String username) throws SQLException {
    String sql = "SELECT admin_id, username, password_hash FROM admin_users WHERE username = ?";
    try (PreparedStatement ps = conn.prepareStatement(sql)) {
      ps.setString(1, username);
      try (ResultSet rs = ps.executeQuery()) {
        if (rs.next()) {
          AdminUser u = new AdminUser();
          u.setAdminId(rs.getInt("admin_id"));
          u.setUsername(rs.getString("username"));
          return Optional.of(u);
        }
      }
    }
    return Optional.empty();
  }

  public Optional<String> findPasswordHashByUsername(Connection conn, String username)
      throws SQLException {
    String sql = "SELECT password_hash FROM admin_users WHERE username = ?";
    try (PreparedStatement ps = conn.prepareStatement(sql)) {
      ps.setString(1, username);
      try (ResultSet rs = ps.executeQuery()) {
        if (rs.next()) {
          return Optional.of(rs.getString("password_hash"));
        }
      }
    }
    return Optional.empty();
  }
}
