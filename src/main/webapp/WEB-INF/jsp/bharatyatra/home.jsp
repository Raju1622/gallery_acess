<%@ include file="includes/header.jspf" %>

<c:if test="${not empty error}">
    <div class="alert alert-danger">${error}</div>
</c:if>

<!-- Hero Section - Original Design -->
<div class="hero-section text-center py-5 mb-5">
    <div class="hero-content">
        <h1 class="display-3 fw-bold text-primary mb-3">
            <i class="fas fa-mountain text-success"></i> Discover Incredible India
        </h1>
        <p class="lead text-secondary mb-4">
            Curated holiday packages for every traveler. Mountains, beaches, heritage & more!
        </p>

        <!-- Search Box -->
        <div class="search-box mx-auto" style="max-width: 600px;">
            <form action="${pageContext.request.contextPath}/packages" method="get">
                <div class="input-group input-group-lg shadow">
                    <input type="text" class="form-control" name="destination"
                           placeholder="Where do you want to go?" />
                    <button class="btn btn-primary px-4" type="submit">
                        <i class="fas fa-search"></i> Explore
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Featured Packages -->
<section class="mb-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="h3 fw-bold">
            <i class="fas fa-star text-warning"></i> Featured Holiday Packages
        </h2>
        <a href="${pageContext.request.contextPath}/packages" class="btn btn-outline-primary">
            View All <i class="fas fa-arrow-right"></i>
        </a>
    </div>

    <c:choose>
        <c:when test="${not empty featuredPackages}">
            <div class="row g-4">
                <c:forEach var="pkg" items="${featuredPackages}">
                    <div class="col-md-6 col-lg-4">
                        <div class="card package-card h-100 shadow-sm">
                            <c:if test="${not empty pkg.imageUrl}">
                                <img src="${pkg.imageUrl}" class="card-img-top" alt="${pkg.packageName}"
                                     style="height: 200px; object-fit: cover;">
                            </c:if>
                            <div class="card-body">
                                <div class="d-flex justify-content-between mb-2">
                                    <span class="badge bg-primary">${pkg.categoryName}</span>
                                    <span class="text-warning">
                                        <i class="fas fa-star"></i> ${pkg.rating}
                                        <small class="text-muted">(${pkg.totalReviews})</small>
                                    </span>
                                </div>
                                <h5 class="card-title">${pkg.packageName}</h5>
                                <p class="text-muted small mb-2">
                                    <i class="fas fa-map-marker-alt"></i> ${pkg.destination}
                                </p>
                                <p class="card-text small">${pkg.description}</p>
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <span class="badge bg-light text-dark">
                                            <i class="fas fa-clock"></i> ${pkg.durationText}
                                        </span>
                                    </div>
                                    <div>
                                        <h5 class="text-success mb-0">
                                            ₹<fmt:formatNumber value="${pkg.pricePerPerson}" pattern="#,##0"/>
                                        </h5>
                                        <small class="text-muted">per person</small>
                                    </div>
                                </div>
                            </div>
                            <div class="card-footer bg-white">
                                <a href="${pageContext.request.contextPath}/package-details?id=${pkg.packageId}"
                                   class="btn btn-primary w-100">
                                    View Details <i class="fas fa-arrow-right"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:when>
        <c:otherwise>
            <div class="alert alert-info">
                <i class="fas fa-info-circle"></i> No packages available. Please check back later!
            </div>
        </c:otherwise>
    </c:choose>
</section>

<!-- Why Choose Us -->
<section class="py-5 bg-light rounded mb-5">
    <div class="text-center mb-4">
        <h2 class="h3 fw-bold">Why Choose BharatYatra?</h2>
    </div>
    <div class="row g-4 text-center">
        <div class="col-md-3">
            <div class="p-3">
                <i class="fas fa-shield-alt fa-3x text-primary mb-3"></i>
                <h5>Safe & Secure</h5>
                <p class="small text-muted">100% secure bookings</p>
            </div>
        </div>
        <div class="col-md-3">
            <div class="p-3">
                <i class="fas fa-hand-holding-usd fa-3x text-success mb-3"></i>
                <h5>Best Prices</h5>
                <p class="small text-muted">Guaranteed lowest rates</p>
            </div>
        </div>
        <div class="col-md-3">
            <div class="p-3">
                <i class="fas fa-headset fa-3x text-info mb-3"></i>
                <h5>24/7 Support</h5>
                <p class="small text-muted">Always here to help</p>
            </div>
        </div>
        <div class="col-md-3">
            <div class="p-3">
                <i class="fas fa-users fa-3x text-warning mb-3"></i>
                <h5>Expert Team</h5>
                <p class="small text-muted">Travel specialists</p>
            </div>
        </div>
    </div>
</section>

<%@ include file="includes/footer.jspf" %>
