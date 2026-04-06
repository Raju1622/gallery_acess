<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Tour & Travels</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        body { background: #f8f9fa; }
        .navbar { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); }
        .sidebar {
            min-height: calc(100vh - 56px);
            background: white;
            box-shadow: 2px 0 5px rgba(0,0,0,0.1);
        }
        .sidebar a {
            padding: 15px 20px;
            display: block;
            color: #333;
            text-decoration: none;
            transition: all 0.3s ease;
        }
        .sidebar a:hover, .sidebar a.active {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        .stat-card {
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
        }
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
        }
        .stat-card i {
            font-size: 3rem;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-dark">
    <div class="container-fluid">
        <span class="navbar-brand">
            <i class="fas fa-user-shield"></i> Admin Dashboard
        </span>
        <div class="d-flex align-items-center text-white">
            <span class="me-3">
                <i class="fas fa-user-circle"></i> ${adminUser.fullName}
            </span>
            <a href="${pageContext.request.contextPath}/admin/logout" class="btn btn-light btn-sm">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a>
        </div>
    </div>
</nav>

<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <div class="col-md-2 p-0">
            <div class="sidebar">
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="active">
                    <i class="fas fa-tachometer-alt me-2"></i> Dashboard
                </a>
                <a href="${pageContext.request.contextPath}/admin/packages">
                    <i class="fas fa-box me-2"></i> Manage Packages
                </a>
                <a href="${pageContext.request.contextPath}/admin/bookings">
                    <i class="fas fa-calendar-check me-2"></i> Bookings
                </a>
                <a href="${pageContext.request.contextPath}/admin/customers">
                    <i class="fas fa-users me-2"></i> Customers
                </a>
                <a href="${pageContext.request.contextPath}/">
                    <i class="fas fa-globe me-2"></i> View Website
                </a>
            </div>
        </div>

        <!-- Main Content -->
        <div class="col-md-10 p-4">
            <h2 class="mb-4">Dashboard</h2>

            <!-- Statistics Cards -->
            <div class="row">
                <div class="col-md-3">
                    <div class="stat-card bg-primary text-white">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h3>24</h3>
                                <p class="mb-0">Total Packages</p>
                            </div>
                            <i class="fas fa-box"></i>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-card bg-success text-white">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h3>48</h3>
                                <p class="mb-0">Total Bookings</p>
                            </div>
                            <i class="fas fa-calendar-check"></i>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-card bg-warning text-white">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h3>156</h3>
                                <p class="mb-0">Total Customers</p>
                            </div>
                            <i class="fas fa-users"></i>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-card bg-info text-white">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h3>₹5.2L</h3>
                                <p class="mb-0">Revenue</p>
                            </div>
                            <i class="fas fa-rupee-sign"></i>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Recent Bookings -->
            <div class="card mt-4">
                <div class="card-header bg-white">
                    <h5 class="mb-0"><i class="fas fa-clock me-2"></i> Recent Bookings</h5>
                </div>
                <div class="card-body">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>Booking ID</th>
                                <th>Customer Name</th>
                                <th>Package</th>
                                <th>Travel Date</th>
                                <th>Status</th>
                                <th>Amount</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>#001</td>
                                <td>Raj Kumar</td>
                                <td>Shimla Manali Delight</td>
                                <td>2025-05-15</td>
                                <td><span class="badge bg-success">Confirmed</span></td>
                                <td>₹31,998</td>
                            </tr>
                            <tr>
                                <td>#002</td>
                                <td>Priya Sharma</td>
                                <td>Goa Beach Paradise</td>
                                <td>2025-06-10</td>
                                <td><span class="badge bg-warning">Pending</span></td>
                                <td>₹25,998</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
