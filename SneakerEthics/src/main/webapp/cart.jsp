<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SneakerEthics - Shopping Cart</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/cart.css">
</head>
<body>
    <header class="header">
        <div class="nav-container">
            <a href="index.jsp" class="logo">SneakerEthics</a>
            <nav>
                <a href="index.jsp">Home</a>
                <a href="cart.jsp" class="active">Cart</a>
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

    <main class="dashboard-container">
        <h1>Your Shopping Cart</h1>
        
        <div id="cart-items" class="cart-items">
            <!-- Cart items will be loaded dynamically -->
            <div class="loading">
                <div class="loading-spinner"></div>
            </div>
        </div>

        <div class="cart-summary">
            <h2>Order Summary</h2>
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
            <button id="checkout-btn" class="btn btn-primary">Proceed to Checkout</button>
        </div>
    </main>

    <script>
        // Store user login status in a variable
        const isLoggedIn = <c:out value="${sessionScope.user != null}"/>;

        // Load cart items
        function loadCart() {
            fetch('${pageContext.request.contextPath}/api/cart')
                .then(response => response.json())
                .then(cart => {
                    const cartItems = document.getElementById('cart-items');
                    cartItems.innerHTML = '';

                    if (cart.items && Object.keys(cart.items).length > 0) {
                        Object.values(cart.items).forEach(item => {
                            const sneaker = item.sneaker;
                            const cartItem = document.createElement('div');
                            cartItem.className = 'cart-item';
                            cartItem.innerHTML = `
                                <div class="cart-item-image">
                                    <img src="${sneaker.imageUrl}" alt="${sneaker.name}">
                                </div>
                                <div class="cart-item-details">
                                    <h3>${sneaker.name}</h3>
                                    <p class="ethical-badge">${sneaker.ethicalCertification}</p>
                                    <p class="price">$${sneaker.price}</p>
                                    <div class="quantity-controls">
                                        <button class="btn-quantity" onclick="updateQuantity(${sneaker.id}, ${item.quantity - 1})">-</button>
                                        <span class="quantity">${item.quantity}</span>
                                        <button class="btn-quantity" onclick="updateQuantity(${sneaker.id}, ${item.quantity + 1})">+</button>
                                    </div>
                                </div>
                                <div class="cart-item-actions">
                                    <button class="btn btn-secondary" onclick="removeItem(${sneaker.id})">Remove</button>
                                </div>
                            `;
                            cartItems.appendChild(cartItem);
                        });

                        document.getElementById('subtotal').textContent = `$${cart.total.toFixed(2)}`;
                        document.getElementById('total').textContent = `$${cart.total.toFixed(2)}`;
                    } else {
                        cartItems.innerHTML = '<p class="empty-cart">Your cart is empty</p>';
                        document.getElementById('checkout-btn').disabled = true;
                    }
                })
                .catch(error => {
                    console.error('Error loading cart:', error);
                    document.getElementById('cart-items').innerHTML = '<p class="error">Error loading cart. Please try again.</p>';
                });
        }

        // Update item quantity
        function updateQuantity(sneakerId, quantity) {
            if (quantity < 1) return;
            
            fetch(`${pageContext.request.contextPath}/api/cart?sneakerId=${sneakerId}&quantity=${quantity}`, {
                method: 'PUT'
            })
            .then(response => response.json())
            .then(cart => {
                loadCart();
            })
            .catch(error => {
                console.error('Error updating quantity:', error);
                showAlert('Error updating quantity. Please try again.', 'error');
            });
        }

        // Remove item from cart
        function removeItem(sneakerId) {
            fetch(`${pageContext.request.contextPath}/api/cart/${sneakerId}`, {
                method: 'DELETE'
            })
            .then(response => response.json())
            .then(cart => {
                loadCart();
                showAlert('Item removed from cart', 'success');
            })
            .catch(error => {
                console.error('Error removing item:', error);
                showAlert('Error removing item. Please try again.', 'error');
            });
        }

        // Show alert message
        function showAlert(message, type) {
            const alertDiv = document.createElement('div');
            alertDiv.className = `alert alert-${type}`;
            alertDiv.textContent = message;
            document.body.appendChild(alertDiv);
            setTimeout(() => alertDiv.remove(), 3000);
        }

        // Handle checkout
        document.getElementById('checkout-btn').addEventListener('click', function() {
            if (!isLoggedIn) {
                window.location.href = '${pageContext.request.contextPath}/login.jsp?redirect=checkout';
                return;
            }
            window.location.href = '${pageContext.request.contextPath}/checkout.jsp';
        });

        // Load cart when page loads
        document.addEventListener('DOMContentLoaded', loadCart);
    </script>
</body>
</html> 