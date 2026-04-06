package com.bharatyatra.dao;

import com.bharatyatra.model.HolidayPackage;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PackageDAO {

    public List<HolidayPackage> getAllPackages(Connection conn) throws SQLException {
        List<HolidayPackage> packages = new ArrayList<>();
        String sql = "SELECT p.*, c.category_name FROM holiday_packages p " +
                     "LEFT JOIN package_categories c ON p.category_id = c.category_id " +
                     "WHERE p.status = 'active' ORDER BY p.is_featured DESC, p.rating DESC";

        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                packages.add(extractPackageFromResultSet(rs));
            }
        }
        return packages;
    }

    public List<HolidayPackage> getFeaturedPackages(Connection conn, int limit) throws SQLException {
        List<HolidayPackage> packages = new ArrayList<>();
        String sql = "SELECT p.*, c.category_name FROM holiday_packages p " +
                     "LEFT JOIN package_categories c ON p.category_id = c.category_id " +
                     "WHERE p.is_featured = TRUE AND p.status = 'active' " +
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

    public HolidayPackage getPackageById(Connection conn, int packageId) throws SQLException {
        String sql = "SELECT p.*, c.category_name FROM holiday_packages p " +
                     "LEFT JOIN package_categories c ON p.category_id = c.category_id " +
                     "WHERE p.package_id = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, packageId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return extractPackageFromResultSet(rs);
                }
            }
        }
        return null;
    }

    public List<HolidayPackage> searchPackages(Connection conn, String destination, Integer categoryId) throws SQLException {
        List<HolidayPackage> packages = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT p.*, c.category_name FROM holiday_packages p " +
            "LEFT JOIN package_categories c ON p.category_id = c.category_id " +
            "WHERE p.status = 'active'"
        );

        if (destination != null && !destination.trim().isEmpty()) {
            sql.append(" AND (p.destination LIKE ? OR p.package_name LIKE ?)");
        }
        if (categoryId != null && categoryId > 0) {
            sql.append(" AND p.category_id = ?");
        }
        sql.append(" ORDER BY p.rating DESC");

        try (PreparedStatement stmt = conn.prepareStatement(sql.toString())) {
            int paramIndex = 1;
            if (destination != null && !destination.trim().isEmpty()) {
                String searchPattern = "%" + destination.trim() + "%";
                stmt.setString(paramIndex++, searchPattern);
                stmt.setString(paramIndex++, searchPattern);
            }
            if (categoryId != null && categoryId > 0) {
                stmt.setInt(paramIndex, categoryId);
            }

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    packages.add(extractPackageFromResultSet(rs));
                }
            }
        }
        return packages;
    }

    private HolidayPackage extractPackageFromResultSet(ResultSet rs) throws SQLException {
        HolidayPackage pkg = new HolidayPackage();
        pkg.setPackageId(rs.getInt("package_id"));
        pkg.setPackageName(rs.getString("package_name"));
        pkg.setCategoryId(rs.getInt("category_id"));
        pkg.setCategoryName(rs.getString("category_name"));
        pkg.setDestination(rs.getString("destination"));
        pkg.setDurationDays(rs.getInt("duration_days"));
        pkg.setDurationNights(rs.getInt("duration_nights"));
        pkg.setPricePerPerson(rs.getBigDecimal("price_per_person"));
        pkg.setDescription(rs.getString("description"));
        pkg.setHighlights(rs.getString("highlights"));
        pkg.setInclusions(rs.getString("inclusions"));
        pkg.setExclusions(rs.getString("exclusions"));
        pkg.setImageUrl(rs.getString("image_url"));
        pkg.setFeatured(rs.getBoolean("is_featured"));
        pkg.setRating(rs.getBigDecimal("rating"));
        pkg.setTotalReviews(rs.getInt("total_reviews"));
        pkg.setAvailableFrom(rs.getDate("available_from"));
        pkg.setAvailableTo(rs.getDate("available_to"));
        pkg.setStatus(rs.getString("status"));
        return pkg;
    }
}
