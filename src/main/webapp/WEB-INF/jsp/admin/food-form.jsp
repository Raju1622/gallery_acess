<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Food – Admin</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" />
</head>
<body>
<%@ include file="/WEB-INF/jsp/admin/includes/admin-nav.jspf" %>
<div class="container" style="max-width:640px">
  <h1 class="h3 mb-4">Famous food</h1>
  <form method="post" action="${pageContext.request.contextPath}/admin/foods">
    <input type="hidden" name="op" value="save" />
    <input type="hidden" name="stateId" value="${stateId}" />
    <c:if test="${food.foodId > 0}">
      <input type="hidden" name="foodId" value="${food.foodId}" />
    </c:if>
    <div class="mb-3">
      <label class="form-label">Name *</label>
      <input class="form-control" name="foodName" value="${food.foodName}" required />
    </div>
    <div class="mb-3">
      <label class="form-label">Description</label>
      <textarea class="form-control" name="description" rows="3">${food.description}</textarea>
    </div>
    <button type="submit" class="btn btn-primary">Save</button>
    <a href="${pageContext.request.contextPath}/admin/foods?stateId=${stateId}" class="btn btn-link">Cancel</a>
  </form>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
