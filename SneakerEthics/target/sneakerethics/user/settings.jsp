<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SneakerEthics - Settings</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <header class="header">
        <div class="nav-container">
            <a href="${pageContext.request.contextPath}/" class="logo">Sneaker<span>Ethics</span></a>
            <nav>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/">Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/shop">Shop</a></li>
                    <li><a href="${pageContext.request.contextPath}/about">About</a></li>
                    <li><a href="${pageContext.request.contextPath}/contact">Contact</a></li>
                </ul>
            </nav>
            <div class="auth-buttons">
                <a href="${pageContext.request.contextPath}/cart" class="btn btn-secondary">Cart</a>
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-primary">Logout</a>
            </div>
        </div>
    </header>

    <div class="dashboard-layout">
        <aside class="sidebar">
            <div class="sidebar-header">
                <div class="user-avatar">
                    ${sessionScope.user.name.charAt(0)}
                </div>
                <h3>${sessionScope.user.name}</h3>
                <p>Premium Member</p>
            </div>
            <nav class="sidebar-nav">
                <ul>
                    <li><a href="${pageContext.request.contextPath}/user/dashboard">Dashboard</a></li>
                    <li><a href="${pageContext.request.contextPath}/user/orders">My Orders</a></li>
                    <li><a href="${pageContext.request.contextPath}/user/wishlist">Wishlist</a></li>
                    <li><a href="${pageContext.request.contextPath}/user/settings" class="active">Settings</a></li>
                </ul>
            </nav>
        </aside>

        <main class="main-content">
            <h1>Account Settings</h1>
            
            <div class="settings-section">
                <h2>Profile Information</h2>
                <form action="${pageContext.request.contextPath}/user/update-profile" method="post">
                    <div class="form-group">
                        <label for="name">Full Name</label>
                        <input type="text" id="name" name="name" value="${sessionScope.user.name}" required>
                    </div>
                    <div class="form-group">
                        <label for="email">Email</label>
                        <input type="email" id="email" name="email" value="${sessionScope.user.email}" required>
                    </div>
                    <div class="form-group">
                        <label for="phone">Phone</label>
                        <input type="tel" id="phone" name="phone" value="${sessionScope.user.phone}">
                    </div>
                    <button type="submit" class="btn btn-primary">Update Profile</button>
                </form>
            </div>

            <div class="settings-section">
                <h2>Change Password</h2>
                <form action="${pageContext.request.contextPath}/user/change-password" method="post">
                    <div class="form-group">
                        <label for="currentPassword">Current Password</label>
                        <input type="password" id="currentPassword" name="currentPassword" required>
                    </div>
                    <div class="form-group">
                        <label for="newPassword">New Password</label>
                        <input type="password" id="newPassword" name="newPassword" required>
                    </div>
                    <div class="form-group">
                        <label for="confirmPassword">Confirm New Password</label>
                        <input type="password" id="confirmPassword" name="confirmPassword" required>
                    </div>
                    <button type="submit" class="btn btn-primary">Change Password</button>
                </form>
            </div>

            <div class="settings-section">
                <h2>Notification Preferences</h2>
                <form action="${pageContext.request.contextPath}/user/update-notifications" method="post">
                    <div class="form-group">
                        <label class="checkbox-label">
                            <input type="checkbox" name="emailNotifications" checked>
                            Email Notifications
                        </label>
                    </div>
                    <div class="form-group">
                        <label class="checkbox-label">
                            <input type="checkbox" name="smsNotifications">
                            SMS Notifications
                        </label>
                    </div>
                    <button type="submit" class="btn btn-primary">Update Preferences</button>
                </form>
            </div>
        </main>
    </div>

    <footer>
        <div class="footer-content">
            <div class="footer-section">
                <h3>About Us</h3>
                <p>We're committed to creating sustainable, ethical sneakers that don't compromise on style or performance.</p>
            </div>
            <div class="footer-section">
                <h3>Quick Links</h3>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/">Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/shop">Shop</a></li>
                    <li><a href="${pageContext.request.contextPath}/about">About</a></li>
                    <li><a href="${pageContext.request.contextPath}/contact">Contact</a></li>
                </ul>
            </div>
            <div class="footer-section">
                <h3>Contact Us</h3>
                <p>Email: info@sneakerethics.com</p>
                <p>Phone: (123) 456-7890</p>
            </div>
        </div>
        <div class="copyright">
            <p>&copy; 2024 SneakerEthics. All rights reserved.</p>
        </div>
    </footer>
</body>
</html> 