package com.skillgap.servlet;

import com.skillgap.db.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/DashboardServlet")
public class DashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = (int) session.getAttribute("userId");

        try (Connection con = DBConnection.getConnection()) {

            // Fetch student_id and target_job
            int studentId;
            String targetJob = null;
            try (PreparedStatement ps = con.prepareStatement(
                    "SELECT student_id, target_job FROM students WHERE user_id = ?")) {

                ps.setInt(1, userId);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    studentId = rs.getInt("student_id");
                    targetJob = rs.getString("target_job");
                } else {
                    throw new SQLException("Student not found");
                }
            }

            request.setAttribute("targetJob", targetJob);

            // Fetch skills
            List<Map<String, Object>> skills = new ArrayList<>();

            try (PreparedStatement ps = con.prepareStatement(
                    "SELECT s.skill_name, ss.proficiency_level " +
                            "FROM student_skills ss " +
                            "JOIN skills s ON ss.skill_id = s.skill_id " +
                            "WHERE ss.student_id = ?")) {

                ps.setInt(1, studentId);
                ResultSet rs = ps.executeQuery();

                while (rs.next()) {
                    Map<String, Object> skill = new HashMap<>();
                    skill.put("name", rs.getString("skill_name"));
                    skill.put("level", rs.getInt("proficiency_level"));
                    skills.add(skill);
                }
            }

            request.setAttribute("skills", skills);

        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    }
}