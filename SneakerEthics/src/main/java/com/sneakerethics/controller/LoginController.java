package com.sneakerethics.controller;

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

/**
 * Login controller servlet to handle user authentication.
 */
@WebServlet("/login")
public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;
    
    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        if (username == null || password == null || username.trim().isEmpty() || password.trim().isEmpty()) {
            request.setAttribute("error", "Username and password are required");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }
        
        try {
            User user = userDAO.getUserByUsername(username);
            
            if (user != null && PasswordUtil.verifyPassword(password, user.getPassword())) {
                // Create session
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                session.setAttribute("userId", user.getId());
                
                // Redirect based on role
                if ("admin".equals(user.getRole())) {
                    response.sendRedirect(request.getContextPath() + "/admin/dashboard.jsp");
                } else {
                    response.sendRedirect(request.getContextPath() + "/user/dashboard.jsp");
                }
            } else {
                request.setAttribute("error", "Invalid username or password");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error occurred. Please try again later.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }
} 