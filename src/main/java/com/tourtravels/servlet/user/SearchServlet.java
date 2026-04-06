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

@WebServlet("/search")
public class SearchServlet extends HttpServlet {

    private final PackageDAO packageDAO = new PackageDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String query = req.getParameter("q");

        if (query == null || query.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/packages");
            return;
        }

        try (Connection conn = DBUtil.getConnection(getServletContext())) {
            List<TourPackage> results = packageDAO.search(conn, query.trim());
            req.setAttribute("packages", results);
            req.setAttribute("searchQuery", query);
            req.setAttribute("resultCount", results.size());
        } catch (Exception e) {
            req.setAttribute("error", "Search failed: " + e.getMessage());
            req.setAttribute("packages", Collections.emptyList());
            req.setAttribute("resultCount", 0);
        }

        req.getRequestDispatcher("/WEB-INF/jsp/tour/search-results.jsp").forward(req, resp);
    }
}
