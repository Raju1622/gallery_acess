<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Place – Admin</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" />
</head>
<body>
<%@ include file="/WEB-INF/jsp/admin/includes/admin-nav.jspf" %>
<div class="container" style="max-width:640px">
  <h1 class="h3 mb-4">
    <c:choose>
      <c:when test="${editSection == 'famous'}">Famous place</c:when>
      <c:otherwise>Hidden place</c:otherwise>
    </c:choose>
  </h1>
  <c:choose>
    <c:when test="${editSection == 'famous'}">
      <c:set var="p" value="${famousPlace}" />
      <c:set var="ptype" value="famous" />
    </c:when>
    <c:otherwise>
      <c:set var="p" value="${hiddenPlace}" />
      <c:set var="ptype" value="hidden" />
    </c:otherwise>
  </c:choose>
  <form method="post" action="${pageContext.request.contextPath}/admin/places">
    <input type="hidden" name="op" value="save" />
    <input type="hidden" name="type" value="${ptype}" />
    <input type="hidden" name="stateId" value="${stateId}" />
    <c:if test="${ptype == 'famous' && famousPlace.placeId > 0}">
      <input type="hidden" name="placeId" value="${famousPlace.placeId}" />
    </c:if>
    <c:if test="${ptype == 'hidden' && hiddenPlace.placeId > 0}">
      <input type="hidden" name="placeId" value="${hiddenPlace.placeId}" />
    </c:if>
    <div class="mb-3">
      <label class="form-label">Name *</label>
      <input class="form-control" name="placeName" value="${p.placeName}" required />
    </div>
    <div class="mb-3">
      <label class="form-label">Description</label>
      <textarea class="form-control" name="description" rows="3">${p.description}</textarea>
    </div>
    <div class="mb-3">
      <label class="form-label">Image URL</label>
      <input class="form-control" name="imageUrl" value="${p.imageUrl}" />
    </div>
    <button type="submit" class="btn btn-primary">Save</button>
    <a href="${pageContext.request.contextPath}/admin/places?stateId=${stateId}" class="btn btn-link">Cancel</a>
  </form>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
