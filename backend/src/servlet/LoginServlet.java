package com.skillgap.servlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.skillgap.util.InputValidator;
import com.skillgap.util.PasswordHash;
import java.io.IOException;

public class LoginServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        // Validate input
        if (!InputValidator.isValidUsername(username) || !InputValidator.isValidPassword(password)) {
            response.sendRedirect("login.html?error=Invalid credentials");
            return;
        }
        
        // TODO: Query database to verify credentials
        // String passwordHash = getUserPasswordHashFromDB(username);
        // if (PasswordHash.verifyPassword(password, passwordHash)) {
        
        // For demonstration: Simple validation
        if ("student1".equals(username) && "password123".equals(password)) {
            HttpSession session = request.getSession(true);
            session.setAttribute("username", username);
            session.setAttribute("userId", 1);
            response.sendRedirect("dashboard.jsp");
        } else {
            response.sendRedirect("login.html?error=Invalid username or password");
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("login.html");
    }
}
