package com.tourtravels.servlet.admin;

import com.tourtravels.dao.AdminDAO;
import com.tourtravels.model.AdminUser;
import com.tourtravels.util.DBUtil;
import com.tourtravels.util.PasswordUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.util.Optional;

@WebServlet("/admin/login")
public class AdminLoginServlet extends HttpServlet {

    private final AdminDAO adminDAO = new AdminDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/jsp/admin/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        if (username == null || password == null || username.trim().isEmpty()) {
            req.setAttribute("error", "Please enter username and password");
            req.getRequestDispatcher("/WEB-INF/jsp/admin/login.jsp").forward(req, resp);
            return;
        }

        try (Connection conn = DBUtil.getConnection(getServletContext())) {
            Optional<String> hashOpt = adminDAO.findPasswordHashByUsername(conn, username.trim());

            if (hashOpt.isEmpty()) {
                req.setAttribute("error", "Invalid credentials");
                req.getRequestDispatcher("/WEB-INF/jsp/admin/login.jsp").forward(req, resp);
                return;
            }

            String expectedHash = hashOpt.get();
            String actualHash = PasswordUtil.sha256Hex(password);

            if (!expectedHash.equalsIgnoreCase(actualHash)) {
                req.setAttribute("error", "Invalid credentials");
                req.getRequestDispatcher("/WEB-INF/jsp/admin/login.jsp").forward(req, resp);
                return;
            }

            Optional<AdminUser> adminOpt = adminDAO.findByUsername(conn, username.trim());
            if (adminOpt.isEmpty()) {
                req.setAttribute("error", "Invalid credentials");
                req.getRequestDispatcher("/WEB-INF/jsp/admin/login.jsp").forward(req, resp);
                return;
            }

            HttpSession session = req.getSession(true);
            session.setAttribute("adminUser", adminOpt.get());
            resp.sendRedirect(req.getContextPath() + "/admin/dashboard");

        } catch (Exception e) {
            req.setAttribute("error", "Database error: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/jsp/admin/login.jsp").forward(req, resp);
        }
    }
}
