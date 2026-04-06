package com.tourtravels.dao;

import com.tourtravels.model.Booking;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class BookingDAO {

    public int insert(Connection conn, Booking booking) throws SQLException {
        String sql = "INSERT INTO bookings (package_id, customer_id, booking_date, travel_date, " +
                    "num_adults, num_children, total_amount, payment_status, booking_status, special_requests) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, booking.getPackageId());
            stmt.setInt(2, booking.getCustomerId());
            stmt.setDate(3, booking.getBookingDate());
            stmt.setDate(4, booking.getTravelDate());
            stmt.setInt(5, booking.getNumAdults());
            stmt.setInt(6, booking.getNumChildren());
            stmt.setBigDecimal(7, booking.getTotalAmount());
            stmt.setString(8, booking.getPaymentStatus());
            stmt.setString(9, booking.getBookingStatus());
            stmt.setString(10, booking.getSpecialRequests());

            int affectedRows = stmt.executeUpdate();

            if (affectedRows == 0) {
                throw new SQLException("Creating booking failed, no rows affected.");
            }

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                } else {
                    throw new SQLException("Creating booking failed, no ID obtained.");
                }
            }
        }
    }

    public Optional<Booking> findById(Connection conn, int bookingId) throws SQLException {
        String sql = "SELECT b.*, p.package_name, p.destination, c.full_name, c.email, c.phone " +
                    "FROM bookings b " +
                    "LEFT JOIN tour_packages p ON b.package_id = p.package_id " +
                    "LEFT JOIN customers c ON b.customer_id = c.customer_id " +
                    "WHERE b.booking_id = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, bookingId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return Optional.of(extractBookingFromResultSet(rs));
                }
            }
        }
        return Optional.empty();
    }

    public List<Booking> findAll(Connection conn) throws SQLException {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT b.*, p.package_name, p.destination, c.full_name, c.email, c.phone " +
                    "FROM bookings b " +
                    "LEFT JOIN tour_packages p ON b.package_id = p.package_id " +
                    "LEFT JOIN customers c ON b.customer_id = c.customer_id " +
                    "ORDER BY b.created_at DESC";

        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                bookings.add(extractBookingFromResultSet(rs));
            }
        }
        return bookings;
    }

    public List<Booking> findRecent(Connection conn, int limit) throws SQLException {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT b.*, p.package_name, p.destination, c.full_name, c.email, c.phone " +
                    "FROM bookings b " +
                    "LEFT JOIN tour_packages p ON b.package_id = p.package_id " +
                    "LEFT JOIN customers c ON b.customer_id = c.customer_id " +
                    "ORDER BY b.created_at DESC LIMIT ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, limit);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    bookings.add(extractBookingFromResultSet(rs));
                }
            }
        }
        return bookings;
    }

    private Booking extractBookingFromResultSet(ResultSet rs) throws SQLException {
        Booking booking = new Booking();
        booking.setBookingId(rs.getInt("booking_id"));
        booking.setPackageId(rs.getInt("package_id"));
        booking.setCustomerId(rs.getInt("customer_id"));
        booking.setBookingDate(rs.getDate("booking_date"));
        booking.setTravelDate(rs.getDate("travel_date"));
        booking.setNumAdults(rs.getInt("num_adults"));
        booking.setNumChildren(rs.getInt("num_children"));
        booking.setTotalAmount(rs.getBigDecimal("total_amount"));
        booking.setPaymentStatus(rs.getString("payment_status"));
        booking.setBookingStatus(rs.getString("booking_status"));
        booking.setSpecialRequests(rs.getString("special_requests"));
        booking.setCreatedAt(rs.getTimestamp("created_at"));

        // Additional fields from joins
        try {
            booking.setPackageName(rs.getString("package_name"));
            booking.setDestination(rs.getString("destination"));
            booking.setCustomerName(rs.getString("full_name"));
            booking.setCustomerEmail(rs.getString("email"));
            booking.setCustomerPhone(rs.getString("phone"));
        } catch (SQLException e) {
            // These fields might not exist in all queries
        }

        return booking;
    }
}
