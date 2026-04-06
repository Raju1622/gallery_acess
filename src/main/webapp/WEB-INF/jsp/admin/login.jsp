<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Admin login – DeshDarshan</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" />
</head>
<body class="d-flex align-items-center min-vh-100 bg-light">
<div class="container" style="max-width:400px">
  <h1 class="h4 mb-4 text-center">DeshDarshan admin</h1>
  <c:if test="${not empty error}">
    <div class="alert alert-danger"><c:out value="${error}" /></div>
  </c:if>
  <form method="post" action="${pageContext.request.contextPath}/admin/login" class="card shadow p-4">
    <div class="mb-3">
      <label class="form-label" for="username">Username</label>
      <input class="form-control" id="username" name="username" required autocomplete="username" />
    </div>
    <div class="mb-3">
      <label class="form-label" for="password">Password</label>
      <input type="password" class="form-control" id="password" name="password" required autocomplete="current-password" />
    </div>
    <button type="submit" class="btn btn-primary w-100">Sign in</button>
  </form>
  <p class="small text-muted text-center mt-3">Default (after running schema): <code>admin</code> / <code>admin123</code></p>
</div>
</body>
</html>
