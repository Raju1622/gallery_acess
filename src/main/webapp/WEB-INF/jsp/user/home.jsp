<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="pageTitle" value="Home" scope="request" />
<%@ include file="/WEB-INF/jsp/includes/header.jspf" %>

<c:if test="${not empty dbError}">
  <div class="alert alert-danger">Database: <c:out value="${dbError}" /></div>
</c:if>

<section class="hero p-4 p-md-5 mb-4">
  <h1 class="display-5 fw-bold">DeshDarshan</h1>
  <p class="lead mb-0">Explore the culture, cuisine &amp; heritage of every state and union territory of India.</p>
  <p class="text-muted mt-2 mb-0">States in directory: <strong>${totalStates}</strong> — add more from the admin panel.</p>
</section>

<h2 class="h4 mb-3">Featured states</h2>
<div class="row g-4">
  <c:forEach var="s" items="${featuredStates}">
    <div class="col-md-6 col-lg-4">
      <div class="card state-card h-100">
        <c:choose>
          <c:when test="${not empty s.imageUrl}">
            <img src="${s.imageUrl}" class="card-img-top" alt="" />
          </c:when>
          <c:otherwise>
            <div class="card-img-top bg-secondary d-flex align-items-center justify-content-center text-white" style="height:160px;">No image</div>
          </c:otherwise>
        </c:choose>
        <div class="card-body">
          <h3 class="card-title h5"><c:out value="${s.stateName}" /></h3>
          <p class="card-text small text-muted mb-2">Capital: <c:out value="${s.capital}" /></p>
          <a href="${pageContext.request.contextPath}/state?id=${s.stateId}" class="btn btn-primary btn-sm">View details</a>
        </div>
      </div>
    </div>
  </c:forEach>
</div>
<c:if test="${empty featuredStates}">
  <p class="text-muted">No states yet. Import <code>database/schema.sql</code> and configure <code>WEB-INF/db.properties</code>.</p>
</c:if>

<%@ include file="/WEB-INF/jsp/includes/footer.jspf" %>
