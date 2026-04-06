<%@ include file="includes/header.jspf" %>

<div class="text-center my-5">
    <c:if test="${not empty booking}">
        <div class="confirmation-success">
            <i class="fas fa-check-circle text-success" style="font-size: 80px;"></i>
            <h1 class="mt-4 mb-3">Booking Confirmed!</h1>
            <p class="lead text-muted">Thank you for booking with BharatYatra</p>

            <div class="card shadow-sm mx-auto mt-4" style="max-width: 600px;">
                <div class="card-body text-start">
                    <h5 class="card-title border-bottom pb-2 mb-3">Booking Details</h5>

                    <div class="row mb-2">
                        <div class="col-6"><strong>Booking Reference:</strong></div>
                        <div class="col-6 text-primary fw-bold">${booking.bookingReference}</div>
                    </div>

                    <div class="row mb-2">
                        <div class="col-6"><strong>Package:</strong></div>
                        <div class="col-6">${booking.packageName}</div>
                    </div>

                    <div class="row mb-2">
                        <div class="col-6"><strong>Travel Date:</strong></div>
                        <div class="col-6"><fmt:formatDate value="${booking.travelDate}" pattern="dd MMM yyyy"/></div>
                    </div>

                    <div class="row mb-2">
                        <div class="col-6"><strong>Travelers:</strong></div>
                        <div class="col-6">${booking.numAdults} Adults, ${booking.numChildren} Children</div>
                    </div>

                    <div class="row mb-2">
                        <div class="col-6"><strong>Total Amount:</strong></div>
                        <div class="col-6 text-success fw-bold">₹<fmt:formatNumber value="${booking.totalPrice}" pattern="#,##0"/></div>
                    </div>

                    <div class="row mb-2">
                        <div class="col-6"><strong>Status:</strong></div>
                        <div class="col-6">
                            <span class="badge bg-warning">${booking.bookingStatus}</span>
                        </div>
                    </div>

                    <hr>

                    <h6 class="mt-3">Contact Information</h6>
                    <p class="mb-1"><i class="fas fa-user"></i> ${booking.customerName}</p>
                    <p class="mb-1"><i class="fas fa-envelope"></i> ${booking.customerEmail}</p>
                    <p class="mb-0"><i class="fas fa-phone"></i> ${booking.customerPhone}</p>
                </div>
            </div>

            <div class="alert alert-info mx-auto mt-4" style="max-width: 600px;">
                <i class="fas fa-info-circle"></i> A confirmation email has been sent to your email address.
                Our team will contact you shortly to confirm the booking.
            </div>

            <div class="mt-4">
                <a href="${pageContext.request.contextPath}/" class="btn btn-primary">
                    <i class="fas fa-home"></i> Back to Home
                </a>
                <a href="${pageContext.request.contextPath}/packages" class="btn btn-outline-primary">
                    <i class="fas fa-search"></i> Browse More Packages
                </a>
            </div>
        </div>
    </c:if>

    <c:if test="${empty booking}">
        <div class="alert alert-warning">
            <i class="fas fa-exclamation-triangle"></i> No booking found!
        </div>
        <a href="${pageContext.request.contextPath}/" class="btn btn-primary">Go to Home</a>
    </c:if>
</div>

<%@ include file="includes/footer.jspf" %>
