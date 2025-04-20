package com.sneakerethics.model;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * User model class representing a user in the SneakerEthics system.
 * Implements Serializable for session management.
 */
public class User implements Serializable {
    private static final long serialVersionUID = 1L;
    
    private int id;
    private String username;
    private String email;
    private String password;
    private String name;
    private String phone;
    private String role;
    private LocalDateTime createdAt;
    
    // Default constructor
    public User() {
        this.createdAt = LocalDateTime.now();
        this.role = "user"; // Default role
    }
    
    // Constructor with all fields
    public User(String username, String email, String password, String name) {
        this.username = username;
        this.email = email;
        this.password = password;
        this.name = name;
        this.role = "user"; // Default role
        this.createdAt = LocalDateTime.now();
    }
    
    // Constructor with role
    public User(String username, String email, String password, String name, String role) {
        this.username = username;
        this.email = email;
        this.password = password;
        this.name = name;
        this.role = role;
        this.createdAt = LocalDateTime.now();
    }
    
    // Getters and Setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public String getUsername() {
        return username;
    }
    
    public void setUsername(String username) {
        this.username = username;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getPassword() {
        return password;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public String getPhone() {
        return phone;
    }
    
    public void setPhone(String phone) {
        this.phone = phone;
    }
    
    public String getRole() {
        return role;
    }
    
    public void setRole(String role) {
        this.role = role;
    }
    
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
    
    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", email='" + email + '\'' +
                ", name='" + name + '\'' +
                ", phone='" + phone + '\'' +
                ", role='" + role + '\'' +
                ", createdAt=" + createdAt +
                '}';
    }
} 