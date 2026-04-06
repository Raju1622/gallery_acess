package com.tourtravels.servlet.user;

import com.tourtravels.dao.PackageDAO;
import com.tourtravels.model.TourPackage;
import com.tourtravels.util.DBUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.util.Collections;
import java.util.List;

@WebServlet("/")
public class HomeServlet extends HttpServlet {

    private final PackageDAO packageDAO = new PackageDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try (Connection conn = DBUtil.getConnection(getServletContext())) {
            // Get featured packages for homepage
            List<TourPackage> featuredPackages = packageDAO.findFeatured(conn, 6);
            req.setAttribute("featuredPackages", featuredPackages);
        } catch (Exception e) {
            req.setAttribute("error", "Database error: " + e.getMessage());
            req.setAttribute("featuredPackages", Collections.emptyList());
        }
        req.getRequestDispatcher("/WEB-INF/jsp/tour/home.jsp").forward(req, resp);
    }
}
