<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SneakerEthics - Checkout</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/checkout.css">
</head>
<body>
    <header class="header">
        <div class="nav-container">
            <a href="index.jsp" class="logo">SneakerEthics</a>
            <nav>
                <a href="index.jsp">Home</a>
                <a href="cart.jsp">Cart</a>
                <c:if test="${sessionScope.user != null}">
                    <a href="user/dashboard.jsp">Dashboard</a>
                    <a href="logout">Logout</a>
                </c:if>
                <c:if test="${sessionScope.user == null}">
                    <a href="login.jsp">Login</a>
                    <a href="register.jsp">Register</a>
                </c:if>
            </nav>
        </div>
    </header>

    <main class="checkout-container">
        <h1>Checkout</h1>
        
        <div class="checkout-grid">
            <div class="checkout-form">
                <h2>Shipping Information</h2>
                <form id="shipping-form">
                    <div class="form-group">
                        <label for="fullName">Full Name</label>
                        <input type="text" id="fullName" name="fullName" required>
                    </div>
                    <div class="form-group">
                        <label for="email">Email</label>
                        <input type="email" id="email" name="email" required>
                    </div>
                    <div class="form-group">
                        <label for="address">Address</label>
                        <input type="text" id="address" name="address" required>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label for="city">City</label>
                            <input type="text" id="city" name="city" required>
                        </div>
                        <div class="form-group">
                            <label for="postalCode">Postal Code</label>
                            <input type="text" id="postalCode" name="postalCode" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="country">Country</label>
                        <input type="text" id="country" name="country" required>
                    </div>
                </form>

                <h2>Payment Information</h2>
                <form id="payment-form">
                    <div class="form-group">
                        <label for="cardNumber">Card Number</label>
                        <input type="text" id="cardNumber" name="cardNumber" required>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label for="expiryDate">Expiry Date</label>
                            <input type="text" id="expiryDate" name="expiryDate" placeholder="MM/YY" required>
                        </div>
                        <div class="form-group">
                            <label for="cvv">CVV</label>
                            <input type="text" id="cvv" name="cvv" required>
                        </div>
                    </div>
                </form>
            </div>

            <div class="order-summary">
                <h2>Order Summary</h2>
                <div id="order-items">
                    <!-- Order items will be loaded dynamically -->
                    <div class="loading">
                        <div class="loading-spinner"></div>
                    </div>
                </div>
                <div class="summary-details">
                    <div class="summary-row">
                        <span>Subtotal</span>
                        <span id="subtotal">$0.00</span>
                    </div>
                    <div class="summary-row">
                        <span>Shipping</span>
                        <span>Free</span>
                    </div>
                    <div class="summary-row total">
                        <span>Total</span>
                        <span id="total">$0.00</span>
                    </div>
                </div>
                <button id="place-order-btn" class="btn btn-primary">Place Order</button>
            </div>
        </div>
    </main>

    <script>
        // Load cart items
        function loadCart() {
            fetch('/api/cart')
                .then(response => response.json())
                .then(cart => {
                    const orderItems = document.getElementById('order-items');
                    orderItems.innerHTML = '';

                    if (cart.items && Object.keys(cart.items).length > 0) {
                        Object.values(cart.items).forEach(item => {
                            const sneaker = item.sneaker;
                            const orderItem = document.createElement('div');
                            orderItem.className = 'order-item';
                            orderItem.innerHTML = `
                                <div class="order-item-image">
                                    <img src="${sneaker.imageUrl}" alt="${sneaker.name}">
                                </div>
                                <div class="order-item-details">
                                    <h3>${sneaker.name}</h3>
                                    <p class="quantity">Quantity: ${item.quantity}</p>
                                    <p class="price">$${(sneaker.price * item.quantity).toFixed(2)}</p>
                                </div>
                            `;
                            orderItems.appendChild(orderItem);
                        });

                        document.getElementById('subtotal').textContent = `$${cart.total.toFixed(2)}`;
                        document.getElementById('total').textContent = `$${cart.total.toFixed(2)}`;
                    } else {
                        orderItems.innerHTML = '<p class="empty-cart">Your cart is empty</p>';
                        document.getElementById('place-order-btn').disabled = true;
                    }
                })
                .catch(error => {
                    console.error('Error loading cart:', error);
                    document.getElementById('order-items').innerHTML = '<p class="error">Error loading cart. Please try again.</p>';
                });
        }

        // Handle form submission
        document.getElementById('place-order-btn').addEventListener('click', function() {
            const shippingForm = document.getElementById('shipping-form');
            const paymentForm = document.getElementById('payment-form');
            
            if (!shippingForm.checkValidity() || !paymentForm.checkValidity()) {
                showAlert('Please fill in all required fields', 'error');
                return;
            }

            const orderData = {
                shipping: {
                    fullName: document.getElementById('fullName').value,
                    email: document.getElementById('email').value,
                    address: document.getElementById('address').value,
                    city: document.getElementById('city').value,
                    postalCode: document.getElementById('postalCode').value,
                    country: document.getElementById('country').value
                },
                payment: {
                    cardNumber: document.getElementById('cardNumber').value,
                    expiryDate: document.getElementById('expiryDate').value,
                    cvv: document.getElementById('cvv').value
                }
            };

            fetch('/api/orders', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(orderData)
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    showAlert('Order placed successfully!', 'success');
                    setTimeout(() => {
                        window.location.href = 'user/dashboard.jsp';
                    }, 2000);
                } else {
                    showAlert('Error placing order. Please try again.', 'error');
                }
            })
            .catch(error => {
                console.error('Error placing order:', error);
                showAlert('Error placing order. Please try again.', 'error');
            });
        });

        // Show alert message
        function showAlert(message, type) {
            const alertDiv = document.createElement('div');
            alertDiv.className = `alert alert-${type}`;
            alertDiv.textContent = message;
            document.body.appendChild(alertDiv);
            setTimeout(() => alertDiv.remove(), 3000);
        }

        // Load cart when page loads
        document.addEventListener('DOMContentLoaded', loadCart);
    </script>
</body>
</html> 