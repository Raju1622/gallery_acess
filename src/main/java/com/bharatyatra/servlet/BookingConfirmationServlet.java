package com.bharatyatra.servlet;

import com.bharatyatra.dao.BookingDAO;
import com.bharatyatra.model.Booking;
import com.bharatyatra.util.DBUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;

@WebServlet("/booking-confirmation")
public class BookingConfirmationServlet extends HttpServlet {

    private final BookingDAO bookingDAO = new BookingDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String bookingIdStr = req.getParameter("id");

        if (bookingIdStr == null || bookingIdStr.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }

        try {
            int bookingId = Integer.parseInt(bookingIdStr);
            try (Connection conn = DBUtil.getConnection(getServletContext())) {
                Booking booking = bookingDAO.getBookingById(conn, bookingId);
                if (booking == null) {
                    resp.sendRedirect(req.getContextPath() + "/");
                    return;
                }
                req.setAttribute("booking", booking);
                req.getRequestDispatcher("/WEB-INF/jsp/bharatyatra/booking-confirmation.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            req.setAttribute("error", "Unable to load booking: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/jsp/bharatyatra/booking-confirmation.jsp").forward(req, resp);
        }
    }
}
