package com.skillgap.servlet;

import com.skillgap.db.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/SkillsServlet")
public class SkillsServlet extends HttpServlet {

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
            // determine student id
            int studentId;
            try (PreparedStatement ps = con.prepareStatement(
                    "SELECT student_id FROM students WHERE user_id = ?")) {
                ps.setInt(1, userId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        studentId = rs.getInt("student_id");
                    } else {
                        throw new SQLException("Student not found");
                    }
                }
            }

            List<Map<String, Object>> skills = new ArrayList<>();
            String sql = "SELECT s.skill_id, ss.student_skill_id, s.skill_name, ss.proficiency_level " +
                    "FROM student_skills ss " +
                    "JOIN skills s ON ss.skill_id = s.skill_id " +
                    "WHERE ss.student_id = ?";
            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setInt(1, studentId);
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        Map<String, Object> row = new HashMap<>();
                        row.put("skillId", rs.getInt("skill_id"));
                        row.put("id", rs.getInt("student_skill_id"));
                        row.put("name", rs.getString("skill_name"));
                        row.put("level", rs.getInt("proficiency_level"));
                        skills.add(row);
                    }
                }
            }
            request.setAttribute("skills", skills);

        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.getRequestDispatcher("skills.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        int userId = (int) session.getAttribute("userId");

        String action = request.getParameter("action");
        String idStr = request.getParameter("id");
        if (action != null && idStr != null) {
            try {
                int skillRecId = Integer.parseInt(idStr);
                try (Connection con = DBConnection.getConnection()) {
                    if ("delete".equals(action)) {
                        try (PreparedStatement ps = con.prepareStatement(
                                "DELETE FROM student_skills WHERE student_skill_id = ?")) {
                            ps.setInt(1, skillRecId);
                            ps.executeUpdate();
                        }
                    }
                    // update action could be added later
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            } catch (NumberFormatException nfe) {
                // ignore
            }
        }
        response.sendRedirect("SkillsServlet");
    }
}
