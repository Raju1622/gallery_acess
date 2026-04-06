package com.tourtravels.servlet.user;

import com.tourtravels.dao.BookingDAO;
import com.tourtravels.dao.CustomerDAO;
import com.tourtravels.dao.PackageDAO;
import com.tourtravels.model.Booking;
import com.tourtravels.model.Customer;
import com.tourtravels.model.TourPackage;
import com.tourtravels.util.DBUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.Date;
import java.util.Optional;

@WebServlet("/book")
public class BookingServlet extends HttpServlet {

    private final PackageDAO packageDAO = new PackageDAO();
    private final CustomerDAO customerDAO = new CustomerDAO();
    private final BookingDAO bookingDAO = new BookingDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String packageIdParam = req.getParameter("id");

        if (packageIdParam == null || packageIdParam.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/packages");
            return;
        }

        try (Connection conn = DBUtil.getConnection(getServletContext())) {
            int packageId = Integer.parseInt(packageIdParam);
            Optional<TourPackage> pkgOpt = packageDAO.findById(conn, packageId);

            if (pkgOpt.isEmpty()) {
                req.setAttribute("error", "Package not found");
                resp.sendRedirect(req.getContextPath() + "/packages");
                return;
            }

            req.setAttribute("package", pkgOpt.get());
            req.getRequestDispatcher("/WEB-INF/jsp/tour/booking-form.jsp").forward(req, resp);

        } catch (Exception e) {
            req.setAttribute("error", "Error: " + e.getMessage());
            resp.sendRedirect(req.getContextPath() + "/packages");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try (Connection conn = DBUtil.getConnection(getServletContext())) {
            // Get package details
            int packageId = Integer.parseInt(req.getParameter("packageId"));
            Optional<TourPackage> pkgOpt = packageDAO.findById(conn, packageId);

            if (pkgOpt.isEmpty()) {
                req.setAttribute("error", "Package not found");
                resp.sendRedirect(req.getContextPath() + "/packages");
                return;
            }

            TourPackage pkg = pkgOpt.get();

            // Get customer details
            String fullName = req.getParameter("fullName");
            String email = req.getParameter("email");
            String phone = req.getParameter("phone");
            String address = req.getParameter("address");
            String city = req.getParameter("city");
            String state = req.getParameter("state");
            String country = req.getParameter("country");

            // Validate required fields
            if (fullName == null || email == null || phone == null ||
                fullName.trim().isEmpty() || email.trim().isEmpty() || phone.trim().isEmpty()) {
                req.setAttribute("error", "Please fill all required fields");
                req.setAttribute("package", pkg);
                req.getRequestDispatcher("/WEB-INF/jsp/tour/booking-form.jsp").forward(req, resp);
                return;
            }

            // Check if customer exists or create new
            int customerId;
            Optional<Customer> existingCustomer = customerDAO.findByEmail(conn, email);

            if (existingCustomer.isPresent()) {
                customerId = existingCustomer.get().getCustomerId();
            } else {
                Customer newCustomer = new Customer();
                newCustomer.setFullName(fullName);
                newCustomer.setEmail(email);
                newCustomer.setPhone(phone);
                newCustomer.setAddress(address);
                newCustomer.setCity(city);
                newCustomer.setState(state);
                newCustomer.setCountry(country != null && !country.isEmpty() ? country : "India");
                customerId = customerDAO.insert(conn, newCustomer);
            }

            // Get booking details
            Date travelDate = Date.valueOf(req.getParameter("travelDate"));
            int numAdults = Integer.parseInt(req.getParameter("numAdults"));
            int numChildren = req.getParameter("numChildren") != null && !req.getParameter("numChildren").isEmpty()
                            ? Integer.parseInt(req.getParameter("numChildren")) : 0;
            String specialRequests = req.getParameter("specialRequests");

            // Calculate total amount
            BigDecimal totalAmount = pkg.getPrice().multiply(new BigDecimal(numAdults + numChildren));

            // Create booking
            Booking booking = new Booking();
            booking.setPackageId(packageId);
            booking.setCustomerId(customerId);
            booking.setBookingDate(new Date(System.currentTimeMillis()));
            booking.setTravelDate(travelDate);
            booking.setNumAdults(numAdults);
            booking.setNumChildren(numChildren);
            booking.setTotalAmount(totalAmount);
            booking.setPaymentStatus("pending");
            booking.setBookingStatus("pending");
            booking.setSpecialRequests(specialRequests);

            int bookingId = bookingDAO.insert(conn, booking);

            // Redirect to confirmation page
            resp.sendRedirect(req.getContextPath() + "/booking-confirmation?id=" + bookingId);

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Booking failed: " + e.getMessage());
            resp.sendRedirect(req.getContextPath() + "/packages");
        }
    }
}
