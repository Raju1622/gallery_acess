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

@WebServlet("/package-details")
public class PackageDetailServlet extends HttpServlet {

    private final PackageDAO packageDAO = new PackageDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String packageIdStr = req.getParameter("id");

        if (packageIdStr == null || packageIdStr.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/packages");
            return;
        }

        try {
            int packageId = Integer.parseInt(packageIdStr);
            try (Connection conn = DBUtil.getConnection(getServletContext())) {
                HolidayPackage pkg = packageDAO.getPackageById(conn, packageId);
                if (pkg == null) {
                    resp.sendRedirect(req.getContextPath() + "/packages");
                    return;
                }
                req.setAttribute("package", pkg);
                req.getRequestDispatcher("/WEB-INF/jsp/bharatyatra/package-details.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            req.setAttribute("error", "Unable to load package details: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/jsp/bharatyatra/package-details.jsp").forward(req, resp);
        }
    }
}
