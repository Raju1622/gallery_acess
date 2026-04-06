<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tour & Travels - Explore Amazing Destinations</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <!-- Custom CSS -->
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">

    <style>
        /* Hero Section */
        .hero-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 100px 0 80px;
            position: relative;
            overflow: hidden;
        }

        .hero-section::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
            animation: rotate 20s linear infinite;
        }

        @keyframes rotate {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
        }

        .hero-content {
            position: relative;
            z-index: 1;
        }

        .hero-title {
            font-size: 3.5rem;
            font-weight: 800;
            margin-bottom: 20px;
            animation: fadeInUp 0.8s ease-out;
        }

        .hero-subtitle {
            font-size: 1.3rem;
            margin-bottom: 40px;
            animation: fadeInUp 0.8s ease-out 0.2s both;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Search Box */
        .search-box {
            max-width: 600px;
            margin: 0 auto;
            animation: fadeInUp 0.8s ease-out 0.4s both;
        }

        .search-box .input-group {
            box-shadow: 0 10px 40px rgba(0,0,0,0.3);
            border-radius: 50px;
            overflow: hidden;
        }

        .search-box input {
            border: none;
            padding: 18px 30px;
            font-size: 1.1rem;
        }

        .search-box button {
            padding: 18px 40px;
            background: #ff6b6b;
            border: none;
            color: white;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .search-box button:hover {
            background: #ee5a52;
            transform: scale(1.05);
        }

        /* Package Cards */
        .package-card {
            border: none;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            animation: fadeInUp 0.6s ease-out;
            animation-fill-mode: both;
            height: 100%;
        }

        .package-card:nth-child(1) { animation-delay: 0.1s; }
        .package-card:nth-child(2) { animation-delay: 0.2s; }
        .package-card:nth-child(3) { animation-delay: 0.3s; }

        .package-card:hover {
            transform: translateY(-15px);
            box-shadow: 0 20px 50px rgba(0,0,0,0.2);
        }

        .package-card img {
            height: 220px;
            object-fit: cover;
            transition: transform 0.6s ease;
        }

        .package-card:hover img {
            transform: scale(1.1);
        }

        .package-card .card-body {
            padding: 25px;
        }

        .package-card .badge {
            padding: 8px 15px;
            font-size: 0.85rem;
            border-radius: 20px;
        }

        .price-tag {
            font-size: 2rem;
            font-weight: 800;
            color: #10b981;
        }

        .rating {
            color: #fbbf24;
        }

        /* Features Section */
        .features-section {
            padding: 80px 0;
            background: #f8f9fa;
        }

        .feature-box {
            text-align: center;
            padding: 40px 20px;
            border-radius: 15px;
            transition: all 0.3s ease;
            animation: fadeInUp 0.6s ease-out;
        }

        .feature-box:hover {
            transform: translateY(-10px);
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            box-shadow: 0 15px 40px rgba(0,0,0,0.2);
        }

        .feature-box i {
            font-size: 3.5rem;
            margin-bottom: 20px;
            transition: all 0.3s ease;
        }

        .feature-box:hover i {
            transform: scale(1.2) rotateY(360deg);
        }

        /* Navbar */
        .navbar {
            backdrop-filter: blur(10px);
            background: rgba(102, 126, 234, 0.95) !important;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
        }

        .navbar-brand {
            font-size: 1.8rem;
            font-weight: 700;
        }

        /* Section Titles */
        .section-title {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 50px;
            position: relative;
            display: inline-block;
        }

        .section-title::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 100px;
            height: 4px;
            background: linear-gradient(to right, #667eea, #764ba2);
            border-radius: 2px;
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
                        <a class="nav-link active" href="${pageContext.request.contextPath}/">Home</a>
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

    <!-- Hero Section -->
    <section class="hero-section">
        <div class="container hero-content">
            <div class="text-center">
                <h1 class="hero-title">Discover Your Next Adventure</h1>
                <p class="hero-subtitle">Explore amazing destinations across India with our exclusive tour packages</p>

                <!-- Search Box -->
                <div class="search-box">
                    <form action="${pageContext.request.contextPath}/search" method="get">
                        <div class="input-group">
                            <input type="text" class="form-control" name="q" placeholder="Search destinations, packages..." required>
                            <button class="btn" type="submit">
                                <i class="fas fa-search me-2"></i> Search
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </section>

    <!-- Featured Packages -->
    <section class="py-5" style="margin-top: 50px;">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="section-title">Featured Tour Packages</h2>
            </div>

            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>

            <div class="row g-4">
                <c:forEach items="${featuredPackages}" var="pkg">
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
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <div class="rating">
                                        <i class="fas fa-star"></i> ${pkg.rating}
                                        <span class="text-muted small">(${pkg.totalReviews} reviews)</span>
                                    </div>
                                </div>
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <span class="price-tag">
                                            <fmt:formatNumber value="${pkg.price}" type="currency" currencySymbol="₹" maxFractionDigits="0"/>
                                        </span>
                                        <small class="text-muted d-block">per person</small>
                                    </div>
                                    <a href="${pageContext.request.contextPath}/package?id=${pkg.packageId}" class="btn btn-primary">
                                        View Details
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <div class="text-center mt-5">
                <a href="${pageContext.request.contextPath}/packages" class="btn btn-lg btn-primary">
                    View All Packages <i class="fas fa-arrow-right ms-2"></i>
                </a>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section class="features-section">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="section-title">Why Choose Us</h2>
            </div>
            <div class="row">
                <div class="col-md-3">
                    <div class="feature-box">
                        <i class="fas fa-shield-alt"></i>
                        <h5>Best Price Guarantee</h5>
                        <p>Get the best deals on tour packages</p>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="feature-box">
                        <i class="fas fa-headset"></i>
                        <h5>24/7 Support</h5>
                        <p>Customer support available anytime</p>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="feature-box">
                        <i class="fas fa-award"></i>
                        <h5>Expert Guides</h5>
                        <p>Experienced and certified tour guides</p>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="feature-box">
                        <i class="fas fa-lock"></i>
                        <h5>Secure Booking</h5>
                        <p>Safe and secure online booking</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="bg-dark text-white py-4">
        <div class="container text-center">
            <p class="mb-0">&copy; 2025 Tour & Travels. All rights reserved.</p>
            <p class="mb-0 small">Built with HTML, CSS, JavaScript, jQuery, Bootstrap, JSP, Servlet & MySQL</p>
        </div>
    </footer>

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Custom JS -->
    <script>
        $(document).ready(function() {
            // Smooth scroll
            $('a[href^="#"]').on('click', function(event) {
                var target = $(this.getAttribute('href'));
                if( target.length ) {
                    event.preventDefault();
                    $('html, body').stop().animate({
                        scrollTop: target.offset().top - 70
                    }, 1000);
                }
            });

            // Navbar background on scroll
            $(window).scroll(function() {
                if ($(this).scrollTop() > 50) {
                    $('.navbar').addClass('scrolled');
                } else {
                    $('.navbar').removeClass('scrolled');
                }
            });
        });
    </script>
</body>
</html>
