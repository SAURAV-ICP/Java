<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Orders - SneakerEthics</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/orders.css">
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
                <li><a href="orders.jsp" class="active">Orders</a></li>
                <li><a href="profile.jsp">Profile</a></li>
                <li><a href="logout">Logout</a></li>
            </ul>
        </nav>
    </header>

    <main class="orders-container">
        <h1>My Orders</h1>
        
        <div id="orders-list">
            <div class="loading">
                <div class="loading-spinner"></div>
            </div>
        </div>
    </main>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            loadOrders();
        });

        function loadOrders() {
            fetch('/SneakerEthics/api/orders')
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Failed to load orders');
                    }
                    return response.json();
                })
                .then(orders => {
                    const ordersList = document.getElementById('orders-list');
                    ordersList.innerHTML = '';

                    if (orders.length === 0) {
                        ordersList.innerHTML = '<p class="no-orders">You have no orders yet.</p>';
                        return;
                    }

                    orders.forEach(order => {
                        const orderElement = createOrderElement(order);
                        ordersList.appendChild(orderElement);
                    });
                })
                .catch(error => {
                    console.error('Error:', error);
                    showAlert('Failed to load orders', 'error');
                });
        }

        function createOrderElement(order) {
            const orderDiv = document.createElement('div');
            orderDiv.className = 'order-card';
            
            const orderHeader = document.createElement('div');
            orderHeader.className = 'order-header';
            
            const orderInfo = document.createElement('div');
            orderInfo.className = 'order-info';
            
            const orderId = document.createElement('span');
            orderId.className = 'order-id';
            orderId.textContent = `Order #${order.id}`;
            
            const orderDate = document.createElement('span');
            orderDate.className = 'order-date';
            orderDate.textContent = new Date(order.orderDate).toLocaleDateString();
            
            const orderStatus = document.createElement('span');
            orderStatus.className = `order-status ${order.status.toLowerCase()}`;
            orderStatus.textContent = order.status;
            
            orderInfo.appendChild(orderId);
            orderInfo.appendChild(orderDate);
            orderInfo.appendChild(orderStatus);
            
            const orderTotal = document.createElement('div');
            orderTotal.className = 'order-total';
            orderTotal.textContent = `$${order.totalAmount.toFixed(2)}`;
            
            orderHeader.appendChild(orderInfo);
            orderHeader.appendChild(orderTotal);
            
            const orderItems = document.createElement('div');
            orderItems.className = 'order-items';
            
            order.items.forEach(item => {
                const itemDiv = document.createElement('div');
                itemDiv.className = 'order-item';
                
                const itemImage = document.createElement('div');
                itemImage.className = 'item-image';
                itemImage.innerHTML = `<img src="${item.sneaker.imageUrl}" alt="${item.sneaker.name}">`;
                
                const itemDetails = document.createElement('div');
                itemDetails.className = 'item-details';
                
                const itemName = document.createElement('h3');
                itemName.textContent = item.sneaker.name;
                
                const itemQuantity = document.createElement('span');
                itemQuantity.className = 'item-quantity';
                itemQuantity.textContent = `Quantity: ${item.quantity}`;
                
                const itemPrice = document.createElement('span');
                itemPrice.className = 'item-price';
                itemPrice.textContent = `$${item.price.toFixed(2)}`;
                
                itemDetails.appendChild(itemName);
                itemDetails.appendChild(itemQuantity);
                itemDetails.appendChild(itemPrice);
                
                itemDiv.appendChild(itemImage);
                itemDiv.appendChild(itemDetails);
                orderItems.appendChild(itemDiv);
            });
            
            const orderFooter = document.createElement('div');
            orderFooter.className = 'order-footer';
            
            const shippingInfo = document.createElement('div');
            shippingInfo.className = 'shipping-info';
            
            const shippingAddress = document.createElement('p');
            shippingAddress.textContent = `Shipping Address: ${order.shippingAddress}`;
            
            const paymentMethod = document.createElement('p');
            paymentMethod.textContent = `Payment Method: ${order.paymentMethod}`;
            
            shippingInfo.appendChild(shippingAddress);
            shippingInfo.appendChild(paymentMethod);
            
            orderFooter.appendChild(shippingInfo);
            
            orderDiv.appendChild(orderHeader);
            orderDiv.appendChild(orderItems);
            orderDiv.appendChild(orderFooter);
            
            return orderDiv;
        }

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