package com.tourtravels.dao;

import com.tourtravels.model.AdminUser;
import java.sql.*;
import java.util.Optional;

public class AdminDAO {

    public Optional<String> findPasswordHashByUsername(Connection conn, String username) throws SQLException {
        String sql = "SELECT password_hash FROM admin_users WHERE username = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, username);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return Optional.of(rs.getString("password_hash"));
                }
            }
        }
        return Optional.empty();
    }

    public Optional<AdminUser> findByUsername(Connection conn, String username) throws SQLException {
        String sql = "SELECT * FROM admin_users WHERE username = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, username);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    AdminUser admin = new AdminUser();
                    admin.setAdminId(rs.getInt("admin_id"));
                    admin.setUsername(rs.getString("username"));
                    admin.setPasswordHash(rs.getString("password_hash"));
                    admin.setFullName(rs.getString("full_name"));
                    admin.setEmail(rs.getString("email"));
                    admin.setCreatedAt(rs.getTimestamp("created_at"));
                    return Optional.of(admin);
                }
            }
        }
        return Optional.empty();
    }
}
