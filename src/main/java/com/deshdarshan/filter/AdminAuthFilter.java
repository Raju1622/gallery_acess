package com.deshdarshan.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.deshdarshan.model.AdminUser;

@WebFilter(urlPatterns = {"/admin/*"})
public class AdminAuthFilter implements Filter {

  @Override
  public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
      throws IOException, ServletException {
    HttpServletRequest req = (HttpServletRequest) request;
    HttpServletResponse resp = (HttpServletResponse) response;
    String uri = req.getRequestURI();
    String ctx = req.getContextPath();
    String loginPath = ctx + "/admin/login";
    if (uri.equals(loginPath) || uri.endsWith("/admin/login")) {
      chain.doFilter(request, response);
      return;
    }
    HttpSession session = req.getSession(false);
    AdminUser admin = session == null ? null : (AdminUser) session.getAttribute("adminUser");
    if (admin == null) {
      resp.sendRedirect(loginPath);
      return;
    }
    chain.doFilter(request, response);
  }
}
