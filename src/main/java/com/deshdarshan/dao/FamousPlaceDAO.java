package com.deshdarshan.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import com.deshdarshan.model.FamousPlace;

public class FamousPlaceDAO {

  public List<FamousPlace> findByStateId(Connection conn, int stateId) throws SQLException {
    String sql =
        "SELECT place_id, state_id, place_name, description, image_url FROM famous_places WHERE state_id = ? ORDER BY place_name";
    try (PreparedStatement ps = conn.prepareStatement(sql)) {
      ps.setInt(1, stateId);
      try (ResultSet rs = ps.executeQuery()) {
        List<FamousPlace> list = new ArrayList<>();
        while (rs.next()) {
          list.add(mapRow(rs));
        }
        return list;
      }
    }
  }

  public Optional<FamousPlace> findById(Connection conn, int placeId) throws SQLException {
    String sql =
        "SELECT place_id, state_id, place_name, description, image_url FROM famous_places WHERE place_id = ?";
    try (PreparedStatement ps = conn.prepareStatement(sql)) {
      ps.setInt(1, placeId);
      try (ResultSet rs = ps.executeQuery()) {
        if (rs.next()) {
          return Optional.of(mapRow(rs));
        }
      }
    }
    return Optional.empty();
  }

  public void insert(Connection conn, FamousPlace p) throws SQLException {
    String sql = "INSERT INTO famous_places (state_id, place_name, description, image_url) VALUES (?,?,?,?)";
    try (PreparedStatement ps = conn.prepareStatement(sql)) {
      ps.setInt(1, p.getStateId());
      ps.setString(2, p.getPlaceName());
      ps.setString(3, emptyToNull(p.getDescription()));
      ps.setString(4, emptyToNull(p.getImageUrl()));
      ps.executeUpdate();
    }
  }

  public void update(Connection conn, FamousPlace p) throws SQLException {
    String sql =
        "UPDATE famous_places SET state_id=?, place_name=?, description=?, image_url=? WHERE place_id=?";
    try (PreparedStatement ps = conn.prepareStatement(sql)) {
      ps.setInt(1, p.getStateId());
      ps.setString(2, p.getPlaceName());
      ps.setString(3, emptyToNull(p.getDescription()));
      ps.setString(4, emptyToNull(p.getImageUrl()));
      ps.setInt(5, p.getPlaceId());
      ps.executeUpdate();
    }
  }

  public void delete(Connection conn, int placeId) throws SQLException {
    String sql = "DELETE FROM famous_places WHERE place_id = ?";
    try (PreparedStatement ps = conn.prepareStatement(sql)) {
      ps.setInt(1, placeId);
      ps.executeUpdate();
    }
  }

  private static FamousPlace mapRow(ResultSet rs) throws SQLException {
    FamousPlace p = new FamousPlace();
    p.setPlaceId(rs.getInt("place_id"));
    p.setStateId(rs.getInt("state_id"));
    p.setPlaceName(rs.getString("place_name"));
    p.setDescription(rs.getString("description"));
    p.setImageUrl(rs.getString("image_url"));
    return p;
  }

  private static String emptyToNull(String v) {
    return v == null || v.isBlank() ? null : v;
  }
}
