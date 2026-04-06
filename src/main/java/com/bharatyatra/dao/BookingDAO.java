package com.bharatyatra.dao;

import com.bharatyatra.model.Booking;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {

    public int createBooking(Connection conn, Booking booking) throws SQLException {
        String sql = "INSERT INTO bookings (booking_reference, customer_id, package_id, travel_date, " +
                     "num_adults, num_children, total_price, special_requests) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, generateBookingReference());
            stmt.setInt(2, booking.getCustomerId());
            stmt.setInt(3, booking.getPackageId());
            stmt.setDate(4, booking.getTravelDate());
            stmt.setInt(5, booking.getNumAdults());
            stmt.setInt(6, booking.getNumChildren());
            stmt.setBigDecimal(7, booking.getTotalPrice());
            stmt.setString(8, booking.getSpecialRequests());

            int affected = stmt.executeUpdate();
            if (affected == 0) {
                throw new SQLException("Creating booking failed");
            }

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                } else {
                    throw new SQLException("Creating booking failed, no ID obtained");
                }
            }
        }
    }

    public Booking getBookingById(Connection conn, int bookingId) throws SQLException {
        String sql = "SELECT b.*, p.package_name, c.full_name, c.email, c.phone " +
                     "FROM bookings b " +
                     "LEFT JOIN holiday_packages p ON b.package_id = p.package_id " +
                     "LEFT JOIN customers c ON b.customer_id = c.customer_id " +
                     "WHERE b.booking_id = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, bookingId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return extractBookingFromResultSet(rs);
                }
            }
        }
        return null;
    }

    public List<Booking> getAllBookings(Connection conn) throws SQLException {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT b.*, p.package_name, c.full_name, c.email, c.phone " +
                     "FROM bookings b " +
                     "LEFT JOIN holiday_packages p ON b.package_id = p.package_id " +
                     "LEFT JOIN customers c ON b.customer_id = c.customer_id " +
                     "ORDER BY b.booking_date DESC";

        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                bookings.add(extractBookingFromResultSet(rs));
            }
        }
        return bookings;
    }

    public void updateBookingStatus(Connection conn, int bookingId, String status) throws SQLException {
        String sql = "UPDATE bookings SET booking_status = ? WHERE booking_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setInt(2, bookingId);
            stmt.executeUpdate();
        }
    }

    private String generateBookingReference() {
        return "BYT" + System.currentTimeMillis();
    }

    private Booking extractBookingFromResultSet(ResultSet rs) throws SQLException {
        Booking booking = new Booking();
        booking.setBookingId(rs.getInt("booking_id"));
        booking.setBookingReference(rs.getString("booking_reference"));
        booking.setCustomerId(rs.getInt("customer_id"));
        booking.setPackageId(rs.getInt("package_id"));
        booking.setTravelDate(rs.getDate("travel_date"));
        booking.setNumAdults(rs.getInt("num_adults"));
        booking.setNumChildren(rs.getInt("num_children"));
        booking.setTotalPrice(rs.getBigDecimal("total_price"));
        booking.setBookingStatus(rs.getString("booking_status"));
        booking.setPaymentStatus(rs.getString("payment_status"));
        booking.setSpecialRequests(rs.getString("special_requests"));
        booking.setBookingDate(rs.getTimestamp("booking_date"));
        booking.setPackageName(rs.getString("package_name"));
        booking.setCustomerName(rs.getString("full_name"));
        booking.setCustomerEmail(rs.getString("email"));
        booking.setCustomerPhone(rs.getString("phone"));
        return booking;
    }
}
