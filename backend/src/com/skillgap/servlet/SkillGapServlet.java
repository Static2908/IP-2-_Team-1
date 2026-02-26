package com.skillgap.servlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/SkillGapServlet")
public class SkillGapServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        int studentId;
        try (Connection con = com.skillgap.db.DBConnection.getConnection()) {
            try (PreparedStatement ps = con.prepareStatement(
                    "SELECT student_id FROM students WHERE user_id = ?")) {
                ps.setInt(1, userId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        studentId = rs.getInt("student_id");
                    } else {
                        throw new SQLException("Student record not found");
                    }
                }
            }

            // fetch all gap analyses for this student
            String fetchSql = "SELECT g.skill_id, s.skill_name, g.current_level, g.target_level, g.gap_score, g.analysis_date "
                    +
                    "FROM skill_gap_analysis g JOIN skills s ON g.skill_id = s.skill_id " +
                    "WHERE g.student_id = ? ORDER BY g.analysis_date DESC";
            try (PreparedStatement ps2 = con.prepareStatement(fetchSql)) {
                ps2.setInt(1, studentId);
                try (ResultSet rs2 = ps2.executeQuery()) {
                    java.util.List<java.util.Map<String, Object>> list = new java.util.ArrayList<>();
                    while (rs2.next()) {
                        java.util.Map<String, Object> map = new java.util.HashMap<>();
                        map.put("skillId", rs2.getInt("skill_id"));
                        map.put("skillName", rs2.getString("skill_name"));
                        map.put("currentLevel", rs2.getInt("current_level"));
                        map.put("targetLevel", rs2.getInt("target_level"));
                        map.put("gapScore", rs2.getDouble("gap_score"));
                        map.put("analysisDate", rs2.getTimestamp("analysis_date"));
                        list.add(map);
                    }
                    request.setAttribute("gapAnalysis", list);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("gapAnalysis", null);
        }
        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }
        int userId = (int) session.getAttribute("userId");

        String skillIdStr = request.getParameter("skillId");
        String targetLevelStr = request.getParameter("targetLevel");
        try {
            int skillId = Integer.parseInt(skillIdStr);
            int targetLevel = Integer.parseInt(targetLevelStr);

            // fetch student_id
            int studentId;
            try (Connection con = com.skillgap.db.DBConnection.getConnection()) {
                try (PreparedStatement psStu = con.prepareStatement(
                        "SELECT student_id FROM students WHERE user_id = ?")) {
                    psStu.setInt(1, userId);
                    try (ResultSet rs = psStu.executeQuery()) {
                        if (rs.next()) {
                            studentId = rs.getInt("student_id");
                        } else {
                            throw new SQLException("Student not found for user_id " + userId);
                        }
                    }
                }

                // get current level from student_skills
                int currentLevel = 0;
                try (PreparedStatement psCS = con.prepareStatement(
                        "SELECT proficiency_level FROM student_skills WHERE student_id = ? AND skill_id = ?")) {
                    psCS.setInt(1, studentId);
                    psCS.setInt(2, skillId);
                    try (ResultSet rs = psCS.executeQuery()) {
                        if (rs.next()) {
                            currentLevel = rs.getInt("proficiency_level");
                        }
                    }
                }

                double gapScore = targetLevel - currentLevel;
                String insertSql = "INSERT INTO skill_gap_analysis (analysis_id, student_id, skill_id, current_level, target_level, gap_score) "
                        +
                        "VALUES (seq_skill_gap_analysis.NEXTVAL, ?, ?, ?, ?, ?)";
                try (PreparedStatement psIns = con.prepareStatement(insertSql)) {
                    psIns.setInt(1, studentId);
                    psIns.setInt(2, skillId);
                    psIns.setInt(3, currentLevel);
                    psIns.setInt(4, targetLevel);
                    psIns.setDouble(5, gapScore);
                    psIns.executeUpdate();
                }

                // prepare simple result map
                java.util.Map<String, Object> res = new java.util.HashMap<>();
                res.put("skillId", skillId);
                res.put("currentLevel", currentLevel);
                res.put("targetLevel", targetLevel);
                res.put("gapScore", gapScore);
                request.setAttribute("gapAnalysis", res);

                request.getRequestDispatcher("dashboard.jsp").forward(request, response);
                return;
            }
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid input");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        }
    }
}
