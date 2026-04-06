package com.tourtravels.servlet.user;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/contact")
public class ContactServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/jsp/tour/contact.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // Get form data
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        String subject = req.getParameter("subject");
        String message = req.getParameter("message");

        // In a production app, you would send email or save to database
        // For now, just show success message

        req.setAttribute("success", "Thank you for contacting us! We will get back to you soon.");
        req.getRequestDispatcher("/WEB-INF/jsp/tour/contact.jsp").forward(req, resp);
    }
}
