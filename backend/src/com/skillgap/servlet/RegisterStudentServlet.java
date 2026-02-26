package com.skillgap.servlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.annotation.WebServlet;
import com.skillgap.model.Student;
import com.skillgap.util.InputValidator;
import com.skillgap.util.PasswordHash;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import com.skillgap.db.DBConnection;

@WebServlet("/RegisterStudentServlet")
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
        String targetJob = request.getParameter("targetJob");

        // Validate inputs
        if (!InputValidator.isValidName(firstName) || !InputValidator.isValidName(lastName)) {
            response.sendRedirect("studentForm.jsp?error=Invalid name");
            return;
        }

        if (!InputValidator.isValidEmail(email)) {
            response.sendRedirect("studentForm.jsp?error=Invalid email");
            return;
        }

        if (!InputValidator.isValidUsername(username)) {
            response.sendRedirect("studentForm.jsp?error=Invalid username");
            return;
        }

        if (!InputValidator.isValidPassword(password)) {
            response.sendRedirect("studentForm.jsp?error=Invalid password");
            return;
        }

        if (!InputValidator.isValidDepartment(department)) {
            response.sendRedirect("studentForm.jsp?error=Invalid department");
            return;
        }

        try {
            int semester = Integer.parseInt(semesterStr);
            double cgpa = Double.parseDouble(cgpaStr);

            if (!InputValidator.isValidSemester(semester)) {
                response.sendRedirect("studentForm.jsp?error=Invalid semester");
                return;
            }

            if (!InputValidator.isValidCGPA(cgpa)) {
                response.sendRedirect("studentForm.jsp?error=Invalid CGPA");
                return;
            }

            // validate target job
            if (targetJob == null || targetJob.trim().isEmpty()) {
                response.sendRedirect("studentForm.jsp?error=Target job required");
                return;
            }

            // Hash password
            String passwordHash = PasswordHash.hashPassword(password);

            // Store user and student data in database within transaction
            Connection con = null;
            try {
                con = com.skillgap.db.DBConnection.getConnection();
                con.setAutoCommit(false);

                String insertUserSql = "INSERT INTO users (user_id, username, password_hash, email) " +
                        "VALUES (seq_users.NEXTVAL, ?, ?, ?)";
                try (PreparedStatement psUser = con.prepareStatement(insertUserSql)) {
                    psUser.setString(1, username);
                    psUser.setString(2, passwordHash);
                    psUser.setString(3, email);
                    psUser.executeUpdate();
                }

                // retrieve generated user_id via sequence currval
                int generatedUserId;
                try (PreparedStatement psCurr = con.prepareStatement(
                        "SELECT seq_users.CURRVAL FROM dual")) {
                    try (ResultSet rs = psCurr.executeQuery()) {
                        if (rs.next()) {
                            generatedUserId = rs.getInt(1);
                        } else {
                            throw new SQLException("Failed to obtain user_id CURRVAL");
                        }
                    }
                }

                String insertStudentSql = "INSERT INTO students (student_id, user_id, first_name, last_name, department, semester, cgpa, target_job) "
                        +
                        "VALUES (seq_students.NEXTVAL, ?, ?, ?, ?, ?, ?, ?)";
                try (PreparedStatement psStu = con.prepareStatement(insertStudentSql)) {
                    psStu.setInt(1, generatedUserId);
                    psStu.setString(2, firstName);
                    psStu.setString(3, lastName);
                    psStu.setString(4, department);
                    psStu.setInt(5, semester);
                    psStu.setDouble(6, cgpa);
                    psStu.setString(7, targetJob);
                    psStu.executeUpdate();
                }

                con.commit();
                response.sendRedirect("login.jsp?success=Registration successful! Please login.");
                return;
            } catch (SQLException sqle) {
                sqle.printStackTrace();
                if (con != null) {
                    try {
                        con.rollback();
                    } catch (SQLException ex) {
                        ex.printStackTrace();
                    }
                }
                response.sendRedirect("studentForm.jsp?error=Database error occurred");
                return;
            } finally {
                if (con != null) {
                    try {
                        con.close();
                    } catch (SQLException ex) {
                        // ignore
                    }
                }
            }

        } catch (NumberFormatException e) {
            response.sendRedirect("studentForm.jsp?error=Invalid input format");
        }
    }
}
