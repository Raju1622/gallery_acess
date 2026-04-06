package com.deshdarshan.servlet;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.deshdarshan.dao.FamousPlaceDAO;
import com.deshdarshan.dao.HiddenPlaceDAO;
import com.deshdarshan.dao.StateDAO;
import com.deshdarshan.model.FamousPlace;
import com.deshdarshan.model.HiddenPlace;
import com.deshdarshan.util.DBUtil;

@WebServlet("/admin/places")
public class AdminPlacesServlet extends HttpServlet {

  private final StateDAO stateDAO = new StateDAO();
  private final FamousPlaceDAO famousPlaceDAO = new FamousPlaceDAO();
  private final HiddenPlaceDAO hiddenPlaceDAO = new HiddenPlaceDAO();

  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    int stateId = parseId(req.getParameter("stateId"), -1);
    if (stateId < 0) {
      resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
      return;
    }
    String section = req.getParameter("section");
    String editFamous = req.getParameter("editFamous");
    String editHidden = req.getParameter("editHidden");
    try (Connection conn = DBUtil.getConnection(getServletContext())) {
      if (stateDAO.findById(conn, stateId).isEmpty()) {
        resp.sendRedirect(req.getContextPath() + "/admin/dashboard?msg=notfound");
        return;
      }
      req.setAttribute("stateId", stateId);
      req.setAttribute("famousPlaces", famousPlaceDAO.findByStateId(conn, stateId));
      req.setAttribute("hiddenPlaces", hiddenPlaceDAO.findByStateId(conn, stateId));
      if ("famous".equals(section) && editFamous != null) {
        FamousPlace fp = new FamousPlace();
        fp.setStateId(stateId);
        if (!"new".equals(editFamous)) {
          try {
            int pid = Integer.parseInt(editFamous);
            fp = famousPlaceDAO.findById(conn, pid).orElse(fp);
          } catch (NumberFormatException ignored) {
          }
        }
        req.setAttribute("famousPlace", fp);
        req.setAttribute("editSection", "famous");
        req.getRequestDispatcher("/WEB-INF/jsp/admin/place-form.jsp").forward(req, resp);
        return;
      }
      if ("hidden".equals(section) && editHidden != null) {
        HiddenPlace hp = new HiddenPlace();
        hp.setStateId(stateId);
        if (!"new".equals(editHidden)) {
          try {
            int pid = Integer.parseInt(editHidden);
            hp = hiddenPlaceDAO.findById(conn, pid).orElse(hp);
          } catch (NumberFormatException ignored) {
          }
        }
        req.setAttribute("hiddenPlace", hp);
        req.setAttribute("editSection", "hidden");
        req.getRequestDispatcher("/WEB-INF/jsp/admin/place-form.jsp").forward(req, resp);
        return;
      }
    } catch (Exception e) {
      req.setAttribute("dbError", e.getMessage());
    }
    req.getRequestDispatcher("/WEB-INF/jsp/admin/places-manage.jsp").forward(req, resp);
  }

  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
    String ctx = req.getContextPath();
    String op = req.getParameter("op");
    String type = req.getParameter("type");
    int stateId = parseId(req.getParameter("stateId"), -1);
    if (stateId < 0) {
      resp.sendRedirect(ctx + "/admin/dashboard");
      return;
    }
    try (Connection conn = DBUtil.getConnection(getServletContext())) {
      if ("delete".equals(op)) {
        String pidStr = req.getParameter("placeId");
        int placeId = Integer.parseInt(pidStr);
        if ("famous".equals(type)) {
          famousPlaceDAO.delete(conn, placeId);
        } else if ("hidden".equals(type)) {
          hiddenPlaceDAO.delete(conn, placeId);
        }
        resp.sendRedirect(ctx + "/admin/places?stateId=" + stateId + "&msg=deleted");
        return;
      }
      if ("save".equals(op)) {
        String placeIdStr = req.getParameter("placeId");
        String name = req.getParameter("placeName");
        if (name == null || name.isBlank()) {
          resp.sendRedirect(ctx + "/admin/places?stateId=" + stateId + "&msg=required");
          return;
        }
        if ("famous".equals(type)) {
          FamousPlace p = new FamousPlace();
          if (placeIdStr != null && !placeIdStr.isBlank()) {
            p.setPlaceId(Integer.parseInt(placeIdStr));
          }
          p.setStateId(stateId);
          p.setPlaceName(name);
          p.setDescription(req.getParameter("description"));
          p.setImageUrl(req.getParameter("imageUrl"));
          if (p.getPlaceId() > 0) {
            famousPlaceDAO.update(conn, p);
          } else {
            famousPlaceDAO.insert(conn, p);
          }
        } else if ("hidden".equals(type)) {
          HiddenPlace p = new HiddenPlace();
          if (placeIdStr != null && !placeIdStr.isBlank()) {
            p.setPlaceId(Integer.parseInt(placeIdStr));
          }
          p.setStateId(stateId);
          p.setPlaceName(name);
          p.setDescription(req.getParameter("description"));
          p.setImageUrl(req.getParameter("imageUrl"));
          if (p.getPlaceId() > 0) {
            hiddenPlaceDAO.update(conn, p);
          } else {
            hiddenPlaceDAO.insert(conn, p);
          }
        }
        resp.sendRedirect(ctx + "/admin/places?stateId=" + stateId + "&msg=saved");
        return;
      }
    } catch (Exception e) {
      resp.sendRedirect(ctx + "/admin/places?stateId=" + stateId + "&msg=error");
      return;
    }
    resp.sendRedirect(ctx + "/admin/places?stateId=" + stateId);
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
