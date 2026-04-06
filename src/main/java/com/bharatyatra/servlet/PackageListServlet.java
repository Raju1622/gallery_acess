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

@WebServlet("/packages")
public class PackageListServlet extends HttpServlet {

    private final PackageDAO packageDAO = new PackageDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String destination = req.getParameter("destination");
        String categoryIdStr = req.getParameter("category");
        Integer categoryId = null;

        if (categoryIdStr != null && !categoryIdStr.isEmpty()) {
            try {
                categoryId = Integer.parseInt(categoryIdStr);
            } catch (NumberFormatException ignored) {}
        }

        try (Connection conn = DBUtil.getConnection(getServletContext())) {
            List<HolidayPackage> packages;
            if (destination != null || categoryId != null) {
                packages = packageDAO.searchPackages(conn, destination, categoryId);
            } else {
                packages = packageDAO.getAllPackages(conn);
            }
            req.setAttribute("packages", packages);
            req.setAttribute("searchDestination", destination);
            req.setAttribute("searchCategory", categoryId);
            req.getRequestDispatcher("/WEB-INF/jsp/bharatyatra/packages.jsp").forward(req, resp);
        } catch (Exception e) {
            req.setAttribute("error", "Unable to load packages: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/jsp/bharatyatra/packages.jsp").forward(req, resp);
        }
    }
}
