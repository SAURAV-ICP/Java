package com.sneakerethics.controller;

import com.sneakerethics.dao.UserDAO;
import com.sneakerethics.model.User;
import com.sneakerethics.util.PasswordUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * Registration controller servlet to handle user registration.
 */
@WebServlet("/register")
public class RegisterController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;
    
    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        
        // Validate input
        if (username == null || username.isEmpty() ||
            email == null || email.isEmpty() ||
            password == null || password.isEmpty() ||
            name == null || name.isEmpty()) {
            request.setAttribute("error", "All fields are required");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }
        
        // Check if username or email already exists
        if (userDAO.getUserByUsername(username) != null) {
            request.setAttribute("error", "Username already exists");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }
        
        if (userDAO.getUserByEmail(email) != null) {
            request.setAttribute("error", "Email already exists");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }
        
        // Create new user
        User newUser = new User();
        newUser.setUsername(username);
        newUser.setEmail(email);
        newUser.setPassword(PasswordUtil.hashPassword(password)); // Hash the password
        newUser.setName(name);
        newUser.setPhone(phone);
        
        if (userDAO.createUser(newUser)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
        } else {
            request.setAttribute("error", "Registration failed. Please try again.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }
} 