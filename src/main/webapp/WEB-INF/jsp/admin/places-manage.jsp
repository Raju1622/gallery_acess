<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Places – Admin</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" />
</head>
<body>
<%@ include file="/WEB-INF/jsp/admin/includes/admin-nav.jspf" %>
<div class="container">
  <h1 class="h3 mb-4">Manage places</h1>
  <p class="text-muted">State ID: <c:out value="${stateId}" /></p>
  <c:if test="${param.msg == 'deleted'}"><div class="alert alert-success">Deleted.</div></c:if>
  <c:if test="${param.msg == 'saved'}"><div class="alert alert-success">Saved.</div></c:if>
  <c:if test="${not empty dbError}">
    <div class="alert alert-danger"><c:out value="${dbError}" /></div>
  </c:if>

  <h2 class="h5">Famous places</h2>
  <a href="${pageContext.request.contextPath}/admin/places?stateId=${stateId}&section=famous&editFamous=new" class="btn btn-sm btn-primary mb-2">Add famous place</a>
  <ul class="list-group mb-4">
    <c:forEach var="p" items="${famousPlaces}">
      <li class="list-group-item d-flex justify-content-between align-items-center">
        <span><c:out value="${p.placeName}" /></span>
        <span>
          <a class="btn btn-sm btn-outline-secondary" href="${pageContext.request.contextPath}/admin/places?stateId=${stateId}&section=famous&editFamous=${p.placeId}">Edit</a>
          <form action="${pageContext.request.contextPath}/admin/places" method="post" class="d-inline" onsubmit="return confirm('Delete?');">
            <input type="hidden" name="op" value="delete" />
            <input type="hidden" name="type" value="famous" />
            <input type="hidden" name="stateId" value="${stateId}" />
            <input type="hidden" name="placeId" value="${p.placeId}" />
            <button type="submit" class="btn btn-sm btn-outline-danger">Delete</button>
          </form>
        </span>
      </li>
    </c:forEach>
  </ul>

  <h2 class="h5">Hidden places</h2>
  <a href="${pageContext.request.contextPath}/admin/places?stateId=${stateId}&section=hidden&editHidden=new" class="btn btn-sm btn-primary mb-2">Add hidden place</a>
  <ul class="list-group mb-4">
    <c:forEach var="p" items="${hiddenPlaces}">
      <li class="list-group-item d-flex justify-content-between align-items-center">
        <span><c:out value="${p.placeName}" /></span>
        <span>
          <a class="btn btn-sm btn-outline-secondary" href="${pageContext.request.contextPath}/admin/places?stateId=${stateId}&section=hidden&editHidden=${p.placeId}">Edit</a>
          <form action="${pageContext.request.contextPath}/admin/places" method="post" class="d-inline" onsubmit="return confirm('Delete?');">
            <input type="hidden" name="op" value="delete" />
            <input type="hidden" name="type" value="hidden" />
            <input type="hidden" name="stateId" value="${stateId}" />
            <input type="hidden" name="placeId" value="${p.placeId}" />
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
