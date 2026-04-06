<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${package.packageName} - Tour & Travels</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        body { padding-top: 70px; }
        .navbar { backdrop-filter: blur(10px); background: rgba(102, 126, 234, 0.95) !important; }
        .navbar-brand { font-size: 1.8rem; font-weight: 700; }

        .package-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 50px 0;
        }

        .package-image {
            width: 100%;
            height: 400px;
            object-fit: cover;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }

        .detail-card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            margin-bottom: 20px;
            padding: 30px;
        }

        .price-card {
            position: sticky;
            top: 90px;
            background: linear-gradient(135deg, #10b981 0%, #059669 100%);
            color: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }

        .price-amount {
            font-size: 3rem;
            font-weight: 800;
        }

        .highlight-item {
            padding: 10px 0;
            border-bottom: 1px solid #e5e7eb;
        }

        .highlight-item:last-child {
            border-bottom: none;
        }

        .highlight-item i {
            color: #10b981;
            margin-right: 10px;
        }
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
                    <a class="nav-link" href="${pageContext.request.contextPath}/packages">Packages</a>
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

<c:if test="${not empty package}">
    <!-- Package Header -->
    <div class="package-header">
        <div class="container">
            <div class="row">
                <div class="col-md-8">
                    <span class="badge bg-light text-dark">${package.categoryName}</span>
                    <h1 class="display-5 fw-bold mt-2">${package.packageName}</h1>
                    <p class="lead">
                        <i class="fas fa-map-marker-alt"></i> ${package.destination}
                    </p>
                    <div>
                        <i class="fas fa-star text-warning"></i> ${package.rating}
                        <span class="ms-2">${package.totalReviews} Reviews</span>
                        <span class="ms-4"><i class="fas fa-clock"></i> ${package.durationNights}N / ${package.durationDays}D</span>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Package Details -->
    <div class="container my-5">
        <div class="row">
            <!-- Left Column -->
            <div class="col-lg-8">
                <!-- Package Image -->
                <img src="${package.imageUrl}" alt="${package.packageName}" class="package-image mb-4">

                <!-- Description -->
                <div class="detail-card">
                    <h3 class="mb-3">Package Overview</h3>
                    <p>${package.description}</p>
                </div>

                <!-- Highlights -->
                <div class="detail-card">
                    <h3 class="mb-3">Highlights</h3>
                    <c:forEach items="${package.highlights.split(',')}" var="highlight">
                        <div class="highlight-item">
                            <i class="fas fa-check-circle"></i> ${highlight.trim()}
                        </div>
                    </c:forEach>
                </div>

                <!-- Inclusions -->
                <div class="detail-card">
                    <h3 class="mb-3"><i class="fas fa-check text-success"></i> Inclusions</h3>
                    <c:forEach items="${package.inclusions.split(',')}" var="inclusion">
                        <div class="highlight-item">
                            <i class="fas fa-plus-circle text-success"></i> ${inclusion.trim()}
                        </div>
                    </c:forEach>
                </div>

                <!-- Exclusions -->
                <div class="detail-card">
                    <h3 class="mb-3"><i class="fas fa-times text-danger"></i> Exclusions</h3>
                    <c:forEach items="${package.exclusions.split(',')}" var="exclusion">
                        <div class="highlight-item">
                            <i class="fas fa-minus-circle text-danger"></i> ${exclusion.trim()}
                        </div>
                    </c:forEach>
                </div>
            </div>

            <!-- Right Column - Price Card -->
            <div class="col-lg-4">
                <div class="price-card">
                    <div class="text-center mb-4">
                        <div class="price-amount">
                            <fmt:formatNumber value="${package.price}" type="currency" currencySymbol="₹" maxFractionDigits="0"/>
                        </div>
                        <p class="mb-0">per person</p>
                    </div>

                    <div class="d-grid gap-2 mb-4">
                        <a href="${pageContext.request.contextPath}/book?id=${package.packageId}" class="btn btn-light btn-lg">
                            <i class="fas fa-calendar-check"></i> Book Now
                        </a>
                        <button class="btn btn-outline-light" onclick="alert('Please call: +91-9876543210')">
                            <i class="fas fa-phone"></i> Contact Us
                        </button>
                    </div>

                    <div class="text-center">
                        <small>
                            <i class="fas fa-shield-alt"></i> 100% Safe & Secure
                        </small>
                    </div>
                </div>
            </div>
        </div>
    </div>
</c:if>

<c:if test="${empty package}">
    <div class="container my-5 text-center">
        <i class="fas fa-exclamation-triangle fa-4x text-warning mb-3"></i>
        <h3>Package not found</h3>
        <a href="${pageContext.request.contextPath}/packages" class="btn btn-primary mt-3">
            Browse All Packages
        </a>
    </div>
</c:if>

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
