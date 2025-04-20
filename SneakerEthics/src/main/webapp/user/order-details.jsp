<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SneakerEthics - Order Details</title>
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
                    <li><a href="${pageContext.request.contextPath}/user/profile">Profile</a></li>
                    <li><a href="${pageContext.request.contextPath}/user/settings">Settings</a></li>
                </ul>
            </nav>
        </aside>

        <main class="main-content">
            <div class="order-details-container">
                <h1>Order Details</h1>
                <c:if test="${not empty order}">
                    <div class="order-info">
                        <div class="order-header">
                            <h2>Order #${order.id}</h2>
                            <span class="order-status ${order.status.toLowerCase()}">${order.status}</span>
                        </div>
                        <div class="order-date">
                            <p>Order Date: ${order.orderDate}</p>
                            <p>Estimated Delivery: ${order.estimatedDeliveryDate}</p>
                        </div>
                    </div>

                    <div class="shipping-info">
                        <h3>Shipping Information</h3>
                        <p>${order.shippingAddress.street}</p>
                        <p>${order.shippingAddress.city}, ${order.shippingAddress.state} ${order.shippingAddress.zipCode}</p>
                        <p>${order.shippingAddress.country}</p>
                    </div>

                    <div class="order-items">
                        <h3>Order Items</h3>
                        <c:forEach var="item" items="${order.items}">
                            <div class="order-item">
                                <img src="${item.sneaker.imageUrl}" alt="${item.sneaker.name}">
                                <div class="item-details">
                                    <h4>${item.sneaker.name}</h4>
                                    <p>Size: ${item.size}</p>
                                    <p>Quantity: ${item.quantity}</p>
                                    <p>Price: $${item.price}</p>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <div class="order-summary">
                        <h3>Order Summary</h3>
                        <div class="summary-item">
                            <span>Subtotal</span>
                            <span>$${order.subtotal}</span>
                        </div>
                        <div class="summary-item">
                            <span>Shipping</span>
                            <span>$${order.shippingCost}</span>
                        </div>
                        <div class="summary-item">
                            <span>Tax</span>
                            <span>$${order.tax}</span>
                        </div>
                        <div class="summary-item total">
                            <span>Total</span>
                            <span>$${order.total}</span>
                        </div>
                    </div>
                </c:if>
                <c:if test="${empty order}">
                    <div class="no-order">
                        <p>Order not found or you don't have permission to view this order.</p>
                        <a href="${pageContext.request.contextPath}/user/orders" class="btn btn-primary">Back to Orders</a>
                    </div>
                </c:if>
            </div>
        </main>
    </div>

    <footer class="footer">
        <div class="footer-content">
            <div class="footer-section">
                <h3>SneakerEthics</h3>
                <p>Your trusted source for ethical sneakers.</p>
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
        <div class="footer-bottom">
            <p>&copy; 2024 SneakerEthics. All rights reserved.</p>
        </div>
    </footer>
</body>
</html> 