package com.tourtravels.dao;

import com.tourtravels.model.TourPackage;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class PackageDAO {

    public List<TourPackage> findAll(Connection conn) throws SQLException {
        List<TourPackage> packages = new ArrayList<>();
        String sql = "SELECT p.*, c.category_name FROM tour_packages p " +
                    "LEFT JOIN package_categories c ON p.category_id = c.category_id " +
                    "WHERE p.is_active = TRUE ORDER BY p.is_featured DESC, p.created_at DESC";

        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                packages.add(extractPackageFromResultSet(rs));
            }
        }
        return packages;
    }

    public List<TourPackage> findFeatured(Connection conn, int limit) throws SQLException {
        List<TourPackage> packages = new ArrayList<>();
        String sql = "SELECT p.*, c.category_name FROM tour_packages p " +
                    "LEFT JOIN package_categories c ON p.category_id = c.category_id " +
                    "WHERE p.is_featured = TRUE AND p.is_active = TRUE " +
                    "ORDER BY p.rating DESC LIMIT ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, limit);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    packages.add(extractPackageFromResultSet(rs));
                }
            }
        }
        return packages;
    }

    public Optional<TourPackage> findById(Connection conn, int packageId) throws SQLException {
        String sql = "SELECT p.*, c.category_name FROM tour_packages p " +
                    "LEFT JOIN package_categories c ON p.category_id = c.category_id " +
                    "WHERE p.package_id = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, packageId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return Optional.of(extractPackageFromResultSet(rs));
                }
            }
        }
        return Optional.empty();
    }

    public List<TourPackage> findByCategory(Connection conn, int categoryId) throws SQLException {
        List<TourPackage> packages = new ArrayList<>();
        String sql = "SELECT p.*, c.category_name FROM tour_packages p " +
                    "LEFT JOIN package_categories c ON p.category_id = c.category_id " +
                    "WHERE p.category_id = ? AND p.is_active = TRUE " +
                    "ORDER BY p.rating DESC";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, categoryId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    packages.add(extractPackageFromResultSet(rs));
                }
            }
        }
        return packages;
    }

    public List<TourPackage> search(Connection conn, String keyword) throws SQLException {
        List<TourPackage> packages = new ArrayList<>();
        String sql = "SELECT p.*, c.category_name FROM tour_packages p " +
                    "LEFT JOIN package_categories c ON p.category_id = c.category_id " +
                    "WHERE (p.package_name LIKE ? OR p.destination LIKE ? OR p.description LIKE ?) " +
                    "AND p.is_active = TRUE ORDER BY p.rating DESC";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            String searchTerm = "%" + keyword + "%";
            stmt.setString(1, searchTerm);
            stmt.setString(2, searchTerm);
            stmt.setString(3, searchTerm);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    packages.add(extractPackageFromResultSet(rs));
                }
            }
        }
        return packages;
    }

    private TourPackage extractPackageFromResultSet(ResultSet rs) throws SQLException {
        TourPackage pkg = new TourPackage();
        pkg.setPackageId(rs.getInt("package_id"));
        pkg.setCategoryId(rs.getInt("category_id"));
        pkg.setPackageName(rs.getString("package_name"));
        pkg.setDestination(rs.getString("destination"));
        pkg.setDurationDays(rs.getInt("duration_days"));
        pkg.setDurationNights(rs.getInt("duration_nights"));
        pkg.setPrice(rs.getBigDecimal("price"));
        pkg.setDescription(rs.getString("description"));
        pkg.setHighlights(rs.getString("highlights"));
        pkg.setInclusions(rs.getString("inclusions"));
        pkg.setExclusions(rs.getString("exclusions"));
        pkg.setImageUrl(rs.getString("image_url"));
        pkg.setRating(rs.getBigDecimal("rating"));
        pkg.setTotalReviews(rs.getInt("total_reviews"));
        pkg.setFeatured(rs.getBoolean("is_featured"));
        pkg.setActive(rs.getBoolean("is_active"));
        pkg.setCreatedAt(rs.getTimestamp("created_at"));
        pkg.setCategoryName(rs.getString("category_name"));
        return pkg;
    }
}
