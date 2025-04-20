<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SneakerEthics - My Wishlist</title>
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
                    <li><a href="${pageContext.request.contextPath}/user/wishlist" class="active">Wishlist</a></li>
                    <li><a href="${pageContext.request.contextPath}/user/settings">Settings</a></li>
                </ul>
            </nav>
        </aside>

        <main class="main-content">
            <h1>My Wishlist</h1>
            <div class="sneaker-grid">
                <c:forEach var="sneaker" items="${wishlist}">
                    <div class="sneaker-card">
                        <div class="sneaker-image" style="background-image: url('${pageContext.request.contextPath}/images/sneakers/${sneaker.imageUrl}')">
                            <c:if test="${sneaker.discount > 0}">
                                <span class="sneaker-discount">-${sneaker.discount}%</span>
                            </c:if>
                        </div>
                        <div class="sneaker-info">
                            <h3 class="sneaker-name">${sneaker.name}</h3>
                            <p class="sneaker-description">${sneaker.description}</p>
                            <div class="sneaker-meta">
                                <span class="sneaker-price">$${sneaker.price}</span>
                                <span class="sneaker-rating">★ ${sneaker.rating}</span>
                            </div>
                            <span class="ethical-tag">${sneaker.ethicalCertification}</span>
                            <div class="sneaker-actions">
                                <button class="add-to-cart" onclick="addToCart('${sneaker.id}')">Add to Cart</button>
                                <button class="wishlist-btn active" onclick="toggleWishlist('${sneaker.id}')">♥</button>
                            </div>
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

    <script>
        function addToCart(sneakerId) {
            fetch('${pageContext.request.contextPath}/cart/add', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ sneakerId: parseInt(sneakerId) })
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('Added to cart successfully!');
                } else {
                    alert('Failed to add to cart: ' + data.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('An error occurred while adding to cart');
            });
        }

        function toggleWishlist(sneakerId) {
            fetch('${pageContext.request.contextPath}/wishlist/toggle', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ sneakerId: parseInt(sneakerId) })
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    const button = document.activeElement;
                    button.style.color = data.isInWishlist ? '#ff6f00' : '#ccc';
                    if (!data.isInWishlist) {
                        // Remove the card from the wishlist
                        button.closest('.sneaker-card').remove();
                    }
                } else {
                    alert('Failed to update wishlist: ' + data.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('An error occurred while updating wishlist');
            });
        }
    </script>
</body>
</html> 