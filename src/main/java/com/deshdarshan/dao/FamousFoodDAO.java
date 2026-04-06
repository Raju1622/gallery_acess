package com.deshdarshan.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import com.deshdarshan.model.FamousFood;

public class FamousFoodDAO {

  public List<FamousFood> findByStateId(Connection conn, int stateId) throws SQLException {
    String sql =
        "SELECT food_id, state_id, food_name, description FROM famous_foods WHERE state_id = ? ORDER BY food_name";
    try (PreparedStatement ps = conn.prepareStatement(sql)) {
      ps.setInt(1, stateId);
      try (ResultSet rs = ps.executeQuery()) {
        List<FamousFood> list = new ArrayList<>();
        while (rs.next()) {
          list.add(mapRow(rs));
        }
        return list;
      }
    }
  }

  public Optional<FamousFood> findById(Connection conn, int foodId) throws SQLException {
    String sql = "SELECT food_id, state_id, food_name, description FROM famous_foods WHERE food_id = ?";
    try (PreparedStatement ps = conn.prepareStatement(sql)) {
      ps.setInt(1, foodId);
      try (ResultSet rs = ps.executeQuery()) {
        if (rs.next()) {
          return Optional.of(mapRow(rs));
        }
      }
    }
    return Optional.empty();
  }

  public void insert(Connection conn, FamousFood f) throws SQLException {
    String sql = "INSERT INTO famous_foods (state_id, food_name, description) VALUES (?,?,?)";
    try (PreparedStatement ps = conn.prepareStatement(sql)) {
      ps.setInt(1, f.getStateId());
      ps.setString(2, f.getFoodName());
      ps.setString(3, emptyToNull(f.getDescription()));
      ps.executeUpdate();
    }
  }

  public void update(Connection conn, FamousFood f) throws SQLException {
    String sql = "UPDATE famous_foods SET state_id=?, food_name=?, description=? WHERE food_id=?";
    try (PreparedStatement ps = conn.prepareStatement(sql)) {
      ps.setInt(1, f.getStateId());
      ps.setString(2, f.getFoodName());
      ps.setString(3, emptyToNull(f.getDescription()));
      ps.setInt(4, f.getFoodId());
      ps.executeUpdate();
    }
  }

  public void delete(Connection conn, int foodId) throws SQLException {
    String sql = "DELETE FROM famous_foods WHERE food_id = ?";
    try (PreparedStatement ps = conn.prepareStatement(sql)) {
      ps.setInt(1, foodId);
      ps.executeUpdate();
    }
  }

  private static FamousFood mapRow(ResultSet rs) throws SQLException {
    FamousFood f = new FamousFood();
    f.setFoodId(rs.getInt("food_id"));
    f.setStateId(rs.getInt("state_id"));
    f.setFoodName(rs.getString("food_name"));
    f.setDescription(rs.getString("description"));
    return f;
  }

  private static String emptyToNull(String v) {
    return v == null || v.isBlank() ? null : v;
  }
}
