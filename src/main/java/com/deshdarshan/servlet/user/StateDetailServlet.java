package com.deshdarshan.servlet;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.deshdarshan.dao.FamousFoodDAO;
import com.deshdarshan.dao.FamousPlaceDAO;
import com.deshdarshan.dao.HiddenPlaceDAO;
import com.deshdarshan.dao.StateDAO;
import com.deshdarshan.model.State;
import com.deshdarshan.util.DBUtil;

@WebServlet("/state")
public class StateDetailServlet extends HttpServlet {

  private final StateDAO stateDAO = new StateDAO();
  private final FamousPlaceDAO famousPlaceDAO = new FamousPlaceDAO();
  private final HiddenPlaceDAO hiddenPlaceDAO = new HiddenPlaceDAO();
  private final FamousFoodDAO famousFoodDAO = new FamousFoodDAO();

  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    int id;
    try {
      id = Integer.parseInt(req.getParameter("id"));
    } catch (Exception e) {
      resp.sendRedirect(req.getContextPath() + "/states");
      return;
    }
    try (Connection conn = DBUtil.getConnection(getServletContext())) {
      java.util.Optional<State> opt = stateDAO.findById(conn, id);
      if (opt.isPresent()) {
        State s = opt.get();
        req.setAttribute("state", s);
        req.setAttribute("famousPlaces", famousPlaceDAO.findByStateId(conn, id));
        req.setAttribute("hiddenPlaces", hiddenPlaceDAO.findByStateId(conn, id));
        req.setAttribute("famousFoods", famousFoodDAO.findByStateId(conn, id));
      } else {
        req.setAttribute("notFound", true);
      }
    } catch (Exception e) {
      req.setAttribute("dbError", e.getMessage());
    }
    req.getRequestDispatcher("/WEB-INF/jsp/state-detail.jsp").forward(req, resp);
  }
}
