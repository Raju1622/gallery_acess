<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us - Tour & Travels</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        body { padding-top: 70px; background: #f8f9fa; }
        .navbar { backdrop-filter: blur(10px); background: rgba(102, 126, 234, 0.95) !important; box-shadow: 0 4px 20px rgba(0,0,0,0.1); }
        .navbar-brand { font-size: 1.8rem; font-weight: 700; }

        .page-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 80px 0 60px;
            margin-bottom: 50px;
        }

        .contact-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            padding: 40px;
            margin-bottom: 30px;
        }

        .info-box {
            text-align: center;
            padding: 30px;
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            margin-bottom: 20px;
            transition: all 0.3s ease;
        }

        .info-box:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.15);
        }

        .info-box i {
            font-size: 3rem;
            color: #667eea;
            margin-bottom: 20px;
        }

        .info-box h5 {
            color: #1f2937;
            margin-bottom: 15px;
            font-weight: 700;
        }

        .form-control, .form-select {
            border-radius: 10px;
            padding: 12px 15px;
            border: 2px solid #e5e7eb;
        }

        .form-control:focus, .form-select:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .btn-submit {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            padding: 15px 50px;
            font-size: 1.1rem;
            font-weight: 700;
            border-radius: 10px;
            color: white;
            transition: all 0.3s ease;
        }

        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.3);
            color: white;
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
                    <a class="nav-link active" href="${pageContext.request.contextPath}/contact">Contact</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Page Header -->
<div class="page-header">
    <div class="container text-center">
        <h1 class="display-4 fw-bold">Get in Touch</h1>
        <p class="lead">We're here to help and answer any question you might have</p>
    </div>
</div>

<!-- Contact Section -->
<div class="container mb-5">
    <div class="row">
        <!-- Contact Info -->
        <div class="col-lg-4">
            <div class="info-box">
                <i class="fas fa-map-marker-alt"></i>
                <h5>Visit Us</h5>
                <p class="text-muted">123 Travel Street<br>New Delhi, India 110001</p>
            </div>

            <div class="info-box">
                <i class="fas fa-phone"></i>
                <h5>Call Us</h5>
                <p class="text-muted">
                    +91-9876543210<br>
                    +91-9876543211
                </p>
            </div>

            <div class="info-box">
                <i class="fas fa-envelope"></i>
                <h5>Email Us</h5>
                <p class="text-muted">
                    info@tourtravels.com<br>
                    support@tourtravels.com
                </p>
            </div>

            <div class="info-box">
                <i class="fas fa-clock"></i>
                <h5>Working Hours</h5>
                <p class="text-muted">
                    Mon - Sat: 9:00 AM - 7:00 PM<br>
                    Sunday: 10:00 AM - 5:00 PM
                </p>
            </div>
        </div>

        <!-- Contact Form -->
        <div class="col-lg-8">
            <div class="contact-card">
                <h3 class="mb-4">
                    <i class="fas fa-paper-plane text-primary"></i> Send us a Message
                </h3>

                <c:if test="${not empty success}">
                    <div class="alert alert-success alert-dismissible fade show">
                        <i class="fas fa-check-circle"></i> ${success}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <form method="post" action="${pageContext.request.contextPath}/contact">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="name" class="form-label">Your Name *</label>
                            <input type="text" class="form-control" id="name" name="name" required
                                   placeholder="Enter your name">
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="email" class="form-label">Email Address *</label>
                            <input type="email" class="form-control" id="email" name="email" required
                                   placeholder="your@email.com">
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="phone" class="form-label">Phone Number</label>
                            <input type="tel" class="form-control" id="phone" name="phone"
                                   placeholder="+91 9876543210">
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="subject" class="form-label">Subject *</label>
                            <select class="form-select" id="subject" name="subject" required>
                                <option value="">Select Subject</option>
                                <option value="General Inquiry">General Inquiry</option>
                                <option value="Package Information">Package Information</option>
                                <option value="Booking Support">Booking Support</option>
                                <option value="Complaint">Complaint</option>
                                <option value="Feedback">Feedback</option>
                                <option value="Other">Other</option>
                            </select>
                        </div>
                        <div class="col-12 mb-3">
                            <label for="message" class="form-label">Message *</label>
                            <textarea class="form-control" id="message" name="message" rows="6" required
                                      placeholder="Write your message here..."></textarea>
                        </div>
                        <div class="col-12 text-center">
                            <button type="submit" class="btn btn-submit">
                                <i class="fas fa-paper-plane me-2"></i> Send Message
                            </button>
                        </div>
                    </div>
                </form>
            </div>

            <!-- Social Media -->
            <div class="text-center mt-4">
                <h5 class="mb-3">Follow Us</h5>
                <a href="#" class="btn btn-outline-primary btn-lg rounded-circle me-2">
                    <i class="fab fa-facebook-f"></i>
                </a>
                <a href="#" class="btn btn-outline-info btn-lg rounded-circle me-2">
                    <i class="fab fa-twitter"></i>
                </a>
                <a href="#" class="btn btn-outline-danger btn-lg rounded-circle me-2">
                    <i class="fab fa-instagram"></i>
                </a>
                <a href="#" class="btn btn-outline-success btn-lg rounded-circle me-2">
                    <i class="fab fa-whatsapp"></i>
                </a>
            </div>
        </div>
    </div>
</div>

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
