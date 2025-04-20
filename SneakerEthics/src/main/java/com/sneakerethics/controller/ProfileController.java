package com.sneakerethics.controller;

import com.google.gson.Gson;
import com.sneakerethics.dao.UserDAO;
import com.sneakerethics.model.User;
import com.sneakerethics.util.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/api/profile/*")
public class ProfileController extends HttpServlet {
    private UserDAO userDAO;
    private Gson gson;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
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

        User user = userDAO.getUserById(userId);
        if (user != null) {
            // Remove sensitive information before sending
            user.setPassword(null);
            response.getWriter().write(gson.toJson(user));
        } else {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            response.getWriter().write(gson.toJson(new ErrorResponse("User not found")));
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

        StringBuilder buffer = new StringBuilder();
        String line;
        try (var reader = request.getReader()) {
            while ((line = reader.readLine()) != null) {
                buffer.append(line);
            }
        }

        String data = buffer.toString();
        ProfileUpdateRequest updateRequest = gson.fromJson(data, ProfileUpdateRequest.class);

        User existingUser = userDAO.getUserById(userId);
        if (existingUser == null) {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            response.getWriter().write(gson.toJson(new ErrorResponse("User not found")));
            return;
        }

        // Verify current password
        if (!PasswordUtil.verifyPassword(updateRequest.getCurrentPassword(), existingUser.getPassword())) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write(gson.toJson(new ErrorResponse("Current password is incorrect")));
            return;
        }

        // Update user information
        existingUser.setName(updateRequest.getName());
        existingUser.setEmail(updateRequest.getEmail());
        existingUser.setPhone(updateRequest.getPhone());
        if (updateRequest.getNewPassword() != null && !updateRequest.getNewPassword().isEmpty()) {
            existingUser.setPassword(PasswordUtil.hashPassword(updateRequest.getNewPassword()));
        }

        if (userDAO.updateUser(existingUser)) {
            // Remove sensitive information before sending
            existingUser.setPassword(null);
            response.getWriter().write(gson.toJson(existingUser));
        } else {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write(gson.toJson(new ErrorResponse("Failed to update profile")));
        }
    }

    private static class Response {
        private final String message;
        private final User user;

        public Response(String message, User user) {
            this.message = message;
            this.user = user;
        }
    }

    private static class ErrorResponse {
        private final String error;

        public ErrorResponse(String error) {
            this.error = error;
        }
    }

    private static class ProfileUpdateRequest {
        private String name;
        private String email;
        private String phone;
        private String currentPassword;
        private String newPassword;

        public String getName() { return name; }
        public String getEmail() { return email; }
        public String getPhone() { return phone; }
        public String getCurrentPassword() { return currentPassword; }
        public String getNewPassword() { return newPassword; }
    }
} 