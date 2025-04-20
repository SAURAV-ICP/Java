package com.sneakerethics.controller;

import com.google.gson.Gson;
import com.sneakerethics.model.ContactMessage;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedReader;
import java.io.IOException;
import java.time.LocalDateTime;

@WebServlet("/api/contact")
public class ContactController extends HttpServlet {
    private Gson gson;

    @Override
    public void init() throws ServletException {
        gson = new Gson();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            // Read the request body
            StringBuilder jsonBuilder = new StringBuilder();
            String line;
            try (BufferedReader reader = request.getReader()) {
                while ((line = reader.readLine()) != null) {
                    jsonBuilder.append(line);
                }
            }

            // Parse the JSON data
            ContactMessage contactMessage = gson.fromJson(jsonBuilder.toString(), ContactMessage.class);
            contactMessage.setTimestamp(LocalDateTime.now());

            // TODO: Implement email sending logic here
            // For now, we'll just simulate a successful submission
            boolean success = true;

            if (success) {
                response.setStatus(HttpServletResponse.SC_OK);
                response.getWriter().write(gson.toJson(new Response("Message sent successfully!")));
            } else {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write(gson.toJson(new ErrorResponse("Failed to send message. Please try again later.")));
            }
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write(gson.toJson(new ErrorResponse("Invalid request data")));
        }
    }

    private static class Response {
        private String message;

        public Response(String message) {
            this.message = message;
        }

        public String getMessage() {
            return message;
        }
    }

    private static class ErrorResponse {
        private String error;

        public ErrorResponse(String error) {
            this.error = error;
        }

        public String getError() {
            return error;
        }
    }
} 