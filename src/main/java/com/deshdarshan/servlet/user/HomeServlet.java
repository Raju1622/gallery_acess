package com.deshdarshan.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.util.Collections;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.deshdarshan.dao.StateDAO;
import com.deshdarshan.model.State;
import com.deshdarshan.util.DBUtil;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {

  private final StateDAO stateDAO = new StateDAO();

  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    try (Connection conn = DBUtil.getConnection(getServletContext())) {
      List<State> all = stateDAO.findAll(conn);
      int n = Math.min(6, all.size());
      req.setAttribute("featuredStates", all.subList(0, n));
      req.setAttribute("totalStates", all.size());
    } catch (Exception e) {
      req.setAttribute("dbError", e.getMessage());
      req.setAttribute("featuredStates", Collections.emptyList());
      req.setAttribute("totalStates", 0);
    }
    req.getRequestDispatcher("/WEB-INF/jsp/home.jsp").forward(req, resp);
  }
}
