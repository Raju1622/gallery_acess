package com.deshdarshan.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.deshdarshan.dao.StateDAO;
import com.deshdarshan.model.State;
import com.deshdarshan.util.DBUtil;

@WebServlet("/search")
public class SearchServlet extends HttpServlet {

  private final StateDAO stateDAO = new StateDAO();

  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    String q = req.getParameter("q");
    req.setAttribute("query", q == null ? "" : q);
    try (Connection conn = DBUtil.getConnection(getServletContext())) {
      List<State> results = stateDAO.searchByName(conn, q == null ? "" : q);
      req.setAttribute("states", results);
    } catch (Exception e) {
      req.setAttribute("dbError", e.getMessage());
    }
    req.getRequestDispatcher("/WEB-INF/jsp/search-results.jsp").forward(req, resp);
  }
}
