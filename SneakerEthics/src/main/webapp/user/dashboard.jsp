<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SneakerEthics - Premium Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .dashboard-layout {
            display: flex;
            min-height: calc(100vh - 60px);
        }
        
        .sidebar {
            width: 250px;
            background: var(--white);
            padding: 2rem;
            box-shadow: var(--shadow);
            position: fixed;
            height: calc(100vh - 60px);
            overflow-y: auto;
        }
        
        .sidebar-header {
            text-align: center;
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid #eee;
        }
        
        .user-avatar {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            margin: 0 auto 1rem;
            background: var(--primary-color);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 2rem;
        }
        
        .sidebar-nav {
            list-style: none;
            padding: 0;
        }
        
        .sidebar-nav li {
            margin-bottom: 0.5rem;
        }
        
        .sidebar-nav a {
            display: flex;
            align-items: center;
            padding: 0.8rem 1rem;
            color: var(--text-color);
            border-radius: 4px;
            transition: var(--transition);
        }
        
        .sidebar-nav a:hover {
            background: var(--light-bg);
            color: var(--primary-color);
        }
        
        .sidebar-nav a.active {
            background: var(--primary-color);
            color: white;
        }
        
        .main-content {
            flex: 1;
            margin-left: 250px;
            padding: 2rem;
        }
        
        .premium-banner {
            background: linear-gradient(135deg, #2c3e50, #3498db);
            color: white;
            padding: 2rem;
            border-radius: 8px;
            margin-bottom: 2rem;
            position: relative;
            overflow: hidden;
        }
        
        .premium-banner::before {
            content: 'PREMIUM';
            position: absolute;
            top: 10px;
            right: 10px;
            background: rgba(255, 255, 255, 0.2);
            padding: 0.3rem 0.8rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: bold;
        }
        
        .sneaker-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 2rem;
        }
        
        .sneaker-card {
            background: var(--white);
            border-radius: 8px;
            overflow: hidden;
            box-shadow: var(--shadow);
            transition: transform 0.3s;
        }
        
        .sneaker-card:hover {
            transform: translateY(-5px);
        }
        
        .sneaker-image {
            height: 200px;
            background-size: cover;
            background-position: center;
            position: relative;
        }
        
        .sneaker-discount {
            position: absolute;
            top: 10px;
            right: 10px;
            background: var(--accent-color);
            color: white;
            padding: 0.3rem 0.8rem;
            border-radius: 20px;
            font-size: 0.9rem;
        }
        
        .sneaker-info {
            padding: 1.5rem;
        }
        
        .sneaker-name {
            font-size: 1.2rem;
            margin-bottom: 0.5rem;
        }
        
        .sneaker-description {
            color: #666;
            margin-bottom: 1rem;
            font-size: 0.9rem;
        }
        
        .sneaker-meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
        }
        
        .sneaker-price {
            font-size: 1.2rem;
            font-weight: bold;
            color: var(--primary-color);
        }
        
        .sneaker-rating {
            color: var(--accent-color);
        }
        
        .ethical-tag {
            display: inline-block;
            background: var(--light-bg);
            color: var(--primary-color);
            padding: 0.3rem 0.8rem;
            border-radius: 20px;
            font-size: 0.8rem;
            margin-bottom: 1rem;
        }
        
        .sneaker-actions {
            display: flex;
            gap: 1rem;
        }
        
        .add-to-cart {
            flex: 1;
            background: var(--primary-color);
            color: white;
            border: none;
            padding: 0.8rem;
            border-radius: 4px;
            cursor: pointer;
            transition: var(--transition);
        }
        
        .add-to-cart:hover {
            background: var(--secondary-color);
        }
        
        .wishlist-btn {
            background: none;
            border: none;
            font-size: 1.5rem;
            cursor: pointer;
            color: #ccc;
            transition: var(--transition);
        }
        
        .wishlist-btn:hover {
            color: var(--accent-color);
        }
        
        .search-filter {
            display: flex;
            gap: 1rem;
            margin-bottom: 2rem;
        }
        
        .search-bar {
            flex: 1;
        }
        
        .search-bar input {
            width: 100%;
            padding: 0.8rem;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        
        .filter-dropdown select {
            padding: 0.8rem;
            border: 1px solid #ddd;
            border-radius: 4px;
            background: white;
        }
    </style>
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
                    <li><a href="${pageContext.request.contextPath}/user/dashboard" class="active">Dashboard</a></li>
                    <li><a href="${pageContext.request.contextPath}/user/orders">My Orders</a></li>
                    <li><a href="${pageContext.request.contextPath}/user/wishlist">Wishlist</a></li>
                    <li><a href="${pageContext.request.contextPath}/user/settings">Settings</a></li>
                    <li><a href="${pageContext.request.contextPath}/user/premium">Premium Features</a></li>
                </ul>
            </nav>
        </aside>

        <main class="main-content">
            <div class="premium-banner">
                <h1>Welcome to Your Premium Dashboard</h1>
                <p>Access exclusive sneakers and enjoy premium benefits</p>
            </div>

            <div class="search-filter">
                <div class="search-bar">
                    <input type="text" id="searchInput" placeholder="Search premium sneakers...">
                </div>
                <div class="filter-dropdown">
                    <select id="categoryFilter">
                        <option value="">All Categories</option>
                        <option value="running">Running</option>
                        <option value="casual">Casual</option>
                        <option value="basketball">Basketball</option>
                        <option value="limited">Limited Edition</option>
                    </select>
                </div>
            </div>

            <div class="sneaker-grid">
                <c:forEach var="sneaker" items="${sneakers}">
                    <div class="sneaker-card" data-category="${sneaker.category}">
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
                                <button class="wishlist-btn" onclick="toggleWishlist('${sneaker.id}')">♥</button>
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
                } else {
                    alert('Failed to update wishlist: ' + data.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('An error occurred while updating wishlist');
            });
        }

        // Search functionality
        document.getElementById('searchInput').addEventListener('input', function(e) {
            const searchTerm = e.target.value.toLowerCase();
            const sneakerCards = document.querySelectorAll('.sneaker-card');
            
            sneakerCards.forEach(card => {
                const name = card.querySelector('.sneaker-name').textContent.toLowerCase();
                const description = card.querySelector('.sneaker-description').textContent.toLowerCase();
                
                if (name.includes(searchTerm) || description.includes(searchTerm)) {
                    card.style.display = '';
                } else {
                    card.style.display = 'none';
                }
            });
        });

        // Category filter functionality
        document.getElementById('categoryFilter').addEventListener('change', function(e) {
            const category = e.target.value;
            const sneakerCards = document.querySelectorAll('.sneaker-card');
            
            sneakerCards.forEach(card => {
                if (!category || card.dataset.category === category) {
                    card.style.display = '';
                } else {
                    card.style.display = 'none';
                }
            });
        });
    </script>
</body>
</html> 