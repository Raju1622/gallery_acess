<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book ${package.packageName} - Tour & Travels</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        body { padding-top: 70px; background: #f8f9fa; }
        .navbar { backdrop-filter: blur(10px); background: rgba(102, 126, 234, 0.95) !important; box-shadow: 0 4px 20px rgba(0,0,0,0.1); }
        .navbar-brand { font-size: 1.8rem; font-weight: 700; }

        .booking-container {
            max-width: 900px;
            margin: 40px auto;
        }

        .package-summary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 30px;
            border-radius: 15px;
            margin-bottom: 30px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }

        .booking-form {
            background: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        }

        .form-section {
            margin-bottom: 35px;
            padding-bottom: 25px;
            border-bottom: 2px solid #e5e7eb;
        }

        .form-section:last-child {
            border-bottom: none;
        }

        .form-section-title {
            font-size: 1.4rem;
            font-weight: 700;
            margin-bottom: 20px;
            color: #667eea;
        }

        .form-label {
            font-weight: 600;
            color: #374151;
            margin-bottom: 8px;
        }

        .form-control, .form-select {
            border-radius: 10px;
            padding: 12px 15px;
            border: 2px solid #e5e7eb;
            transition: all 0.3s ease;
        }

        .form-control:focus, .form-select:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .btn-book {
            background: linear-gradient(135deg, #10b981 0%, #059669 100%);
            border: none;
            padding: 15px 50px;
            font-size: 1.1rem;
            font-weight: 700;
            border-radius: 10px;
            color: white;
            transition: all 0.3s ease;
        }

        .btn-book:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(16, 185, 129, 0.3);
            color: white;
        }

        .price-breakdown {
            background: #f9fafb;
            padding: 20px;
            border-radius: 10px;
            margin-top: 20px;
        }

        .price-row {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
        }

        .total-price {
            font-size: 1.8rem;
            font-weight: 800;
            color: #10b981;
            border-top: 2px solid #e5e7eb;
            padding-top: 15px;
            margin-top: 10px;
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
                    <a class="nav-link" href="${pageContext.request.contextPath}/contact">Contact</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="booking-container">
    <!-- Package Summary -->
    <div class="package-summary">
        <div class="row align-items-center">
            <div class="col-md-8">
                <h2 class="mb-2">${package.packageName}</h2>
                <p class="mb-2"><i class="fas fa-map-marker-alt"></i> ${package.destination}</p>
                <p class="mb-0">
                    <i class="fas fa-clock"></i> ${package.durationNights}N / ${package.durationDays}D
                    <span class="ms-3"><i class="fas fa-star"></i> ${package.rating}</span>
                </p>
            </div>
            <div class="col-md-4 text-end">
                <div class="fs-3 fw-bold">
                    <fmt:formatNumber value="${package.price}" type="currency" currencySymbol="₹" maxFractionDigits="0"/>
                </div>
                <small>per person</small>
            </div>
        </div>
    </div>

    <!-- Booking Form -->
    <div class="booking-form">
        <h3 class="text-center mb-4">
            <i class="fas fa-calendar-check text-primary"></i> Complete Your Booking
        </h3>

        <c:if test="${not empty error}">
            <div class="alert alert-danger">
                <i class="fas fa-exclamation-circle"></i> ${error}
            </div>
        </c:if>

        <form method="post" action="${pageContext.request.contextPath}/book" id="bookingForm">
            <input type="hidden" name="packageId" value="${package.packageId}">

            <!-- Personal Details -->
            <div class="form-section">
                <h5 class="form-section-title">
                    <i class="fas fa-user"></i> Personal Details
                </h5>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="fullName" class="form-label">Full Name *</label>
                        <input type="text" class="form-control" id="fullName" name="fullName" required
                               placeholder="Enter your full name">
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="email" class="form-label">Email Address *</label>
                        <input type="email" class="form-control" id="email" name="email" required
                               placeholder="your@email.com">
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="phone" class="form-label">Phone Number *</label>
                        <input type="tel" class="form-control" id="phone" name="phone" required
                               placeholder="+91 9876543210">
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="city" class="form-label">City</label>
                        <input type="text" class="form-control" id="city" name="city"
                               placeholder="Your city">
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="state" class="form-label">State</label>
                        <input type="text" class="form-control" id="state" name="state"
                               placeholder="Your state">
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="country" class="form-label">Country</label>
                        <input type="text" class="form-control" id="country" name="country"
                               value="India" placeholder="Country">
                    </div>
                    <div class="col-12 mb-3">
                        <label for="address" class="form-label">Address</label>
                        <textarea class="form-control" id="address" name="address" rows="2"
                                  placeholder="Your full address"></textarea>
                    </div>
                </div>
            </div>

            <!-- Travel Details -->
            <div class="form-section">
                <h5 class="form-section-title">
                    <i class="fas fa-suitcase-rolling"></i> Travel Details
                </h5>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="travelDate" class="form-label">Travel Date *</label>
                        <input type="date" class="form-control" id="travelDate" name="travelDate" required
                               min="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>">
                    </div>
                    <div class="col-md-3 mb-3">
                        <label for="numAdults" class="form-label">Adults *</label>
                        <input type="number" class="form-control" id="numAdults" name="numAdults"
                               min="1" max="10" value="1" required onchange="calculateTotal()">
                    </div>
                    <div class="col-md-3 mb-3">
                        <label for="numChildren" class="form-label">Children</label>
                        <input type="number" class="form-control" id="numChildren" name="numChildren"
                               min="0" max="10" value="0" onchange="calculateTotal()">
                    </div>
                    <div class="col-12 mb-3">
                        <label for="specialRequests" class="form-label">Special Requests</label>
                        <textarea class="form-control" id="specialRequests" name="specialRequests" rows="3"
                                  placeholder="Any special requirements or requests..."></textarea>
                    </div>
                </div>
            </div>

            <!-- Price Breakdown -->
            <div class="price-breakdown">
                <h6 class="fw-bold mb-3">Price Breakdown</h6>
                <div class="price-row">
                    <span>Package Price (per person)</span>
                    <span class="fw-bold" id="packagePrice">
                        <fmt:formatNumber value="${package.price}" type="currency" currencySymbol="₹" maxFractionDigits="0"/>
                    </span>
                </div>
                <div class="price-row">
                    <span>Number of Travelers</span>
                    <span class="fw-bold" id="totalTravelers">1</span>
                </div>
                <div class="price-row total-price">
                    <span>Total Amount</span>
                    <span id="totalAmount">
                        <fmt:formatNumber value="${package.price}" type="currency" currencySymbol="₹" maxFractionDigits="0"/>
                    </span>
                </div>
            </div>

            <!-- Submit Button -->
            <div class="text-center mt-4">
                <button type="submit" class="btn btn-book">
                    <i class="fas fa-check-circle me-2"></i> Confirm Booking
                </button>
            </div>

            <div class="text-center mt-3">
                <small class="text-muted">
                    <i class="fas fa-shield-alt"></i> Your information is safe and secure
                </small>
            </div>
        </form>
    </div>
</div>

<!-- Footer -->
<footer class="bg-dark text-white py-4 mt-5">
    <div class="container text-center">
        <p class="mb-0">&copy; 2025 Tour & Travels. All rights reserved.</p>
    </div>
</footer>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    const packagePrice = ${package.price};

    function calculateTotal() {
        const adults = parseInt(document.getElementById('numAdults').value) || 0;
        const children = parseInt(document.getElementById('numChildren').value) || 0;
        const totalTravelers = adults + children;
        const totalAmount = packagePrice * totalTravelers;

        document.getElementById('totalTravelers').textContent = totalTravelers;
        document.getElementById('totalAmount').textContent = '₹' + totalAmount.toLocaleString('en-IN');
    }

    // Form validation
    document.getElementById('bookingForm').addEventListener('submit', function(e) {
        const travelDate = new Date(document.getElementById('travelDate').value);
        const today = new Date();
        today.setHours(0, 0, 0, 0);

        if (travelDate < today) {
            e.preventDefault();
            alert('Travel date cannot be in the past');
            return false;
        }

        const adults = parseInt(document.getElementById('numAdults').value);
        if (adults < 1) {
            e.preventDefault();
            alert('At least one adult is required');
            return false;
        }
    });

    // Initialize total
    calculateTotal();
</script>
</body>
</html>
