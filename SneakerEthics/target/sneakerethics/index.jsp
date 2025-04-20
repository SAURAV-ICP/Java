<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SneakerEthics - Ethical Sneakers Shop</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .hero {
            background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), url('${pageContext.request.contextPath}/images/hero-bg.jpg');
            background-size: cover;
            background-position: center;
            color: white;
            text-align: center;
            padding: 6rem 2rem;
            margin-bottom: 4rem;
        }
        
        .hero h1 {
            font-size: 3rem;
            margin-bottom: 1rem;
        }
        
        .hero p {
            font-size: 1.2rem;
            max-width: 600px;
            margin: 0 auto 2rem;
        }
        
        .featured-section {
            padding: 4rem 2rem;
            background: var(--light-bg);
        }
        
        .section-title {
            text-align: center;
            margin-bottom: 3rem;
        }
        
        .featured-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 2rem;
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .featured-card {
            background: var(--white);
            border-radius: 8px;
            overflow: hidden;
            box-shadow: var(--shadow);
            transition: transform 0.3s;
        }
        
        .featured-card:hover {
            transform: translateY(-5px);
        }
        
        .featured-image {
            height: 200px;
            background-size: cover;
            background-position: center;
            position: relative;
        }
        
        .featured-tag {
            position: absolute;
            top: 10px;
            right: 10px;
            background: var(--accent-color);
            color: white;
            padding: 0.3rem 0.8rem;
            border-radius: 20px;
            font-size: 0.9rem;
        }
        
        .featured-info {
            padding: 1.5rem;
        }
        
        .featured-name {
            font-size: 1.2rem;
            margin-bottom: 0.5rem;
        }
        
        .featured-description {
            color: #666;
            margin-bottom: 1rem;
            font-size: 0.9rem;
        }
        
        .featured-meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
        }
        
        .featured-price {
            font-size: 1.2rem;
            font-weight: bold;
            color: var(--primary-color);
        }
        
        .featured-rating {
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
        
        .featured-actions {
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
        
        .cta-section {
            text-align: center;
            padding: 4rem 2rem;
            background: var(--primary-color);
            color: white;
        }
        
        .cta-section h2 {
            font-size: 2.5rem;
            margin-bottom: 1rem;
        }
        
        .cta-section p {
            font-size: 1.2rem;
            max-width: 600px;
            margin: 0 auto 2rem;
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
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <a href="${pageContext.request.contextPath}/cart" class="btn btn-secondary">Cart</a>
                        <a href="${pageContext.request.contextPath}/logout" class="btn btn-primary">Logout</a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/login" class="btn btn-secondary">Login</a>
                        <a href="${pageContext.request.contextPath}/register" class="btn btn-primary">Register</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </header>

    <main class="main-content">
        <section class="hero">
            <div class="hero-content">
                <h1>Step into Sustainable Fashion</h1>
                <p>Discover our collection of ethically sourced sneakers that make a difference.</p>
                <a href="${pageContext.request.contextPath}/shop" class="btn btn-primary">Shop Now</a>
            </div>
        </section>

        <section class="featured-sneakers">
            <h2>Featured Sneakers</h2>
            <div class="sneaker-grid">
                <c:forEach var="sneaker" items="${featuredSneakers}" begin="0" end="3">
                    <div class="sneaker-card">
                        <img src="${sneaker.imageUrl}" alt="${sneaker.name}">
                        <h3>${sneaker.name}</h3>
                        <p>${sneaker.description}</p>
                        <div class="sneaker-details">
                            <span class="price">$${sneaker.price}</span>
                            <span class="certification">${sneaker.ethicalCertification}</span>
                        </div>
                        <a href="${pageContext.request.contextPath}/shop/${sneaker.id}" class="btn btn-secondary">View Details</a>
                    </div>
                </c:forEach>
            </div>
        </section>

        <section class="about-preview">
            <h2>Why Choose SneakerEthics?</h2>
            <div class="features-grid">
                <div class="feature">
                    <h3>Ethical Sourcing</h3>
                    <p>All our sneakers are sourced from manufacturers committed to fair labor practices.</p>
                </div>
                <div class="feature">
                    <h3>Sustainable Materials</h3>
                    <p>We use eco-friendly materials to reduce our environmental impact.</p>
                </div>
                <div class="feature">
                    <h3>Quality Assurance</h3>
                    <p>Every pair is crafted with attention to detail and built to last.</p>
                </div>
            </div>
        </section>
    </main>

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