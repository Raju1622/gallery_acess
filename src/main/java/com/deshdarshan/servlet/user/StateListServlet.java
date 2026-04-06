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

@WebServlet("/states")
public class StateListServlet extends HttpServlet {

  private final StateDAO stateDAO = new StateDAO();

  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    try (Connection conn = DBUtil.getConnection(getServletContext())) {
      List<State> states = stateDAO.findAll(conn);
      req.setAttribute("states", states);
    } catch (Exception e) {
      req.setAttribute("dbError", e.getMessage());
    }
    req.getRequestDispatcher("/WEB-INF/jsp/states.jsp").forward(req, resp);
  }
}
