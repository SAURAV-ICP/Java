package com.sneakerethics.controller;

import com.google.gson.Gson;
import com.sneakerethics.dao.OrderDAO;
import com.sneakerethics.dao.CartDAO;
import com.sneakerethics.model.Order;
import com.sneakerethics.model.CartItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/api/orders/*")
public class OrderController extends HttpServlet {
    private OrderDAO orderDAO;
    private CartDAO cartDAO;
    private Gson gson;

    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAO();
        cartDAO = new CartDAO();
        gson = new Gson();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write(gson.toJson(new ErrorResponse("User not logged in")));
            return;
        }

        String pathInfo = request.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/")) {
            // Get all orders for the user
            List<Order> orders = orderDAO.getOrdersByUserId(userId);
            response.getWriter().write(gson.toJson(orders));
        } else {
            try {
                // Get specific order
                int orderId = Integer.parseInt(pathInfo.substring(1));
                Order order = orderDAO.getOrderById(orderId);

                if (order != null && order.getUserId() == userId) {
                    response.getWriter().write(gson.toJson(order));
                } else {
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    response.getWriter().write(gson.toJson(new ErrorResponse("Order not found")));
                }
            } catch (NumberFormatException e) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write(gson.toJson(new ErrorResponse("Invalid order ID")));
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write(gson.toJson(new ErrorResponse("User not logged in")));
            return;
        }

        // Get cart items for the user
        List<CartItem> cartItems = cartDAO.getCartItems(userId);
        if (cartItems.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write(gson.toJson(new ErrorResponse("Cart is empty")));
            return;
        }

        // Create order from cart items
        Order order = new Order();
        order.setUserId(userId);
        order.setStatus("PENDING");

        double totalPrice = 0;
        for (CartItem item : cartItems) {
            totalPrice += item.getPrice() * item.getQuantity();
        }
        order.setTotalPrice(totalPrice);

        // Add shipping information from request body
        StringBuilder buffer = new StringBuilder();
        String line;
        try (var reader = request.getReader()) {
            while ((line = reader.readLine()) != null) {
                buffer.append(line);
            }
        }

        String data = buffer.toString();
        ShippingInfo shippingInfo = gson.fromJson(data, ShippingInfo.class);
        order.setShippingAddress(shippingInfo.getAddress());
        order.setShippingCity(shippingInfo.getCity());
        order.setShippingState(shippingInfo.getState());
        order.setShippingZip(shippingInfo.getZip());

        // Save order
        int orderId = orderDAO.createOrder(order);
        if (orderId > 0) {
            // Clear cart after successful order
            cartDAO.clearCart(userId);
            
            order.setId(orderId);
            response.setStatus(HttpServletResponse.SC_CREATED);
            response.getWriter().write(gson.toJson(new Response("Order created successfully", order)));
        } else {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write(gson.toJson(new ErrorResponse("Failed to create order")));
        }
    }

    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write(gson.toJson(new ErrorResponse("User not logged in")));
            return;
        }

        String pathInfo = request.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/")) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write(gson.toJson(new ErrorResponse("Order ID is required")));
            return;
        }

        try {
            int orderId = Integer.parseInt(pathInfo.substring(1));
            Order existingOrder = orderDAO.getOrderById(orderId);

            if (existingOrder == null || existingOrder.getUserId() != userId) {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write(gson.toJson(new ErrorResponse("Order not found")));
                return;
            }

            StringBuilder buffer = new StringBuilder();
            String line;
            try (var reader = request.getReader()) {
                while ((line = reader.readLine()) != null) {
                    buffer.append(line);
                }
            }

            String data = buffer.toString();
            Order updatedOrder = gson.fromJson(data, Order.class);
            updatedOrder.setId(orderId);
            updatedOrder.setUserId(userId);

            if (orderDAO.updateOrder(updatedOrder)) {
                response.getWriter().write(gson.toJson(new Response("Order updated successfully")));
            } else {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write(gson.toJson(new ErrorResponse("Failed to update order")));
            }
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write(gson.toJson(new ErrorResponse("Invalid order ID")));
        }
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write(gson.toJson(new ErrorResponse("User not logged in")));
            return;
        }

        String pathInfo = request.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/")) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write(gson.toJson(new ErrorResponse("Order ID is required")));
            return;
        }

        try {
            int orderId = Integer.parseInt(pathInfo.substring(1));
            Order order = orderDAO.getOrderById(orderId);

            if (order == null || order.getUserId() != userId) {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write(gson.toJson(new ErrorResponse("Order not found")));
                return;
            }

            if (orderDAO.deleteOrder(orderId)) {
                response.getWriter().write(gson.toJson(new Response("Order cancelled successfully")));
            } else {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write(gson.toJson(new ErrorResponse("Failed to cancel order")));
            }
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write(gson.toJson(new ErrorResponse("Invalid order ID")));
        }
    }

    private static class Response {
        private final String message;
        private final Order order;

        public Response(String message) {
            this.message = message;
            this.order = null;
        }

        public Response(String message, Order order) {
            this.message = message;
            this.order = order;
        }
    }

    private static class ErrorResponse {
        private final String error;

        public ErrorResponse(String error) {
            this.error = error;
        }
    }

    private static class ShippingInfo {
        private String address;
        private String city;
        private String state;
        private String zip;

        public String getAddress() { return address; }
        public String getCity() { return city; }
        public String getState() { return state; }
        public String getZip() { return zip; }
    }
} 