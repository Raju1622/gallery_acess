<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:choose>
  <c:when test="${not empty state}"><c:set var="pageTitle" value="${state.stateName}" scope="request" /></c:when>
  <c:otherwise><c:set var="pageTitle" value="State" scope="request" /></c:otherwise>
</c:choose>
<%@ include file="/WEB-INF/jsp/includes/header.jspf" %>

<c:if test="${not empty dbError}">
  <div class="alert alert-danger"><c:out value="${dbError}" /></div>
</c:if>
<c:if test="${not empty notFound}">
  <p class="alert alert-warning">State not found.</p>
  <a href="${pageContext.request.contextPath}/states" class="btn btn-primary">Back to list</a>
</c:if>

<c:if test="${not empty state}">
  <article>
    <c:if test="${not empty state.imageUrl}">
      <img src="${state.imageUrl}" class="state-hero-img mb-4" alt="" />
    </c:if>
    <h1 class="display-6 fw-bold"><c:out value="${state.stateName}" /></h1>
    <dl class="row mt-3">
      <dt class="col-sm-3">Capital</dt><dd class="col-sm-9"><c:out value="${state.capital}" /></dd>
      <dt class="col-sm-3">Population</dt><dd class="col-sm-9"><c:out value="${state.population}" /></dd>
      <dt class="col-sm-3">Language</dt><dd class="col-sm-9"><c:out value="${state.language}" /></dd>
      <dt class="col-sm-3">Area</dt><dd class="col-sm-9"><c:out value="${state.area}" /></dd>
      <dt class="col-sm-3">Climate</dt><dd class="col-sm-9"><c:out value="${state.climate}" /></dd>
    </dl>
    <p class="lead"><c:out value="${state.description}" /></p>

    <h2 class="h4 mt-5">Famous places</h2>
    <div class="row g-3">
      <c:forEach var="p" items="${famousPlaces}">
        <div class="col-md-6">
          <div class="card h-100">
            <c:if test="${not empty p.imageUrl}">
              <img src="${p.imageUrl}" class="card-img-top" style="max-height:180px;object-fit:cover;" alt="" />
            </c:if>
            <div class="card-body">
              <h3 class="h6 card-title"><c:out value="${p.placeName}" /></h3>
              <p class="card-text small"><c:out value="${p.description}" /></p>
            </div>
          </div>
        </div>
      </c:forEach>
    </div>
    <c:if test="${empty famousPlaces}"><p class="text-muted">No entries yet.</p></c:if>

    <h2 class="h4 mt-5">Hidden / underrated places</h2>
    <ul class="list-group list-group-flush">
      <c:forEach var="p" items="${hiddenPlaces}">
        <li class="list-group-item px-0">
          <strong><c:out value="${p.placeName}" /></strong>
          <c:if test="${not empty p.description}"><br /><span class="small text-muted"><c:out value="${p.description}" /></span></c:if>
        </li>
      </c:forEach>
    </ul>
    <c:if test="${empty hiddenPlaces}"><p class="text-muted">No entries yet.</p></c:if>

    <h2 class="h4 mt-5">Famous foods</h2>
    <ul class="list-group">
      <c:forEach var="f" items="${famousFoods}">
        <li class="list-group-item">
          <strong><c:out value="${f.foodName}" /></strong>
          <c:if test="${not empty f.description}"><br /><span class="small text-muted"><c:out value="${f.description}" /></span></c:if>
        </li>
      </c:forEach>
    </ul>
    <c:if test="${empty famousFoods}"><p class="text-muted">No entries yet.</p></c:if>
  </article>
</c:if>

<%@ include file="/WEB-INF/jsp/includes/footer.jspf" %>
