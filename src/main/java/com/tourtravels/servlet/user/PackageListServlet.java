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

@WebServlet("/packages")
public class PackageListServlet extends HttpServlet {

    private final PackageDAO packageDAO = new PackageDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try (Connection conn = DBUtil.getConnection(getServletContext())) {
            String categoryParam = req.getParameter("category");
            List<TourPackage> packages;

            if (categoryParam != null && !categoryParam.isEmpty()) {
                int categoryId = Integer.parseInt(categoryParam);
                packages = packageDAO.findByCategory(conn, categoryId);
            } else {
                packages = packageDAO.findAll(conn);
            }

            req.setAttribute("packages", packages);
        } catch (Exception e) {
            req.setAttribute("error", "Error loading packages: " + e.getMessage());
            req.setAttribute("packages", Collections.emptyList());
        }
        req.getRequestDispatcher("/WEB-INF/jsp/tour/packages.jsp").forward(req, resp);
    }
}
