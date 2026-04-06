<%@ include file="includes/header.jspf" %>

<h2 class="mb-4"><i class="fas fa-ticket-alt"></i> Book Your Holiday Package</h2>

<c:if test="${not empty error}">
    <div class="alert alert-danger">${error}</div>
</c:if>

<c:if test="${not empty package}">
    <div class="row">
        <div class="col-lg-8">
            <div class="booking-form">
                <h4 class="mb-4">Traveler Details</h4>
                <form method="post" action="${pageContext.request.contextPath}/book-package" id="bookingForm">
                    <input type="hidden" name="packageId" value="${package.packageId}">
                    <input type="hidden" name="totalPrice" id="totalPrice" value="${package.pricePerPerson}">

                    <!-- Personal Information -->
                    <div class="mb-4">
                        <h5 class="text-primary"><i class="fas fa-user"></i> Personal Information</h5>
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label">Full Name *</label>
                                <input type="text" class="form-control" name="fullName" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Email *</label>
                                <input type="email" class="form-control" name="email" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Phone *</label>
                                <input type="tel" class="form-control" name="phone" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">City *</label>
                                <input type="text" class="form-control" name="city" required>
                            </div>
                            <div class="col-md-8">
                                <label class="form-label">Address</label>
                                <input type="text" class="form-control" name="address">
                            </div>
                            <div class="col-md-2">
                                <label class="form-label">State</label>
                                <input type="text" class="form-control" name="state">
                            </div>
                            <div class="col-md-2">
                                <label class="form-label">Pincode</label>
                                <input type="text" class="form-control" name="pincode">
                            </div>
                        </div>
                    </div>

                    <!-- Travel Details -->
                    <div class="mb-4">
                        <h5 class="text-primary"><i class="fas fa-calendar"></i> Travel Details</h5>
                        <div class="row g-3">
                            <div class="col-md-4">
                                <label class="form-label">Travel Date *</label>
                                <input type="date" class="form-control" name="travelDate" required
                                       min="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>">
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Adults *</label>
                                <input type="number" class="form-control" name="numAdults" id="numAdults"
                                       value="1" min="1" max="10" required>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Children</label>
                                <input type="number" class="form-control" name="numChildren" id="numChildren"
                                       value="0" min="0" max="10">
                            </div>
                        </div>
                    </div>

                    <!-- Special Requests -->
                    <div class="mb-4">
                        <label class="form-label">Special Requests (Optional)</label>
                        <textarea class="form-control" name="specialRequests" rows="3"
                                  placeholder="Any special requirements or requests..."></textarea>
                    </div>

                    <button type="submit" class="btn btn-success btn-lg w-100">
                        <i class="fas fa-check-circle"></i> Confirm Booking
                    </button>
                </form>
            </div>
        </div>

        <!-- Booking Summary -->
        <div class="col-lg-4">
            <div class="card price-summary shadow">
                <div class="card-body">
                    <h5 class="card-title">Booking Summary</h5>
                    <hr>
                    <div class="mb-3">
                        <h6>${package.packageName}</h6>
                        <p class="small text-muted mb-1">
                            <i class="fas fa-map-marker-alt"></i> ${package.destination}
                        </p>
                        <p class="small text-muted mb-0">
                            <i class="fas fa-clock"></i> ${package.durationText}
                        </p>
                    </div>
                    <hr>
                    <div class="d-flex justify-content-between mb-2">
                        <span>Price per person:</span>
                        <span class="fw-bold">₹<fmt:formatNumber value="${package.pricePerPerson}" pattern="#,##0"/></span>
                    </div>
                    <div class="d-flex justify-content-between mb-2">
                        <span>Adults:</span>
                        <span id="adultsDisplay">1</span>
                    </div>
                    <div class="d-flex justify-content-between mb-3">
                        <span>Children:</span>
                        <span id="childrenDisplay">0</span>
                    </div>
                    <hr>
                    <div class="d-flex justify-content-between mb-3">
                        <h5>Total Amount:</h5>
                        <h5 class="text-success" id="totalDisplay">₹<fmt:formatNumber value="${package.pricePerPerson}" pattern="#,##0"/></h5>
                    </div>
                    <div class="alert alert-info small">
                        <i class="fas fa-info-circle"></i> Final amount will be confirmed after booking
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        const pricePerPerson = ${package.pricePerPerson};
        const adultsInput = document.getElementById('numAdults');
        const childrenInput = document.getElementById('numChildren');
        const totalPriceInput = document.getElementById('totalPrice');

        function updatePrice() {
            const adults = parseInt(adultsInput.value) || 0;
            const children = parseInt(childrenInput.value) || 0;
            const total = (adults * pricePerPerson) + (children * pricePerPerson * 0.7);

            document.getElementById('adultsDisplay').textContent = adults;
            document.getElementById('childrenDisplay').textContent = children;
            document.getElementById('totalDisplay').textContent = '₹' + total.toLocaleString('en-IN');
            totalPriceInput.value = total.toFixed(2);
        }

        adultsInput.addEventListener('input', updatePrice);
        childrenInput.addEventListener('input', updatePrice);
    </script>
</c:if>

<%@ include file="includes/footer.jspf" %>
