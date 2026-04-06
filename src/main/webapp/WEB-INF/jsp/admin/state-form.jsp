<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title><c:out value="${formTitle}" /> – Admin</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" />
</head>
<body>
<%@ include file="/WEB-INF/jsp/admin/includes/admin-nav.jspf" %>
<div class="container" style="max-width:720px">
  <h1 class="h3 mb-4"><c:out value="${formTitle}" /></h1>
  <form method="post" action="${pageContext.request.contextPath}/admin/states">
    <input type="hidden" name="op" value="save" />
    <c:if test="${state.stateId > 0}">
      <input type="hidden" name="stateId" value="${state.stateId}" />
    </c:if>
    <div class="mb-3">
      <label class="form-label">State name *</label>
      <input class="form-control" name="stateName" value="${state.stateName}" required />
    </div>
    <div class="mb-3">
      <label class="form-label">Capital *</label>
      <input class="form-control" name="capital" value="${state.capital}" required />
    </div>
    <div class="mb-3">
      <label class="form-label">Population</label>
      <input class="form-control" name="population" value="${state.population}" />
    </div>
    <div class="mb-3">
      <label class="form-label">Language</label>
      <input class="form-control" name="language" value="${state.language}" />
    </div>
    <div class="mb-3">
      <label class="form-label">Area</label>
      <input class="form-control" name="area" value="${state.area}" />
    </div>
    <div class="mb-3">
      <label class="form-label">Climate</label>
      <input class="form-control" name="climate" value="${state.climate}" />
    </div>
    <div class="mb-3">
      <label class="form-label">Description</label>
      <textarea class="form-control" name="description" rows="4">${state.description}</textarea>
    </div>
    <div class="mb-3">
      <label class="form-label">Image URL</label>
      <input class="form-control" name="imageUrl" value="${state.imageUrl}" placeholder="https://..." />
    </div>
    <button type="submit" class="btn btn-primary">Save</button>
    <a href="${pageContext.request.contextPath}/admin/states" class="btn btn-link">Cancel</a>
  </form>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
