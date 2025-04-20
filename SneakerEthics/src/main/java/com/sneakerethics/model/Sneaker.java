package com.sneakerethics.model;

import java.sql.Timestamp;

public class Sneaker {
    private int id;
    private String name;
    private String description;
    private double price;
    private int stock;
    private String ethicalCertification;
    private String imageUrl;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // Default constructor
    public Sneaker() {}

    // Constructor with all fields
    public Sneaker(int id, String name, String description, double price, int stock,
                  String ethicalCertification, String imageUrl, Timestamp createdAt,
                  Timestamp updatedAt) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.price = price;
        this.stock = stock;
        this.ethicalCertification = ethicalCertification;
        this.imageUrl = imageUrl;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public String getEthicalCertification() {
        return ethicalCertification;
    }

    public void setEthicalCertification(String ethicalCertification) {
        this.ethicalCertification = ethicalCertification;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    // toString method for debugging
    @Override
    public String toString() {
        return "Sneaker{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", price=" + price +
                ", stock=" + stock +
                ", ethicalCertification='" + ethicalCertification + '\'' +
                ", imageUrl='" + imageUrl + '\'' +
                ", createdAt=" + createdAt +
                ", updatedAt=" + updatedAt +
                '}';
    }
} 