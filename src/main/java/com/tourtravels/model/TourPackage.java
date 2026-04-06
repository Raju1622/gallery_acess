package com.tourtravels.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

/**
 * Tour Package Model
 * Represents a tour package in the system
 */
public class TourPackage {

    private int packageId;
    private int categoryId;
    private String packageName;
    private String destination;
    private int durationDays;
    private int durationNights;
    private BigDecimal price;
    private String description;
    private String highlights;
    private String inclusions;
    private String exclusions;
    private String imageUrl;
    private BigDecimal rating;
    private int totalReviews;
    private boolean isFeatured;
    private boolean isActive;
    private Timestamp createdAt;

    // Category name (for display)
    private String categoryName;

    // Constructors
    public TourPackage() {
    }

    public TourPackage(int packageId, String packageName, String destination,
                      int durationDays, int durationNights, BigDecimal price) {
        this.packageId = packageId;
        this.packageName = packageName;
        this.destination = destination;
        this.durationDays = durationDays;
        this.durationNights = durationNights;
        this.price = price;
    }

    // Getters and Setters
    public int getPackageId() {
        return packageId;
    }

    public void setPackageId(int packageId) {
        this.packageId = packageId;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getPackageName() {
        return packageName;
    }

    public void setPackageName(String packageName) {
        this.packageName = packageName;
    }

    public String getDestination() {
        return destination;
    }

    public void setDestination(String destination) {
        this.destination = destination;
    }

    public int getDurationDays() {
        return durationDays;
    }

    public void setDurationDays(int durationDays) {
        this.durationDays = durationDays;
    }

    public int getDurationNights() {
        return durationNights;
    }

    public void setDurationNights(int durationNights) {
        this.durationNights = durationNights;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getHighlights() {
        return highlights;
    }

    public void setHighlights(String highlights) {
        this.highlights = highlights;
    }

    public String getInclusions() {
        return inclusions;
    }

    public void setInclusions(String inclusions) {
        this.inclusions = inclusions;
    }

    public String getExclusions() {
        return exclusions;
    }

    public void setExclusions(String exclusions) {
        this.exclusions = exclusions;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public BigDecimal getRating() {
        return rating;
    }

    public void setRating(BigDecimal rating) {
        this.rating = rating;
    }

    public int getTotalReviews() {
        return totalReviews;
    }

    public void setTotalReviews(int totalReviews) {
        this.totalReviews = totalReviews;
    }

    public boolean isFeatured() {
        return isFeatured;
    }

    public void setFeatured(boolean featured) {
        isFeatured = featured;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    // Utility methods
    public String getDurationText() {
        return durationNights + "N / " + durationDays + "D";
    }

    @Override
    public String toString() {
        return "TourPackage{" +
                "packageId=" + packageId +
                ", packageName='" + packageName + '\'' +
                ", destination='" + destination + '\'' +
                ", price=" + price +
                '}';
    }
}
