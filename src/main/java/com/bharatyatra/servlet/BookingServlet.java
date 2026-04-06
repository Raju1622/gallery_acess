package com.bharatyatra.servlet;

import com.bharatyatra.dao.BookingDAO;
import com.bharatyatra.dao.CustomerDAO;
import com.bharatyatra.dao.PackageDAO;
import com.bharatyatra.model.Booking;
import com.bharatyatra.model.Customer;
import com.bharatyatra.model.HolidayPackage;
import com.bharatyatra.util.DBUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.Date;

@WebServlet("/book-package")
public class BookingServlet extends HttpServlet {

    private final BookingDAO bookingDAO = new BookingDAO();
    private final CustomerDAO customerDAO = new CustomerDAO();
    private final PackageDAO packageDAO = new PackageDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String packageIdStr = req.getParameter("package_id");
        if (packageIdStr == null || packageIdStr.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/packages");
            return;
        }

        try {
            int packageId = Integer.parseInt(packageIdStr);
            try (Connection conn = DBUtil.getConnection(getServletContext())) {
                HolidayPackage pkg = packageDAO.getPackageById(conn, packageId);
                if (pkg == null) {
                    resp.sendRedirect(req.getContextPath() + "/packages");
                    return;
                }
                req.setAttribute("package", pkg);
                req.getRequestDispatcher("/WEB-INF/jsp/bharatyatra/booking-form.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            req.setAttribute("error", "Unable to process booking: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/jsp/bharatyatra/booking-form.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            // Get customer details
            String fullName = req.getParameter("fullName");
            String email = req.getParameter("email");
            String phone = req.getParameter("phone");
            String address = req.getParameter("address");
            String city = req.getParameter("city");
            String state = req.getParameter("state");
            String pincode = req.getParameter("pincode");

            // Get booking details
            int packageId = Integer.parseInt(req.getParameter("packageId"));
            Date travelDate = Date.valueOf(req.getParameter("travelDate"));
            int numAdults = Integer.parseInt(req.getParameter("numAdults"));
            int numChildren = Integer.parseInt(req.getParameter("numChildren"));
            BigDecimal totalPrice = new BigDecimal(req.getParameter("totalPrice"));
            String specialRequests = req.getParameter("specialRequests");

            try (Connection conn = DBUtil.getConnection(getServletContext())) {
                conn.setAutoCommit(false);

                try {
                    // Create or get customer
                    Customer customer = customerDAO.getCustomerByEmail(conn, email);
                    if (customer == null) {
                        customer = new Customer();
                        customer.setFullName(fullName);
                        customer.setEmail(email);
                        customer.setPhone(phone);
                        customer.setAddress(address);
                        customer.setCity(city);
                        customer.setState(state);
                        customer.setPincode(pincode);
                        int customerId = customerDAO.createCustomer(conn, customer);
                        customer.setCustomerId(customerId);
                    }

                    // Create booking
                    Booking booking = new Booking();
                    booking.setCustomerId(customer.getCustomerId());
                    booking.setPackageId(packageId);
                    booking.setTravelDate(travelDate);
                    booking.setNumAdults(numAdults);
                    booking.setNumChildren(numChildren);
                    booking.setTotalPrice(totalPrice);
                    booking.setSpecialRequests(specialRequests);

                    int bookingId = bookingDAO.createBooking(conn, booking);
                    conn.commit();

                    resp.sendRedirect(req.getContextPath() + "/booking-confirmation?id=" + bookingId);
                } catch (Exception e) {
                    conn.rollback();
                    throw e;
                }
            }
        } catch (Exception e) {
            req.setAttribute("error", "Booking failed: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/jsp/bharatyatra/booking-form.jsp").forward(req, resp);
        }
    }
}
