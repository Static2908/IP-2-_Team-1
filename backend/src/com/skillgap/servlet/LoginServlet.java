package com.skillgap.servlet;

import com.skillgap.db.DBConnection;
import com.skillgap.util.PasswordHash;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username == null || password == null ||
            username.isEmpty() || password.isEmpty()) {

            request.setAttribute("error", "All fields are required.");
            request.getRequestDispatcher("login.jsp")
                   .forward(request, response);
            return;
        }

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(
                     "SELECT password FROM USERS WHERE username = ?")) {

            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String storedHash = rs.getString("password");

                // Compare hashed password
                if (PasswordHash.verifyPassword(password, storedHash)) {

                    HttpSession session = request.getSession();
                    session.setAttribute("username", username);

                    response.sendRedirect("dashboard.jsp");

                } else {
                    request.setAttribute("error",
                            "Invalid username or password.");
                    request.getRequestDispatcher("login.jsp")
                           .forward(request, response);
                }

            } else {
                request.setAttribute("error",
                        "Invalid username or password.");
                request.getRequestDispatcher("login.jsp")
                       .forward(request, response);
            }

        } catch (SQLException e) {
            throw new ServletException("Database Error", e);
        }
    }
}
