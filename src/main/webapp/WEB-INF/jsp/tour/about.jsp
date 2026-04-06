<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - Tour & Travels</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        body { padding-top: 70px; }
        .navbar { backdrop-filter: blur(10px); background: rgba(102, 126, 234, 0.95) !important; box-shadow: 0 4px 20px rgba(0,0,0,0.1); }
        .navbar-brand { font-size: 1.8rem; font-weight: 700; }

        .hero-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 100px 0 80px;
            position: relative;
        }

        .about-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            padding: 40px;
            margin: -80px auto 50px;
            max-width: 1200px;
            position: relative;
            z-index: 1;
        }

        .stat-box {
            text-align: center;
            padding: 30px;
            background: #f9fafb;
            border-radius: 15px;
            transition: all 0.3s ease;
        }

        .stat-box:hover {
            transform: translateY(-10px);
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            box-shadow: 0 15px 40px rgba(0,0,0,0.2);
        }

        .stat-number {
            font-size: 3rem;
            font-weight: 800;
            color: #667eea;
        }

        .stat-box:hover .stat-number {
            color: white;
        }

        .feature-icon {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 2rem;
            margin-bottom: 20px;
        }

        .team-member {
            text-align: center;
            padding: 20px;
        }

        .team-member img {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            margin-bottom: 15px;
            border: 5px solid #667eea;
        }

        .values-section {
            background: #f8f9fa;
            padding: 80px 0;
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
                    <a class="nav-link active" href="${pageContext.request.contextPath}/about">About</a>
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
    <div class="container text-center">
        <h1 class="display-3 fw-bold mb-4">About Tour & Travels</h1>
        <p class="lead fs-4">Your trusted partner in creating unforgettable travel experiences</p>
    </div>
</section>

<!-- About Card -->
<div class="container">
    <div class="about-card">
        <div class="row align-items-center mb-5">
            <div class="col-lg-6">
                <h2 class="mb-4">Who We Are</h2>
                <p class="lead">
                    Tour & Travels is India's leading travel and tourism company, dedicated to providing
                    exceptional travel experiences since 2010. We specialize in curated tour packages that
                    showcase the best of India's diverse destinations.
                </p>
                <p>
                    Our team of travel experts works tirelessly to create memorable journeys that combine
                    comfort, adventure, and cultural immersion. With thousands of satisfied customers and
                    a commitment to excellence, we've become the preferred choice for travelers across India.
                </p>
                <p>
                    From the snow-capped mountains of Himachal to the sun-kissed beaches of Goa, from the
                    royal palaces of Rajasthan to the backwaters of Kerala - we bring India's beauty to you.
                </p>
            </div>
            <div class="col-lg-6">
                <img src="https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?w=600"
                     class="img-fluid rounded shadow-lg" alt="Travel">
            </div>
        </div>

        <!-- Statistics -->
        <div class="row g-4 mb-5">
            <div class="col-md-3">
                <div class="stat-box">
                    <div class="stat-number">15+</div>
                    <h6>Years Experience</h6>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-box">
                    <div class="stat-number">50K+</div>
                    <h6>Happy Travelers</h6>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-box">
                    <div class="stat-number">200+</div>
                    <h6>Tour Packages</h6>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-box">
                    <div class="stat-number">100+</div>
                    <h6>Destinations</h6>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Why Choose Us -->
<section class="values-section">
    <div class="container">
        <div class="text-center mb-5">
            <h2 class="display-5 fw-bold mb-3">Why Choose Us</h2>
            <p class="lead text-muted">We're committed to making your travel dreams come true</p>
        </div>

        <div class="row g-4">
            <div class="col-md-4">
                <div class="text-center">
                    <div class="feature-icon mx-auto">
                        <i class="fas fa-shield-alt"></i>
                    </div>
                    <h4 class="mb-3">Best Price Guarantee</h4>
                    <p class="text-muted">
                        We offer competitive prices and the best value for money. Find a better price?
                        We'll match it!
                    </p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="text-center">
                    <div class="feature-icon mx-auto">
                        <i class="fas fa-headset"></i>
                    </div>
                    <h4 class="mb-3">24/7 Support</h4>
                    <p class="text-muted">
                        Our customer support team is available round the clock to assist you with any
                        queries or concerns.
                    </p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="text-center">
                    <div class="feature-icon mx-auto">
                        <i class="fas fa-award"></i>
                    </div>
                    <h4 class="mb-3">Expert Guides</h4>
                    <p class="text-muted">
                        Travel with experienced and certified tour guides who bring destinations to
                        life with their knowledge.
                    </p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="text-center">
                    <div class="feature-icon mx-auto">
                        <i class="fas fa-star"></i>
                    </div>
                    <h4 class="mb-3">Quality Service</h4>
                    <p class="text-muted">
                        We maintain high standards of service quality in hotels, transportation, and
                        all tour arrangements.
                    </p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="text-center">
                    <div class="feature-icon mx-auto">
                        <i class="fas fa-lock"></i>
                    </div>
                    <h4 class="mb-3">Secure Booking</h4>
                    <p class="text-muted">
                        Safe and secure online booking with multiple payment options for your
                        convenience.
                    </p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="text-center">
                    <div class="feature-icon mx-auto">
                        <i class="fas fa-users"></i>
                    </div>
                    <h4 class="mb-3">Group Discounts</h4>
                    <p class="text-muted">
                        Special discounts for group bookings, family packages, and corporate travel
                        arrangements.
                    </p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Mission & Vision -->
<section class="container my-5 py-5">
    <div class="row g-4">
        <div class="col-md-6">
            <div class="card h-100 border-0 shadow-lg">
                <div class="card-body p-5">
                    <div class="text-center mb-4">
                        <i class="fas fa-bullseye fa-4x text-primary"></i>
                    </div>
                    <h3 class="text-center mb-4">Our Mission</h3>
                    <p class="text-muted">
                        To provide exceptional travel experiences that exceed our customers' expectations
                        while promoting sustainable tourism and supporting local communities. We aim to
                        make travel accessible, enjoyable, and memorable for everyone.
                    </p>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="card h-100 border-0 shadow-lg">
                <div class="card-body p-5">
                    <div class="text-center mb-4">
                        <i class="fas fa-eye fa-4x text-success"></i>
                    </div>
                    <h3 class="text-center mb-4">Our Vision</h3>
                    <p class="text-muted">
                        To become India's most trusted and preferred travel partner, known for our
                        commitment to quality, innovation, and customer satisfaction. We envision a
                        future where every traveler can explore the world with confidence and joy.
                    </p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- CTA Section -->
<section class="py-5" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">
    <div class="container text-center text-white">
        <h2 class="display-5 fw-bold mb-4">Ready to Start Your Journey?</h2>
        <p class="lead mb-4">Explore our amazing tour packages and book your next adventure today!</p>
        <a href="${pageContext.request.contextPath}/packages" class="btn btn-light btn-lg me-3">
            <i class="fas fa-suitcase me-2"></i> Browse Packages
        </a>
        <a href="${pageContext.request.contextPath}/contact" class="btn btn-outline-light btn-lg">
            <i class="fas fa-phone me-2"></i> Contact Us
        </a>
    </div>
</section>

<!-- Footer -->
<footer class="bg-dark text-white py-4 mt-5">
    <div class="container text-center">
        <p class="mb-0">&copy; 2025 Tour & Travels. All rights reserved.</p>
        <p class="mb-0 small">Discover the world with us</p>
    </div>
</footer>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
