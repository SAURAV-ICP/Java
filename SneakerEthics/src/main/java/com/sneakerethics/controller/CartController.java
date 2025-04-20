package com.sneakerethics.controller;

import com.google.gson.Gson;
import com.sneakerethics.dao.CartDAO;
import com.sneakerethics.model.Cart;
import com.sneakerethics.model.CartItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/api/cart/*")
public class CartController extends HttpServlet {
    private CartDAO cartDAO;
    private Gson gson;

    @Override
    public void init() throws ServletException {
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

        List<CartItem> cartItems = cartDAO.getCartItems(userId);
        response.getWriter().write(gson.toJson(cartItems));
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        StringBuilder buffer = new StringBuilder();
        String line;
        try (var reader = request.getReader()) {
            while ((line = reader.readLine()) != null) {
                buffer.append(line);
            }
        }

        String data = buffer.toString();
        CartItem cartItem = gson.fromJson(data, CartItem.class);

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write(gson.toJson(new ErrorResponse("User not logged in")));
            return;
        }

        cartItem.setUserId(userId);
        cartDAO.addToCart(cartItem);

        response.setStatus(HttpServletResponse.SC_CREATED);
        response.getWriter().write(gson.toJson(new Response("Item added to cart successfully")));
    }

    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        StringBuilder buffer = new StringBuilder();
        String line;
        try (var reader = request.getReader()) {
            while ((line = reader.readLine()) != null) {
                buffer.append(line);
            }
        }

        String data = buffer.toString();
        CartItem cartItem = gson.fromJson(data, CartItem.class);

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write(gson.toJson(new ErrorResponse("User not logged in")));
            return;
        }

        cartItem.setUserId(userId);
        cartDAO.updateCartItem(cartItem);

        response.getWriter().write(gson.toJson(new Response("Cart item updated successfully")));
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String pathInfo = request.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/")) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write(gson.toJson(new ErrorResponse("Cart item ID is required")));
            return;
        }

        int cartItemId;
        try {
            cartItemId = Integer.parseInt(pathInfo.substring(1));
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write(gson.toJson(new ErrorResponse("Invalid cart item ID")));
            return;
        }

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write(gson.toJson(new ErrorResponse("User not logged in")));
            return;
        }

        cartDAO.removeFromCart(cartItemId, userId);
        response.getWriter().write(gson.toJson(new Response("Item removed from cart successfully")));
    }

    private static class Response {
        private final String message;

        public Response(String message) {
            this.message = message;
        }
    }

    private static class ErrorResponse {
        private final String error;

        public ErrorResponse(String error) {
            this.error = error;
        }
    }
} 