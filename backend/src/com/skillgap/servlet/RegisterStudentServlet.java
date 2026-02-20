package com.skillgap.servlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.skillgap.model.Student;
import com.skillgap.util.InputValidator;
import com.skillgap.util.PasswordHash;
import java.io.IOException;

public class RegisterStudentServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String department = request.getParameter("department");
        String semesterStr = request.getParameter("semester");
        String cgpaStr = request.getParameter("cgpa");
        
        // Validate inputs
        if (!InputValidator.isValidName(firstName) || !InputValidator.isValidName(lastName)) {
            response.sendRedirect("studentForm.html?error=Invalid name");
            return;
        }
        
        if (!InputValidator.isValidEmail(email)) {
            response.sendRedirect("studentForm.html?error=Invalid email");
            return;
        }
        
        if (!InputValidator.isValidUsername(username)) {
            response.sendRedirect("studentForm.html?error=Invalid username");
            return;
        }
        
        if (!InputValidator.isValidPassword(password)) {
            response.sendRedirect("studentForm.html?error=Invalid password");
            return;
        }
        
        if (!InputValidator.isValidDepartment(department)) {
            response.sendRedirect("studentForm.html?error=Invalid department");
            return;
        }
        
        try {
            int semester = Integer.parseInt(semesterStr);
            double cgpa = Double.parseDouble(cgpaStr);
            
            if (!InputValidator.isValidSemester(semester)) {
                response.sendRedirect("studentForm.html?error=Invalid semester");
                return;
            }
            
            if (!InputValidator.isValidCGPA(cgpa)) {
                response.sendRedirect("studentForm.html?error=Invalid CGPA");
                return;
            }
            
            // Hash password
            String passwordHash = PasswordHash.hashPassword(password);
            
            // TODO: Store user and student data in database
            // User user = new User(username, passwordHash, email);
            // Student student = new Student(user.getUserId(), firstName, lastName, department, semester, cgpa);
            
            response.sendRedirect("login.html?success=Registration successful! Please login.");
            
        } catch (NumberFormatException e) {
            response.sendRedirect("studentForm.html?error=Invalid input format");
        }
    }
}
