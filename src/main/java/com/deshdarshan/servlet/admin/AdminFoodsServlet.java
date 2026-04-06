package com.deshdarshan.servlet;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.deshdarshan.dao.FamousFoodDAO;
import com.deshdarshan.dao.StateDAO;
import com.deshdarshan.model.FamousFood;
import com.deshdarshan.util.DBUtil;

@WebServlet("/admin/foods")
public class AdminFoodsServlet extends HttpServlet {

  private final StateDAO stateDAO = new StateDAO();
  private final FamousFoodDAO famousFoodDAO = new FamousFoodDAO();

  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    int stateId = parseId(req.getParameter("stateId"), -1);
    if (stateId < 0) {
      resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
      return;
    }
    String edit = req.getParameter("edit");
    try (Connection conn = DBUtil.getConnection(getServletContext())) {
      if (stateDAO.findById(conn, stateId).isEmpty()) {
        resp.sendRedirect(req.getContextPath() + "/admin/dashboard?msg=notfound");
        return;
      }
      req.setAttribute("stateId", stateId);
      req.setAttribute("foods", famousFoodDAO.findByStateId(conn, stateId));
      if (edit != null) {
        FamousFood f = new FamousFood();
        f.setStateId(stateId);
        if (!"new".equals(edit)) {
          try {
            int fid = Integer.parseInt(edit);
            f = famousFoodDAO.findById(conn, fid).orElse(f);
          } catch (NumberFormatException ignored) {
          }
        }
        req.setAttribute("food", f);
        req.getRequestDispatcher("/WEB-INF/jsp/admin/food-form.jsp").forward(req, resp);
        return;
      }
    } catch (Exception e) {
      req.setAttribute("dbError", e.getMessage());
    }
    req.getRequestDispatcher("/WEB-INF/jsp/admin/foods-manage.jsp").forward(req, resp);
  }

  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
    String ctx = req.getContextPath();
    String op = req.getParameter("op");
    int stateId = parseId(req.getParameter("stateId"), -1);
    if (stateId < 0) {
      resp.sendRedirect(ctx + "/admin/dashboard");
      return;
    }
    try (Connection conn = DBUtil.getConnection(getServletContext())) {
      if ("delete".equals(op)) {
        int foodId = Integer.parseInt(req.getParameter("foodId"));
        famousFoodDAO.delete(conn, foodId);
        resp.sendRedirect(ctx + "/admin/foods?stateId=" + stateId + "&msg=deleted");
        return;
      }
      if ("save".equals(op)) {
        String name = req.getParameter("foodName");
        if (name == null || name.isBlank()) {
          resp.sendRedirect(ctx + "/admin/foods?stateId=" + stateId + "&msg=required");
          return;
        }
        FamousFood f = new FamousFood();
        String idStr = req.getParameter("foodId");
        if (idStr != null && !idStr.isBlank()) {
          f.setFoodId(Integer.parseInt(idStr));
        }
        f.setStateId(stateId);
        f.setFoodName(name);
        f.setDescription(req.getParameter("description"));
        if (f.getFoodId() > 0) {
          famousFoodDAO.update(conn, f);
        } else {
          famousFoodDAO.insert(conn, f);
        }
        resp.sendRedirect(ctx + "/admin/foods?stateId=" + stateId + "&msg=saved");
        return;
      }
    } catch (Exception e) {
      resp.sendRedirect(ctx + "/admin/foods?stateId=" + stateId + "&msg=error");
      return;
    }
    resp.sendRedirect(ctx + "/admin/foods?stateId=" + stateId);
  }

  private static int parseId(String s, int def) {
    if (s == null || s.isBlank()) {
      return def;
    }
    try {
      return Integer.parseInt(s.trim());
    } catch (NumberFormatException e) {
      return def;
    }
  }
}
