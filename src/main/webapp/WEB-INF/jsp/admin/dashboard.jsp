<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Admin dashboard – DeshDarshan</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" />
</head>
<body>
<%@ include file="/WEB-INF/jsp/admin/includes/admin-nav.jspf" %>
<div class="container">
  <h1 class="h3 mb-4">Dashboard</h1>
  <c:if test="${not empty dbError}">
    <div class="alert alert-danger"><c:out value="${dbError}" /></div>
  </c:if>
  <p>Manage states, places, and foods. Quick links for each state:</p>
  <div class="table-responsive">
    <table class="table table-striped align-middle">
      <thead><tr><th>State</th><th>Capital</th><th>Actions</th></tr></thead>
      <tbody>
        <c:forEach var="s" items="${states}">
          <tr>
            <td><c:out value="${s.stateName}" /></td>
            <td><c:out value="${s.capital}" /></td>
            <td>
              <a class="btn btn-sm btn-outline-primary" href="${pageContext.request.contextPath}/admin/states?edit=${s.stateId}">Edit state</a>
              <a class="btn btn-sm btn-outline-secondary" href="${pageContext.request.contextPath}/admin/places?stateId=${s.stateId}">Places</a>
              <a class="btn btn-sm btn-outline-secondary" href="${pageContext.request.contextPath}/admin/foods?stateId=${s.stateId}">Foods</a>
            </td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
  </div>
  <a href="${pageContext.request.contextPath}/admin/states?new=1" class="btn btn-primary">Add state</a>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
