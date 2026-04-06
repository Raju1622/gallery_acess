<%@ include file="includes/header.jspf" %>

<c:if test="${not empty error}">
    <div class="alert alert-danger">${error}</div>
</c:if>

<c:if test="${not empty package}">
    <!-- Package Header -->
    <div class="package-header text-white text-center mb-4">
        <div class="container">
            <h1 class="display-4 fw-bold">${package.packageName}</h1>
            <p class="lead">
                <i class="fas fa-map-marker-alt"></i> ${package.destination} |
                <i class="fas fa-clock"></i> ${package.durationText}
            </p>
            <div class="mt-3">
                <span class="badge bg-light text-dark fs-6 me-2">${package.categoryName}</span>
                <span class="text-warning fs-5">
                    <i class="fas fa-star"></i> ${package.rating} (${package.totalReviews} reviews)
                </span>
            </div>
        </div>
    </div>

    <div class="row">
        <!-- Left Column - Package Details -->
        <div class="col-lg-8">
            <!-- Image -->
            <c:if test="${not empty package.imageUrl}">
                <img src="${package.imageUrl}" class="img-fluid rounded shadow-sm mb-4"
                     alt="${package.packageName}" style="width: 100%; max-height: 400px; object-fit: cover;">
            </c:if>

            <!-- Description -->
            <div class="card shadow-sm mb-4">
                <div class="card-body">
                    <h4 class="card-title"><i class="fas fa-info-circle text-primary"></i> Overview</h4>
                    <p class="card-text">${package.description}</p>
                </div>
            </div>

            <!-- Highlights -->
            <c:if test="${not empty package.highlights}">
                <div class="card shadow-sm mb-4">
                    <div class="card-body">
                        <h4 class="card-title"><i class="fas fa-star text-warning"></i> Highlights</h4>
                        <ul class="highlights-list">
                            <c:forTokens items="${package.highlights}" delims="," var="highlight">
                                <li>${highlight}</li>
                            </c:forTokens>
                        </ul>
                    </div>
                </div>
            </c:if>

            <!-- Inclusions & Exclusions -->
            <div class="row">
                <div class="col-md-6">
                    <div class="card shadow-sm mb-4">
                        <div class="card-body">
                            <h5 class="card-title text-success">
                                <i class="fas fa-check-circle"></i> Inclusions
                            </h5>
                            <ul class="small">
                                <c:forTokens items="${package.inclusions}" delims="," var="item">
                                    <li>${item}</li>
                                </c:forTokens>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card shadow-sm mb-4">
                        <div class="card-body">
                            <h5 class="card-title text-danger">
                                <i class="fas fa-times-circle"></i> Exclusions
                            </h5>
                            <ul class="small">
                                <c:forTokens items="${package.exclusions}" delims="," var="item">
                                    <li>${item}</li>
                                </c:forTokens>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Right Column - Booking Card -->
        <div class="col-lg-4">
            <div class="card price-summary shadow">
                <div class="card-body">
                    <h4 class="text-center mb-3">Package Price</h4>
                    <div class="text-center mb-4">
                        <h2 class="text-success">
                            ₹<fmt:formatNumber value="${package.pricePerPerson}" pattern="#,##,##0"/>
                        </h2>
                        <p class="text-muted">per person</p>
                    </div>

                    <div class="mb-3">
                        <p class="mb-2"><i class="fas fa-clock text-primary"></i> <strong>Duration:</strong> ${package.durationDays} Days / ${package.durationNights} Nights</p>
                        <p class="mb-2"><i class="fas fa-map-marker-alt text-danger"></i> <strong>Destination:</strong> ${package.destination}</p>
                    </div>

                    <a href="${pageContext.request.contextPath}/book-package?package_id=${package.packageId}"
                       class="btn btn-success btn-lg w-100 mb-2">
                        <i class="fas fa-ticket-alt"></i> Book Now
                    </a>

                    <div class="text-center mt-3">
                        <small class="text-muted">
                            <i class="fas fa-shield-alt"></i> 100% Safe & Secure Booking
                        </small>
                    </div>
                </div>
            </div>
        </div>
    </div>
</c:if>

<%@ include file="includes/footer.jspf" %>
