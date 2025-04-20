<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SneakerEthics - My Orders</title>
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
                    <li><a href="${pageContext.request.contextPath}/user/orders" class="active">My Orders</a></li>
                    <li><a href="${pageContext.request.contextPath}/user/wishlist">Wishlist</a></li>
                    <li><a href="${pageContext.request.contextPath}/user/settings">Settings</a></li>
                </ul>
            </nav>
        </aside>

        <main class="main-content">
            <h1>My Orders</h1>
            <div class="orders-list">
                <c:forEach var="order" items="${orders}">
                    <div class="order-card">
                        <div class="order-header">
                            <span class="order-id">Order #${order.id}</span>
                            <span class="order-date">${order.orderDate}</span>
                        </div>
                        <div class="order-items">
                            <c:forEach var="item" items="${order.items}">
                                <div class="order-item">
                                    <img src="${pageContext.request.contextPath}/images/sneakers/${item.sneaker.imageUrl}" alt="${item.sneaker.name}">
                                    <div class="item-details">
                                        <h3>${item.sneaker.name}</h3>
                                        <p>Quantity: ${item.quantity}</p>
                                        <p>Price: $${item.price}</p>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        <div class="order-footer">
                            <span class="order-total">Total: $${order.totalPrice}</span>
                            <span class="order-status">${order.status}</span>
                        </div>
                    </div>
                </c:forEach>
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