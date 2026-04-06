<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="pageTitle" value="All states" scope="request" />
<%@ include file="/WEB-INF/jsp/includes/header.jspf" %>

<h1 class="h3 mb-4">States &amp; territories</h1>
<c:if test="${not empty dbError}">
  <div class="alert alert-danger"><c:out value="${dbError}" /></div>
</c:if>
<div class="row g-4">
  <c:forEach var="s" items="${states}">
    <div class="col-md-6 col-lg-4">
      <div class="card state-card h-100">
        <c:choose>
          <c:when test="${not empty s.imageUrl}">
            <img src="${s.imageUrl}" class="card-img-top" alt="" />
          </c:when>
          <c:otherwise>
            <div class="card-img-top bg-secondary d-flex align-items-center justify-content-center text-white" style="height:140px;">No image</div>
          </c:otherwise>
        </c:choose>
        <div class="card-body d-flex flex-column">
          <h2 class="h5 card-title"><c:out value="${s.stateName}" /></h2>
          <p class="small text-muted flex-grow-1"><c:out value="${s.description}" /></p>
          <a href="${pageContext.request.contextPath}/state?id=${s.stateId}" class="btn btn-outline-primary btn-sm">Open</a>
        </div>
      </div>
    </div>
  </c:forEach>
</div>

<%@ include file="/WEB-INF/jsp/includes/footer.jspf" %>
