package com.deshdarshan.servlet;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.deshdarshan.dao.StateDAO;
import com.deshdarshan.model.State;
import com.deshdarshan.util.DBUtil;

@WebServlet("/admin/states")
public class AdminStatesServlet extends HttpServlet {

  private final StateDAO stateDAO = new StateDAO();

  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    String isNew = req.getParameter("new");
    String editId = req.getParameter("edit");
    try (Connection conn = DBUtil.getConnection(getServletContext())) {
      if ("1".equals(isNew)) {
        req.setAttribute("state", new State());
        req.setAttribute("formTitle", "Add state");
        req.getRequestDispatcher("/WEB-INF/jsp/admin/state-form.jsp").forward(req, resp);
        return;
      }
      if (editId != null && !editId.isBlank()) {
        try {
          int id = Integer.parseInt(editId);
          java.util.Optional<State> opt = stateDAO.findById(conn, id);
          if (opt.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/admin/states?msg=notfound");
            return;
          }
          req.setAttribute("state", opt.get());
          req.setAttribute("formTitle", "Edit state");
        } catch (NumberFormatException e) {
          resp.sendRedirect(req.getContextPath() + "/admin/states");
          return;
        }
        req.getRequestDispatcher("/WEB-INF/jsp/admin/state-form.jsp").forward(req, resp);
        return;
      }
      req.setAttribute("states", stateDAO.findAll(conn));
    } catch (Exception e) {
      req.setAttribute("dbError", e.getMessage());
    }
    req.getRequestDispatcher("/WEB-INF/jsp/admin/states-list.jsp").forward(req, resp);
  }

  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
    String op = req.getParameter("op");
    String ctx = req.getContextPath();
    try (Connection conn = DBUtil.getConnection(getServletContext())) {
      if ("delete".equals(op)) {
        int id = Integer.parseInt(req.getParameter("stateId"));
        stateDAO.delete(conn, id);
        resp.sendRedirect(ctx + "/admin/states?msg=deleted");
        return;
      }
      if ("save".equals(op)) {
        State s = new State();
        String idStr = req.getParameter("stateId");
        if (idStr != null && !idStr.isBlank()) {
          s.setStateId(Integer.parseInt(idStr));
        }
        s.setStateName(req.getParameter("stateName"));
        s.setCapital(req.getParameter("capital"));
        s.setPopulation(req.getParameter("population"));
        s.setLanguage(req.getParameter("language"));
        s.setArea(req.getParameter("area"));
        s.setClimate(req.getParameter("climate"));
        s.setDescription(req.getParameter("description"));
        s.setImageUrl(req.getParameter("imageUrl"));
        if (s.getStateName() == null || s.getStateName().isBlank()
            || s.getCapital() == null || s.getCapital().isBlank()) {
          resp.sendRedirect(ctx + "/admin/states?msg=required");
          return;
        }
        if (s.getStateId() > 0) {
          stateDAO.update(conn, s);
          resp.sendRedirect(ctx + "/admin/states?msg=saved");
        } else {
          int newId = stateDAO.insert(conn, s);
          resp.sendRedirect(ctx + "/admin/states?msg=created&id=" + newId);
        }
        return;
      }
    } catch (Exception e) {
      resp.sendRedirect(ctx + "/admin/states?msg=error&detail=" + urlEncode(e.getMessage()));
      return;
    }
    resp.sendRedirect(ctx + "/admin/states");
  }

  private static String urlEncode(String s) {
    if (s == null) {
      return "";
    }
    try {
      return java.net.URLEncoder.encode(s.length() > 80 ? s.substring(0, 80) : s, java.nio.charset.StandardCharsets.UTF_8);
    } catch (Exception e) {
      return "";
    }
  }
}
