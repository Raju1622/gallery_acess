<%@ include file="includes/header.jspf" %>

<h2 class="mb-4"><i class="fas fa-suitcase-rolling"></i> Browse Holiday Packages</h2>

<c:if test="${not empty error}">
    <div class="alert alert-danger">${error}</div>
</c:if>

<!-- Filter Section -->
<div class="row mb-4">
    <div class="col-md-12">
        <div class="card shadow-sm">
            <div class="card-body">
                <form method="get" action="${pageContext.request.contextPath}/packages">
                    <div class="row g-3">
                        <div class="col-md-8">
                            <input type="text" class="form-control" name="destination"
                                   value="${searchDestination}" placeholder="Search by destination...">
                        </div>
                        <div class="col-md-4">
                            <button type="submit" class="btn btn-primary w-100">
                                <i class="fas fa-search"></i> Search
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Packages Grid -->
<div class="row g-4">
    <c:choose>
        <c:when test="${not empty packages}">
            <c:forEach var="pkg" items="${packages}">
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
                                </span>
                            </div>
                            <h5 class="card-title">${pkg.packageName}</h5>
                            <p class="text-muted small mb-2">
                                <i class="fas fa-map-marker-alt"></i> ${pkg.destination}
                            </p>
                            <div class="d-flex justify-content-between align-items-center mt-3">
                                <span class="badge bg-light text-dark">
                                    <i class="fas fa-clock"></i> ${pkg.durationText}
                                </span>
                                <h5 class="text-success mb-0">
                                    ₹<fmt:formatNumber value="${pkg.pricePerPerson}" pattern="#,##0"/>
                                </h5>
                            </div>
                        </div>
                        <div class="card-footer bg-white">
                            <a href="${pageContext.request.contextPath}/package-details?id=${pkg.packageId}"
                               class="btn btn-primary w-100">View Details</a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <div class="col-12">
                <div class="alert alert-info text-center">
                    <i class="fas fa-info-circle fa-2x mb-3"></i>
                    <h5>No packages found</h5>
                    <p>Try searching with different keywords</p>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<%@ include file="includes/footer.jspf" %>
