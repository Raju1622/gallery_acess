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
import java.util.Optional;

@WebServlet("/package")
public class PackageDetailServlet extends HttpServlet {

    private final PackageDAO packageDAO = new PackageDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String idParam = req.getParameter("id");

        if (idParam == null || idParam.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/packages");
            return;
        }

        try (Connection conn = DBUtil.getConnection(getServletContext())) {
            int packageId = Integer.parseInt(idParam);
            Optional<TourPackage> packageOpt = packageDAO.findById(conn, packageId);

            if (packageOpt.isPresent()) {
                req.setAttribute("package", packageOpt.get());
                req.getRequestDispatcher("/WEB-INF/jsp/tour/package-detail.jsp").forward(req, resp);
            } else {
                resp.sendRedirect(req.getContextPath() + "/packages");
            }
        } catch (Exception e) {
            req.setAttribute("error", "Error loading package: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/jsp/tour/package-detail.jsp").forward(req, resp);
        }
    }
}
