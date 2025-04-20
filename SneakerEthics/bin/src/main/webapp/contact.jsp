<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Contact Us - SneakerEthics</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/contact.css">
</head>
<body>
    <header>
        <nav>
            <div class="logo">
                <a href="index.jsp">SneakerEthics</a>
            </div>
            <ul class="nav-links">
                <li><a href="index.jsp">Home</a></li>
                <li><a href="cart.jsp">Cart</a></li>
                <li><a href="orders.jsp">Orders</a></li>
                <li><a href="profile.jsp">Profile</a></li>
                <li><a href="logout">Logout</a></li>
            </ul>
        </nav>
    </header>

    <main class="contact-container">
        <section class="contact-hero">
            <h1>Contact Us</h1>
            <p class="subtitle">We'd love to hear from you</p>
        </section>

        <div class="contact-grid">
            <section class="contact-form-section">
                <h2>Send us a Message</h2>
                <form id="contact-form" class="contact-form">
                    <div class="form-group">
                        <label for="name">Full Name</label>
                        <input type="text" id="name" name="name" required>
                    </div>
                    <div class="form-group">
                        <label for="email">Email</label>
                        <input type="email" id="email" name="email" required>
                    </div>
                    <div class="form-group">
                        <label for="subject">Subject</label>
                        <input type="text" id="subject" name="subject" required>
                    </div>
                    <div class="form-group">
                        <label for="message">Message</label>
                        <textarea id="message" name="message" rows="5" required></textarea>
                    </div>
                    <button type="submit" class="btn-primary">Send Message</button>
                </form>
            </section>

            <section class="contact-info-section">
                <h2>Contact Information</h2>
                <div class="contact-info">
                    <div class="info-item">
                        <div class="info-icon">📍</div>
                        <div class="info-content">
                            <h3>Address</h3>
                            <p>123 Sustainable Street<br>Green City, GC 12345</p>
                        </div>
                    </div>
                    <div class="info-item">
                        <div class="info-icon">📞</div>
                        <div class="info-content">
                            <h3>Phone</h3>
                            <p>+1 (555) 123-4567</p>
                        </div>
                    </div>
                    <div class="info-item">
                        <div class="info-icon">✉️</div>
                        <div class="info-content">
                            <h3>Email</h3>
                            <p>info@sneakerethics.com</p>
                        </div>
                    </div>
                </div>

                <div class="business-hours">
                    <h3>Business Hours</h3>
                    <ul>
                        <li>Monday - Friday: 9:00 AM - 6:00 PM</li>
                        <li>Saturday: 10:00 AM - 4:00 PM</li>
                        <li>Sunday: Closed</li>
                    </ul>
                </div>

                <div class="social-media">
                    <h3>Follow Us</h3>
                    <div class="social-links">
                        <a href="#" class="social-link">Facebook</a>
                        <a href="#" class="social-link">Twitter</a>
                        <a href="#" class="social-link">Instagram</a>
                    </div>
                </div>
            </section>
        </div>
    </main>

    <footer>
        <div class="footer-content">
            <div class="footer-section">
                <h3>About SneakerEthics</h3>
                <p>Making sustainable fashion accessible to everyone.</p>
            </div>
            <div class="footer-section">
                <h3>Quick Links</h3>
                <ul>
                    <li><a href="index.jsp">Home</a></li>
                    <li><a href="about.jsp">About</a></li>
                    <li><a href="contact.jsp">Contact</a></li>
                </ul>
            </div>
            <div class="footer-section">
                <h3>Connect With Us</h3>
                <div class="social-links">
                    <a href="#" class="social-link">Facebook</a>
                    <a href="#" class="social-link">Twitter</a>
                    <a href="#" class="social-link">Instagram</a>
                </div>
            </div>
        </div>
        <div class="footer-bottom">
            <p>&copy; 2024 SneakerEthics. All rights reserved.</p>
        </div>
    </footer>

    <script>
        document.getElementById('contact-form').addEventListener('submit', function(e) {
            e.preventDefault();
            
            const formData = new FormData(this);
            const data = Object.fromEntries(formData.entries());

            fetch('/SneakerEthics/api/contact', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(data)
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Failed to send message');
                }
                return response.json();
            })
            .then(result => {
                showAlert('Message sent successfully!', 'success');
                document.getElementById('contact-form').reset();
            })
            .catch(error => {
                console.error('Error:', error);
                showAlert('Failed to send message. Please try again.', 'error');
            });
        });

        function showAlert(message, type) {
            const alertDiv = document.createElement('div');
            alertDiv.className = `alert alert-${type}`;
            alertDiv.textContent = message;
            
            document.body.appendChild(alertDiv);
            
            setTimeout(() => {
                alertDiv.remove();
            }, 3000);
        }
    </script>
</body>
</html> 