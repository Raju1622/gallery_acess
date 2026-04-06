package com.bharatyatra.model;

import java.math.BigDecimal;
import java.sql.Date;

public class HolidayPackage {
    private int packageId;
    private String packageName;
    private int categoryId;
    private String categoryName;
    private String destination;
    private int durationDays;
    private int durationNights;
    private BigDecimal pricePerPerson;
    private String description;
    private String highlights;
    private String inclusions;
    private String exclusions;
    private String imageUrl;
    private boolean isFeatured;
    private BigDecimal rating;
    private int totalReviews;
    private Date availableFrom;
    private Date availableTo;
    private String status;

    // Constructors
    public HolidayPackage() {}

    // Getters and Setters
    public int getPackageId() { return packageId; }
    public void setPackageId(int packageId) { this.packageId = packageId; }

    public String getPackageName() { return packageName; }
    public void setPackageName(String packageName) { this.packageName = packageName; }

    public int getCategoryId() { return categoryId; }
    public void setCategoryId(int categoryId) { this.categoryId = categoryId; }

    public String getCategoryName() { return categoryName; }
    public void setCategoryName(String categoryName) { this.categoryName = categoryName; }

    public String getDestination() { return destination; }
    public void setDestination(String destination) { this.destination = destination; }

    public int getDurationDays() { return durationDays; }
    public void setDurationDays(int durationDays) { this.durationDays = durationDays; }

    public int getDurationNights() { return durationNights; }
    public void setDurationNights(int durationNights) { this.durationNights = durationNights; }

    public BigDecimal getPricePerPerson() { return pricePerPerson; }
    public void setPricePerPerson(BigDecimal pricePerPerson) { this.pricePerPerson = pricePerPerson; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getHighlights() { return highlights; }
    public void setHighlights(String highlights) { this.highlights = highlights; }

    public String getInclusions() { return inclusions; }
    public void setInclusions(String inclusions) { this.inclusions = inclusions; }

    public String getExclusions() { return exclusions; }
    public void setExclusions(String exclusions) { this.exclusions = exclusions; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public boolean isFeatured() { return isFeatured; }
    public void setFeatured(boolean featured) { isFeatured = featured; }

    public BigDecimal getRating() { return rating; }
    public void setRating(BigDecimal rating) { this.rating = rating; }

    public int getTotalReviews() { return totalReviews; }
    public void setTotalReviews(int totalReviews) { this.totalReviews = totalReviews; }

    public Date getAvailableFrom() { return availableFrom; }
    public void setAvailableFrom(Date availableFrom) { this.availableFrom = availableFrom; }

    public Date getAvailableTo() { return availableTo; }
    public void setAvailableTo(Date availableTo) { this.availableTo = availableTo; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getDurationText() {
        return durationDays + "D/" + durationNights + "N";
    }
}
