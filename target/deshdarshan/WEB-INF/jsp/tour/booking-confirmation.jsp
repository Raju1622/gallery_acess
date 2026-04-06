<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Confirmed - Tour & Travels</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        body { padding-top: 70px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 100vh; }
        .navbar { backdrop-filter: blur(10px); background: rgba(102, 126, 234, 0.95) !important; }
        .navbar-brand { font-size: 1.8rem; font-weight: 700; }

        .confirmation-container {
            max-width: 800px;
            margin: 50px auto;
        }

        .confirmation-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            overflow: hidden;
            animation: slideUp 0.6s ease-out;
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .success-header {
            background: linear-gradient(135deg, #10b981 0%, #059669 100%);
            color: white;
            padding: 50px 30px;
            text-align: center;
        }

        .success-icon {
            font-size: 5rem;
            animation: scaleIn 0.6s ease-out 0.3s both;
        }

        @keyframes scaleIn {
            from {
                transform: scale(0);
                opacity: 0;
            }
            to {
                transform: scale(1);
                opacity: 1;
            }
        }

        .booking-details {
            padding: 40px;
        }

        .detail-row {
            display: flex;
            justify-content: space-between;
            padding: 15px 0;
            border-bottom: 1px solid #e5e7eb;
        }

        .detail-row:last-child {
            border-bottom: none;
        }

        .detail-label {
            font-weight: 600;
            color: #6b7280;
        }

        .detail-value {
            font-weight: 700;
            color: #1f2937;
        }

        .total-amount {
            background: #f9fafb;
            padding: 20px;
            border-radius: 10px;
            margin: 20px 0;
        }

        .total-amount .amount {
            font-size: 2.5rem;
            font-weight: 800;
            color: #10b981;
        }

        .action-buttons {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }

        .btn-print {
            background: #667eea;
            color: white;
            border: none;
            padding: 12px 30px;
            border-radius: 10px;
            font-weight: 600;
        }

        .btn-print:hover {
            background: #5568d3;
            color: white;
        }

        .status-badge {
            display: inline-block;
            padding: 8px 20px;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 600;
        }

        .status-pending {
            background: #fef3c7;
            color: #92400e;
        }

        @media print {
            body {
                background: white;
                padding-top: 0;
            }
            .navbar, .action-buttons, footer {
                display: none !important;
            }
            .confirmation-container {
                margin: 0;
                max-width: 100%;
            }
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

<div class="confirmation-container">
    <div class="confirmation-card">
        <!-- Success Header -->
        <div class="success-header">
            <div class="success-icon">
                <i class="fas fa-check-circle"></i>
            </div>
            <h1 class="mt-3">Booking Confirmed!</h1>
            <p class="lead mb-0">Thank you for choosing Tour & Travels</p>
        </div>

        <!-- Booking Details -->
        <div class="booking-details">
            <div class="text-center mb-4">
                <h5 class="text-muted">Booking ID</h5>
                <h2 class="fw-bold text-primary">#TT${booking.bookingId}</h2>
                <span class="status-badge status-pending">
                    <i class="fas fa-clock"></i> ${booking.bookingStatus}
                </span>
            </div>

            <hr class="my-4">

            <!-- Package Details -->
            <h5 class="mb-3"><i class="fas fa-suitcase-rolling text-primary"></i> Package Details</h5>
            <div class="detail-row">
                <span class="detail-label">Package Name</span>
                <span class="detail-value">${booking.packageName}</span>
            </div>
            <div class="detail-row">
                <span class="detail-label">Destination</span>
                <span class="detail-value">${booking.destination}</span>
            </div>
            <div class="detail-row">
                <span class="detail-label">Travel Date</span>
                <span class="detail-value">
                    <fmt:formatDate value="${booking.travelDate}" pattern="dd MMM yyyy" />
                </span>
            </div>
            <div class="detail-row">
                <span class="detail-label">Travelers</span>
                <span class="detail-value">${booking.numAdults} Adults, ${booking.numChildren} Children</span>
            </div>

            <hr class="my-4">

            <!-- Customer Details -->
            <h5 class="mb-3"><i class="fas fa-user text-primary"></i> Customer Details</h5>
            <div class="detail-row">
                <span class="detail-label">Name</span>
                <span class="detail-value">${booking.customerName}</span>
            </div>
            <div class="detail-row">
                <span class="detail-label">Email</span>
                <span class="detail-value">${booking.customerEmail}</span>
            </div>
            <div class="detail-row">
                <span class="detail-label">Phone</span>
                <span class="detail-value">${booking.customerPhone}</span>
            </div>

            <c:if test="${not empty booking.specialRequests}">
                <div class="detail-row">
                    <span class="detail-label">Special Requests</span>
                    <span class="detail-value">${booking.specialRequests}</span>
                </div>
            </c:if>

            <!-- Total Amount -->
            <div class="total-amount text-center">
                <p class="text-muted mb-2">Total Amount</p>
                <div class="amount">
                    <fmt:formatNumber value="${booking.totalAmount}" type="currency" currencySymbol="₹" maxFractionDigits="0"/>
                </div>
                <span class="badge bg-warning text-dark mt-2">
                    <i class="fas fa-exclamation-triangle"></i> Payment Pending
                </span>
            </div>

            <!-- Important Note -->
            <div class="alert alert-info">
                <h6><i class="fas fa-info-circle"></i> Next Steps:</h6>
                <ul class="mb-0">
                    <li>You will receive a confirmation email shortly</li>
                    <li>Our team will contact you within 24 hours to confirm your booking</li>
                    <li>Payment can be made via bank transfer or online</li>
                    <li>For any queries, call us at +91-9876543210</li>
                </ul>
            </div>

            <!-- Action Buttons -->
            <div class="action-buttons">
                <button onclick="window.print()" class="btn btn-print flex-fill">
                    <i class="fas fa-print me-2"></i> Print Booking
                </button>
                <a href="${pageContext.request.contextPath}/" class="btn btn-outline-primary flex-fill">
                    <i class="fas fa-home me-2"></i> Back to Home
                </a>
            </div>
        </div>
    </div>
</div>

<!-- Footer -->
<footer class="bg-dark text-white py-4 mt-5">
    <div class="container text-center">
        <p class="mb-0">&copy; 2025 Tour & Travels. All rights reserved.</p>
        <p class="mb-0 small">For support: support@tourtravels.com | +91-9876543210</p>
    </div>
</footer>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
