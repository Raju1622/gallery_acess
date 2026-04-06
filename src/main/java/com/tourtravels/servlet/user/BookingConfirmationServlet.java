package com.tourtravels.servlet.user;

import com.tourtravels.dao.BookingDAO;
import com.tourtravels.model.Booking;
import com.tourtravels.util.DBUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.util.Optional;

@WebServlet("/booking-confirmation")
public class BookingConfirmationServlet extends HttpServlet {

    private final BookingDAO bookingDAO = new BookingDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String bookingIdParam = req.getParameter("id");

        if (bookingIdParam == null || bookingIdParam.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }

        try (Connection conn = DBUtil.getConnection(getServletContext())) {
            int bookingId = Integer.parseInt(bookingIdParam);
            Optional<Booking> bookingOpt = bookingDAO.findById(conn, bookingId);

            if (bookingOpt.isEmpty()) {
                req.setAttribute("error", "Booking not found");
                resp.sendRedirect(req.getContextPath() + "/");
                return;
            }

            req.setAttribute("booking", bookingOpt.get());
            req.getRequestDispatcher("/WEB-INF/jsp/tour/booking-confirmation.jsp").forward(req, resp);

        } catch (Exception e) {
            req.setAttribute("error", "Error: " + e.getMessage());
            resp.sendRedirect(req.getContextPath() + "/");
        }
    }
}
