package com.sneakerethics.controller;

import com.sneakerethics.dao.UserDAO;
import com.sneakerethics.dao.SneakerDAO;
import com.sneakerethics.model.User;
import com.sneakerethics.util.PasswordUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/user/*")
public class UserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;
    private SneakerDAO sneakerDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
        sneakerDAO = new SneakerDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String path = request.getPathInfo();
        
        // Debug information
        System.out.println("Path Info: " + path);
        System.out.println("Context Path: " + request.getContextPath());
        System.out.println("Servlet Path: " + request.getServletPath());
        
        // Check if user is logged in
        if (session == null || session.getAttribute("user") == null) {
            System.out.println("User not logged in, redirecting to login");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        if (path == null || path.equals("/")) {
            path = "/dashboard";
        }
        
        String forwardPath = null;
        
        switch (path) {
            case "/dashboard":
            case "/dashboard.jsp":
                // Load sneakers data
                request.setAttribute("sneakers", sneakerDAO.getAllSneakers());
                forwardPath = "/dashboard.jsp";
                break;
            case "/profile":
            case "/profile.jsp":
                // Load user data for profile page
                User user = (User) session.getAttribute("user");
                request.setAttribute("user", user);
                forwardPath = "/profile.jsp";
                break;
            case "/orders":
            case "/orders.jsp":
                forwardPath = "/orders.jsp";
                break;
            case "/wishlist":
            case "/wishlist.jsp":
                forwardPath = "/wishlist.jsp";
                break;
            case "/settings":
            case "/settings.jsp":
                forwardPath = "/settings.jsp";
                break;
            default:
                if (path.startsWith("/orders/")) {
                    forwardPath = "/order-details.jsp";
                } else {
                    System.out.println("No matching path found, sending 404");
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
                    return;
                }
        }
        
        if (forwardPath != null) {
            System.out.println("Forwarding to: " + forwardPath);
            request.getRequestDispatcher(forwardPath).forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String path = request.getPathInfo();
        
        if (path == null || path.equals("/")) {
            path = "/dashboard";
        }
        
        switch (path) {
            case "/update-profile":
                updateProfile(request, response);
                break;
            case "/change-password":
                changePassword(request, response);
                break;
            default:
                doGet(request, response);
        }
    }
    
    private void updateProfile(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User currentUser = (User) session.getAttribute("user");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        
        // Update user profile
        currentUser.setName(name);
        currentUser.setEmail(email);
        currentUser.setPhone(phone);
        
        if (userDAO.updateUser(currentUser)) {
            request.setAttribute("successMessage", "Profile updated successfully!");
        } else {
            request.setAttribute("errorMessage", "Failed to update profile. Please try again.");
        }
        
        request.getRequestDispatcher("/user/profile.jsp").forward(request, response);
    }
    
    private void changePassword(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User currentUser = (User) session.getAttribute("user");
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        try {
            // Verify current password
            if (!PasswordUtil.verifyPassword(currentPassword, currentUser.getPassword())) {
                request.setAttribute("errorMessage", "Current password is incorrect.");
                request.getRequestDispatcher("/user/profile.jsp").forward(request, response);
                return;
            }

            // Verify new passwords match
            if (!newPassword.equals(confirmPassword)) {
                request.setAttribute("errorMessage", "New passwords do not match.");
                request.getRequestDispatcher("/user/profile.jsp").forward(request, response);
                return;
            }

            // Hash new password
            String hashedPassword = PasswordUtil.hashPassword(newPassword);
            currentUser.setPassword(hashedPassword);

            // Update in database
            boolean success = userDAO.updateUserPassword(currentUser.getId(), hashedPassword);
            
            if (success) {
                request.setAttribute("successMessage", "Password changed successfully!");
            } else {
                request.setAttribute("errorMessage", "Failed to change password. Please try again.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred. Please try again.");
        }
        
        request.getRequestDispatcher("/user/profile.jsp").forward(request, response);
    }
} 