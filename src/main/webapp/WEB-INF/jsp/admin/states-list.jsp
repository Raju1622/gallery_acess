<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>States – Admin</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" />
</head>
<body>
<%@ include file="/WEB-INF/jsp/admin/includes/admin-nav.jspf" %>
<div class="container">
  <h1 class="h3 mb-4">States</h1>
  <c:if test="${param.msg == 'deleted'}"><div class="alert alert-success">State deleted.</div></c:if>
  <c:if test="${param.msg == 'saved'}"><div class="alert alert-success">State updated.</div></c:if>
  <c:if test="${param.msg == 'created'}"><div class="alert alert-success">State created.</div></c:if>
  <c:if test="${param.msg == 'notfound'}"><div class="alert alert-warning">Not found.</div></c:if>
  <c:if test="${param.msg == 'required'}"><div class="alert alert-warning">Name and capital are required.</div></c:if>
  <c:if test="${not empty dbError}">
    <div class="alert alert-danger"><c:out value="${dbError}" /></div>
  </c:if>
  <a href="${pageContext.request.contextPath}/admin/states?new=1" class="btn btn-primary mb-3">Add state</a>
  <div class="table-responsive">
    <table class="table table-bordered">
      <thead><tr><th>Name</th><th>Capital</th><th></th></tr></thead>
      <tbody>
        <c:forEach var="s" items="${states}">
          <tr>
            <td><c:out value="${s.stateName}" /></td>
            <td><c:out value="${s.capital}" /></td>
            <td>
              <a class="btn btn-sm btn-outline-primary" href="${pageContext.request.contextPath}/admin/states?edit=${s.stateId}">Edit</a>
              <form action="${pageContext.request.contextPath}/admin/states" method="post" class="d-inline" onsubmit="return confirm('Delete this state and all related places/foods?');">
                <input type="hidden" name="op" value="delete" />
                <input type="hidden" name="stateId" value="${s.stateId}" />
                <button type="submit" class="btn btn-sm btn-outline-danger">Delete</button>
              </form>
            </td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
  </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
