package com.sneakerethics.filter;

import com.sneakerethics.model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Authentication filter to protect routes and handle session management.
 */
@WebFilter("/*")
public class AuthFilter implements Filter {
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization code if needed
    }
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);
        
        String path = httpRequest.getRequestURI().substring(httpRequest.getContextPath().length());
        
        // Allow access to login, register, and static resources
        if (path.startsWith("/assets/") || path.equals("/login") || path.equals("/register") 
            || path.equals("/login.jsp") || path.equals("/register.jsp") || path.equals("/error.jsp")) {
            chain.doFilter(request, response);
            return;
        }
        
        // Check if user is authenticated
        if (session == null || session.getAttribute("user") == null) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login.jsp");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        
        // Check admin routes
        if (path.startsWith("/admin/") && !"admin".equals(user.getRole())) {
            httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
            return;
        }
        
        chain.doFilter(request, response);
    }
    
    @Override
    public void destroy() {
        // Cleanup code if needed
    }
} 