package com.deshdarshan.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import com.deshdarshan.model.State;

public class StateDAO {

  public List<State> findAll(Connection conn) throws SQLException {
    String sql = "SELECT state_id, state_name, capital, population, language, area, climate, description, image_url FROM state ORDER BY state_name";
    try (Statement st = conn.createStatement(); ResultSet rs = st.executeQuery(sql)) {
      List<State> list = new ArrayList<>();
      while (rs.next()) {
        list.add(mapRow(rs));
      }
      return list;
    }
  }

  public Optional<State> findById(Connection conn, int id) throws SQLException {
    String sql = "SELECT state_id, state_name, capital, population, language, area, climate, description, image_url FROM state WHERE state_id = ?";
    try (PreparedStatement ps = conn.prepareStatement(sql)) {
      ps.setInt(1, id);
      try (ResultSet rs = ps.executeQuery()) {
        if (rs.next()) {
          return Optional.of(mapRow(rs));
        }
      }
    }
    return Optional.empty();
  }

  public List<State> searchByName(Connection conn, String q) throws SQLException {
    if (q == null || q.isBlank()) {
      return findAll(conn);
    }
    String sql =
        "SELECT state_id, state_name, capital, population, language, area, climate, description, image_url FROM state WHERE LOWER(state_name) LIKE ? ORDER BY state_name";
    try (PreparedStatement ps = conn.prepareStatement(sql)) {
      ps.setString(1, "%" + q.trim().toLowerCase() + "%");
      try (ResultSet rs = ps.executeQuery()) {
        List<State> list = new ArrayList<>();
        while (rs.next()) {
          list.add(mapRow(rs));
        }
        return list;
      }
    }
  }

  public int insert(Connection conn, State s) throws SQLException {
    String sql =
        "INSERT INTO state (state_name, capital, population, language, area, climate, description, image_url) VALUES (?,?,?,?,?,?,?,?)";
    try (PreparedStatement ps =
        conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
      ps.setString(1, s.getStateName());
      ps.setString(2, s.getCapital());
      ps.setString(3, nullToEmpty(s.getPopulation()));
      ps.setString(4, nullToEmpty(s.getLanguage()));
      ps.setString(5, nullToEmpty(s.getArea()));
      ps.setString(6, nullToEmpty(s.getClimate()));
      ps.setString(7, nullToEmpty(s.getDescription()));
      ps.setString(8, emptyToNull(s.getImageUrl()));
      ps.executeUpdate();
      try (ResultSet keys = ps.getGeneratedKeys()) {
        if (keys.next()) {
          return keys.getInt(1);
        }
      }
    }
    throw new SQLException("No generated key");
  }

  public void update(Connection conn, State s) throws SQLException {
    String sql =
        "UPDATE state SET state_name=?, capital=?, population=?, language=?, area=?, climate=?, description=?, image_url=? WHERE state_id=?";
    try (PreparedStatement ps = conn.prepareStatement(sql)) {
      ps.setString(1, s.getStateName());
      ps.setString(2, s.getCapital());
      ps.setString(3, nullToEmpty(s.getPopulation()));
      ps.setString(4, nullToEmpty(s.getLanguage()));
      ps.setString(5, nullToEmpty(s.getArea()));
      ps.setString(6, nullToEmpty(s.getClimate()));
      ps.setString(7, nullToEmpty(s.getDescription()));
      ps.setString(8, emptyToNull(s.getImageUrl()));
      ps.setInt(9, s.getStateId());
      ps.executeUpdate();
    }
  }

  public void delete(Connection conn, int stateId) throws SQLException {
    String sql = "DELETE FROM state WHERE state_id = ?";
    try (PreparedStatement ps = conn.prepareStatement(sql)) {
      ps.setInt(1, stateId);
      ps.executeUpdate();
    }
  }

  private static State mapRow(ResultSet rs) throws SQLException {
    State s = new State();
    s.setStateId(rs.getInt("state_id"));
    s.setStateName(rs.getString("state_name"));
    s.setCapital(rs.getString("capital"));
    s.setPopulation(rs.getString("population"));
    s.setLanguage(rs.getString("language"));
    s.setArea(rs.getString("area"));
    s.setClimate(rs.getString("climate"));
    s.setDescription(rs.getString("description"));
    s.setImageUrl(rs.getString("image_url"));
    return s;
  }

  private static String nullToEmpty(String v) {
    return v == null ? "" : v;
  }

  private static String emptyToNull(String v) {
    return v == null || v.isBlank() ? null : v;
  }
}
