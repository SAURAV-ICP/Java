package com.sneakerethics.controller;

import com.google.gson.Gson;
import com.sneakerethics.dao.SneakerDAO;
import com.sneakerethics.model.Sneaker;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/api/sneakers/*")
public class SneakerController extends HttpServlet {
    private SneakerDAO sneakerDAO;
    private Gson gson;

    @Override
    public void init() throws ServletException {
        sneakerDAO = new SneakerDAO();
        gson = new Gson();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String pathInfo = request.getPathInfo();

        if (pathInfo == null || pathInfo.equals("/")) {
            // Get all sneakers
            List<Sneaker> sneakers = sneakerDAO.getAllSneakers();
            response.getWriter().write(gson.toJson(sneakers));
        } else {
            try {
                // Get sneaker by ID
                int sneakerId = Integer.parseInt(pathInfo.substring(1));
                Sneaker sneaker = sneakerDAO.getSneakerById(sneakerId);

                if (sneaker != null) {
                    response.getWriter().write(gson.toJson(sneaker));
                } else {
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    response.getWriter().write(gson.toJson(new ErrorResponse("Sneaker not found")));
                }
            } catch (NumberFormatException e) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write(gson.toJson(new ErrorResponse("Invalid sneaker ID")));
            }
        }
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
        Sneaker sneaker = gson.fromJson(data, Sneaker.class);

        sneakerDAO.addSneaker(sneaker);
        response.setStatus(HttpServletResponse.SC_CREATED);
        response.getWriter().write(gson.toJson(new Response("Sneaker added successfully")));
    }

    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String pathInfo = request.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/")) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write(gson.toJson(new ErrorResponse("Sneaker ID is required")));
            return;
        }

        try {
            int sneakerId = Integer.parseInt(pathInfo.substring(1));

            StringBuilder buffer = new StringBuilder();
            String line;
            try (var reader = request.getReader()) {
                while ((line = reader.readLine()) != null) {
                    buffer.append(line);
                }
            }

            String data = buffer.toString();
            Sneaker sneaker = gson.fromJson(data, Sneaker.class);
            sneaker.setId(sneakerId);

            if (sneakerDAO.updateSneaker(sneaker)) {
                response.getWriter().write(gson.toJson(new Response("Sneaker updated successfully")));
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write(gson.toJson(new ErrorResponse("Sneaker not found")));
            }
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write(gson.toJson(new ErrorResponse("Invalid sneaker ID")));
        }
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String pathInfo = request.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/")) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write(gson.toJson(new ErrorResponse("Sneaker ID is required")));
            return;
        }

        try {
            int sneakerId = Integer.parseInt(pathInfo.substring(1));
            if (sneakerDAO.deleteSneaker(sneakerId)) {
                response.getWriter().write(gson.toJson(new Response("Sneaker deleted successfully")));
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write(gson.toJson(new ErrorResponse("Sneaker not found")));
            }
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write(gson.toJson(new ErrorResponse("Invalid sneaker ID")));
        }
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