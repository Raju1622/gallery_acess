<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Foods – Admin</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" />
</head>
<body>
<%@ include file="/WEB-INF/jsp/admin/includes/admin-nav.jspf" %>
<div class="container">
  <h1 class="h3 mb-4">Famous foods</h1>
  <p class="text-muted">State ID: <c:out value="${stateId}" /></p>
  <c:if test="${param.msg == 'deleted'}"><div class="alert alert-success">Deleted.</div></c:if>
  <c:if test="${param.msg == 'saved'}"><div class="alert alert-success">Saved.</div></c:if>
  <c:if test="${not empty dbError}">
    <div class="alert alert-danger"><c:out value="${dbError}" /></div>
  </c:if>
  <a href="${pageContext.request.contextPath}/admin/foods?stateId=${stateId}&edit=new" class="btn btn-sm btn-primary mb-3">Add food</a>
  <ul class="list-group mb-4">
    <c:forEach var="f" items="${foods}">
      <li class="list-group-item d-flex justify-content-between align-items-center">
        <span><c:out value="${f.foodName}" /></span>
        <span>
          <a class="btn btn-sm btn-outline-secondary" href="${pageContext.request.contextPath}/admin/foods?stateId=${stateId}&edit=${f.foodId}">Edit</a>
          <form action="${pageContext.request.contextPath}/admin/foods" method="post" class="d-inline" onsubmit="return confirm('Delete?');">
            <input type="hidden" name="op" value="delete" />
            <input type="hidden" name="stateId" value="${stateId}" />
            <input type="hidden" name="foodId" value="${f.foodId}" />
            <button type="submit" class="btn btn-sm btn-outline-danger">Delete</button>
          </form>
        </span>
      </li>
    </c:forEach>
  </ul>
  <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-link">Back to dashboard</a>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
