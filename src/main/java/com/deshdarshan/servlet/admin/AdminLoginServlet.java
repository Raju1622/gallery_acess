package com.deshdarshan.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.util.Optional;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.deshdarshan.dao.AdminDAO;
import com.deshdarshan.model.AdminUser;
import com.deshdarshan.util.DBUtil;
import com.deshdarshan.util.PasswordUtil;

@WebServlet("/admin/login")
public class AdminLoginServlet extends HttpServlet {

  private final AdminDAO adminDAO = new AdminDAO();

  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    req.getRequestDispatcher("/WEB-INF/jsp/admin/login.jsp").forward(req, resp);
  }

  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    String username = req.getParameter("username");
    String password = req.getParameter("password");
    if (username == null || password == null || username.isBlank()) {
      req.setAttribute("error", "Enter username and password.");
      req.getRequestDispatcher("/WEB-INF/jsp/admin/login.jsp").forward(req, resp);
      return;
    }
    try (Connection conn = DBUtil.getConnection(getServletContext())) {
      Optional<String> hashOpt = adminDAO.findPasswordHashByUsername(conn, username.trim());
      if (hashOpt.isEmpty()) {
        req.setAttribute("error", "Invalid credentials.");
        req.getRequestDispatcher("/WEB-INF/jsp/admin/login.jsp").forward(req, resp);
        return;
      }
      String expected = hashOpt.get();
      String actual = PasswordUtil.sha256Hex(password);
      if (!expected.equalsIgnoreCase(actual)) {
        req.setAttribute("error", "Invalid credentials.");
        req.getRequestDispatcher("/WEB-INF/jsp/admin/login.jsp").forward(req, resp);
        return;
      }
      Optional<AdminUser> userOpt = adminDAO.findByUsername(conn, username.trim());
      if (userOpt.isEmpty()) {
        req.setAttribute("error", "Invalid credentials.");
        req.getRequestDispatcher("/WEB-INF/jsp/admin/login.jsp").forward(req, resp);
        return;
      }
      HttpSession session = req.getSession(true);
      session.setAttribute("adminUser", userOpt.get());
      resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
    } catch (Exception e) {
      req.setAttribute("error", "Database error: " + e.getMessage());
      req.getRequestDispatcher("/WEB-INF/jsp/admin/login.jsp").forward(req, resp);
    }
  }
}
