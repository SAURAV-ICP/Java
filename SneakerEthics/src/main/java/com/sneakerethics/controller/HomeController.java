package com.sneakerethics.controller;

import com.sneakerethics.dao.SneakerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("")
public class HomeController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private SneakerDAO sneakerDAO;

    @Override
    public void init() throws ServletException {
        sneakerDAO = new SneakerDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Load featured sneakers (for now, we'll just get all sneakers)
        request.setAttribute("featuredSneakers", sneakerDAO.getAllSneakers());
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }
} 