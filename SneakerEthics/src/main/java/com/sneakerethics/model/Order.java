package com.sneakerethics.model;

import java.time.LocalDateTime;
import java.util.List;

public class Order {
    private int id;
    private int userId;
    private int sneakerId;
    private int quantity;
    private double totalPrice;
    private String status;
    private String shippingAddress;
    private String shippingCity;
    private String shippingState;
    private String shippingZip;
    private LocalDateTime orderDate;
    private String paymentMethod;
    private List<OrderItem> items;

    public Order() {
        this.orderDate = LocalDateTime.now();
    }

    public Order(int userId, String status, double totalPrice, String shippingAddress) {
        this.userId = userId;
        this.status = status;
        this.totalPrice = totalPrice;
        this.shippingAddress = shippingAddress;
        this.orderDate = LocalDateTime.now();
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getSneakerId() {
        return sneakerId;
    }

    public void setSneakerId(int sneakerId) {
        this.sneakerId = sneakerId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getShippingAddress() {
        return shippingAddress;
    }

    public void setShippingAddress(String shippingAddress) {
        this.shippingAddress = shippingAddress;
    }

    public String getShippingCity() {
        return shippingCity;
    }

    public void setShippingCity(String shippingCity) {
        this.shippingCity = shippingCity;
    }

    public String getShippingState() {
        return shippingState;
    }

    public void setShippingState(String shippingState) {
        this.shippingState = shippingState;
    }

    public String getShippingZip() {
        return shippingZip;
    }

    public void setShippingZip(String shippingZip) {
        this.shippingZip = shippingZip;
    }

    public LocalDateTime getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(LocalDateTime orderDate) {
        this.orderDate = orderDate;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public List<OrderItem> getItems() {
        return items;
    }

    public void setItems(List<OrderItem> items) {
        this.items = items;
    }

    // Inner class for OrderItem
    public static class OrderItem {
        private int id;
        private int orderId;
        private int sneakerId;
        private int quantity;
        private double price;
        private Sneaker sneaker;

        public OrderItem() {}

        public OrderItem(int orderId, int sneakerId, int quantity, double price) {
            this.orderId = orderId;
            this.sneakerId = sneakerId;
            this.quantity = quantity;
            this.price = price;
        }

        // Getters and Setters
        public int getId() {
            return id;
        }

        public void setId(int id) {
            this.id = id;
        }

        public int getOrderId() {
            return orderId;
        }

        public void setOrderId(int orderId) {
            this.orderId = orderId;
        }

        public int getSneakerId() {
            return sneakerId;
        }

        public void setSneakerId(int sneakerId) {
            this.sneakerId = sneakerId;
        }

        public int getQuantity() {
            return quantity;
        }

        public void setQuantity(int quantity) {
            this.quantity = quantity;
        }

        public double getPrice() {
            return price;
        }

        public void setPrice(double price) {
            this.price = price;
        }

        public Sneaker getSneaker() {
            return sneaker;
        }

        public void setSneaker(Sneaker sneaker) {
            this.sneaker = sneaker;
        }

        public double getSubtotal() {
            return quantity * price;
        }
    }
} 