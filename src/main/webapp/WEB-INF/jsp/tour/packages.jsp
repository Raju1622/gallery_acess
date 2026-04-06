<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tour Packages - Tour & Travels</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        body { padding-top: 70px; }
        .navbar { backdrop-filter: blur(10px); background: rgba(102, 126, 234, 0.95) !important; }
        .navbar-brand { font-size: 1.8rem; font-weight: 700; }

        .page-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 60px 0;
            margin-bottom: 40px;
        }

        .package-card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
            margin-bottom: 30px;
            height: 100%;
        }

        .package-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.2);
        }

        .package-card img {
            height: 220px;
            object-fit: cover;
            border-radius: 15px 15px 0 0;
        }

        .price-tag {
            font-size: 1.8rem;
            font-weight: 800;
            color: #10b981;
        }

        .rating { color: #fbbf24; }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark fixed-top">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">
            <i class="fas fa-plane-departure"></i> Tour & Travels
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="${pageContext.request.contextPath}/packages">Packages</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/about">About</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/contact">Contact</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Page Header -->
<div class="page-header">
    <div class="container text-center">
        <h1 class="display-4 fw-bold">Tour Packages</h1>
        <p class="lead">Choose from our amazing collection of tour packages</p>
    </div>
</div>

<!-- Packages List -->
<div class="container mb-5">
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <div class="row">
        <c:forEach items="${packages}" var="pkg">
            <div class="col-md-4">
                <div class="card package-card">
                    <img src="${pkg.imageUrl}" class="card-img-top" alt="${pkg.packageName}">
                    <div class="card-body">
                        <div class="mb-2">
                            <span class="badge bg-primary">${pkg.categoryName}</span>
                            <span class="badge bg-success ms-1">
                                <i class="fas fa-clock"></i> ${pkg.durationNights}N / ${pkg.durationDays}D
                            </span>
                        </div>
                        <h5 class="card-title">${pkg.packageName}</h5>
                        <p class="text-muted">
                            <i class="fas fa-map-marker-alt"></i> ${pkg.destination}
                        </p>
                        <div class="rating mb-3">
                            <i class="fas fa-star"></i> ${pkg.rating}
                            <span class="text-muted small">(${pkg.totalReviews})</span>
                        </div>
                        <div class="d-flex justify-content-between align-items-center">
                            <span class="price-tag">
                                <fmt:formatNumber value="${pkg.price}" type="currency" currencySymbol="₹" maxFractionDigits="0"/>
                            </span>
                            <a href="${pageContext.request.contextPath}/package?id=${pkg.packageId}" class="btn btn-primary">
                                View Details
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

    <c:if test="${empty packages}">
        <div class="text-center py-5">
            <i class="fas fa-inbox fa-4x text-muted mb-3"></i>
            <h4>No packages found</h4>
        </div>
    </c:if>
</div>

<!-- Footer -->
<footer class="bg-dark text-white py-4 mt-5">
    <div class="container text-center">
        <p class="mb-0">&copy; 2025 Tour & Travels. All rights reserved.</p>
    </div>
</footer>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
