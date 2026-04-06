<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="pageTitle" value="Search" scope="request" />
<%@ include file="/WEB-INF/jsp/includes/header.jspf" %>

<h1 class="h3 mb-3">Search results</h1>
<p class="text-muted">Query: <strong><c:out value="${query}" /></strong></p>
<c:if test="${not empty dbError}">
  <div class="alert alert-danger"><c:out value="${dbError}" /></div>
</c:if>
<div class="list-group">
  <c:forEach var="s" items="${states}">
    <a href="${pageContext.request.contextPath}/state?id=${s.stateId}" class="list-group-item list-group-item-action">
      <c:out value="${s.stateName}" /> — <span class="text-muted small"><c:out value="${s.capital}" /></span>
    </a>
  </c:forEach>
</div>
<c:if test="${empty states and empty dbError}">
  <p class="text-muted">No matching states.</p>
</c:if>

<%@ include file="/WEB-INF/jsp/includes/footer.jspf" %>
