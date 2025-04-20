<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SneakerEthics - My Profile</title>
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
                    <li><a href="${pageContext.request.contextPath}/user/profile" class="active">Profile</a></li>
                    <li><a href="${pageContext.request.contextPath}/user/settings">Settings</a></li>
                </ul>
            </nav>
        </aside>

        <main class="main-content">
            <div class="profile-section">
                <h1>My Profile</h1>
                
                <%-- Display success/error messages --%>
                <c:if test="${not empty successMessage}">
                    <div class="alert alert-success">
                        ${successMessage}
                    </div>
                </c:if>
                
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-error">
                        ${errorMessage}
                    </div>
                </c:if>
                
                <div class="profile-info">
                    <div class="info-card">
                        <h2>Personal Information</h2>
                        <form action="${pageContext.request.contextPath}/user/update-profile" method="POST">
                            <div class="form-group">
                                <label for="name">Full Name</label>
                                <input type="text" id="name" name="name" value="${sessionScope.user.name}" required>
                            </div>
                            <div class="form-group">
                                <label for="email">Email</label>
                                <input type="email" id="email" name="email" value="${sessionScope.user.email}" required>
                            </div>
                            <div class="form-group">
                                <label for="phone">Phone Number</label>
                                <input type="tel" id="phone" name="phone" value="${sessionScope.user.phone}">
                            </div>
                            <button type="submit" class="btn btn-primary">Update Profile</button>
                        </form>
                    </div>

                    <div class="info-card">
                        <h2>Change Password</h2>
                        <form action="${pageContext.request.contextPath}/user/change-password" method="POST">
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
                </div>

                <div class="recent-orders">
                    <h2>Recent Orders</h2>
                    <c:choose>
                        <c:when test="${not empty orders}">
                            <div class="orders-list">
                                <c:forEach var="order" items="${orders}">
                                    <div class="order-card">
                                        <div class="order-header">
                                            <span class="order-id">Order #${order.id}</span>
                                            <span class="order-date">${order.orderDate}</span>
                                            <span class="order-status ${order.status.toLowerCase()}">${order.status}</span>
                                        </div>
                                        <div class="order-items">
                                            <c:forEach var="item" items="${order.items}">
                                                <div class="order-item">
                                                    <img src="${pageContext.request.contextPath}/images/sneakers/${item.sneaker.imageUrl}" alt="${item.sneaker.name}">
                                                    <div class="item-info">
                                                        <h4>${item.sneaker.name}</h4>
                                                        <p>Quantity: ${item.quantity}</p>
                                                        <p>Price: $${item.price}</p>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </div>
                                        <div class="order-footer">
                                            <span class="order-total">Total: $${order.totalPrice}</span>
                                            <a href="${pageContext.request.contextPath}/user/orders/${order.id}" class="btn btn-secondary">View Details</a>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <p class="no-orders">You haven't placed any orders yet.</p>
                        </c:otherwise>
                    </c:choose>
                </div>
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