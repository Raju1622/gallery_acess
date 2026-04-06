package com.bharatyatra.servlet;

import com.bharatyatra.dao.PackageDAO;
import com.bharatyatra.model.HolidayPackage;
import com.bharatyatra.util.DBUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;

@WebServlet("/")
public class HomeServlet extends HttpServlet {

    private final PackageDAO packageDAO = new PackageDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try (Connection conn = DBUtil.getConnection(getServletContext())) {
            List<HolidayPackage> featuredPackages = packageDAO.getFeaturedPackages(conn, 6);
            req.setAttribute("featuredPackages", featuredPackages);
            req.getRequestDispatcher("/WEB-INF/jsp/bharatyatra/home.jsp").forward(req, resp);
        } catch (Exception e) {
            req.setAttribute("error", "Unable to load packages: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/jsp/bharatyatra/home.jsp").forward(req, resp);
        }
    }
}
