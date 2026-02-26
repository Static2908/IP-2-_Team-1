package com.skillgap.servlet;

import com.skillgap.db.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/SkillGapServlet")
public class SkillGapServlet extends HttpServlet {

    // =======================
    // GET: Fetch existing gap analyses
    // =======================
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

            int studentId;

            // Fetch student_id
            try (PreparedStatement ps = con.prepareStatement(
                    "SELECT student_id FROM students WHERE user_id = ?")) {

                ps.setInt(1, userId);

                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        studentId = rs.getInt("student_id");
                    } else {
                        throw new SQLException("Student record not found.");
                    }
                }
            }

            // Fetch all gap records
            String fetchSql = "SELECT g.skill_id, s.skill_name, g.current_level, " +
                    "g.target_level, g.gap_score, g.analysis_date " +
                    "FROM skill_gap_analysis g " +
                    "JOIN skills s ON g.skill_id = s.skill_id " +
                    "WHERE g.student_id = ? " +
                    "ORDER BY g.analysis_date DESC";

            List<Map<String, Object>> gapList = new ArrayList<>();

            try (PreparedStatement ps2 = con.prepareStatement(fetchSql)) {
                ps2.setInt(1, studentId);

                try (ResultSet rs2 = ps2.executeQuery()) {
                    while (rs2.next()) {
                        Map<String, Object> map = new HashMap<>();
                        map.put("skillId", rs2.getInt("skill_id"));
                        map.put("skillName", rs2.getString("skill_name"));
                        map.put("currentLevel", rs2.getInt("current_level"));
                        map.put("targetLevel", rs2.getInt("target_level"));
                        map.put("gapScore", rs2.getDouble("gap_score"));
                        map.put("analysisDate", rs2.getTimestamp("analysis_date"));
                        gapList.add(map);
                    }
                }
            }

            request.setAttribute("gapAnalysis", gapList);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("gapAnalysis", new ArrayList<>());
        }

        request.getRequestDispatcher("dashboard.jsp")
                .forward(request, response);
    }

    // =======================
    // POST: Create new gap analysis
    // =======================
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

        String skillIdStr = request.getParameter("skillId");
        String targetLevelStr = request.getParameter("targetLevel");

        try {
            int skillId = Integer.parseInt(skillIdStr);
            int targetLevel = Integer.parseInt(targetLevelStr);

            // Validate target level
            if (targetLevel < 1 || targetLevel > 5) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST,
                        "Target level must be between 1 and 5");
                return;
            }

            try (Connection con = DBConnection.getConnection()) {

                con.setAutoCommit(false);

                int studentId;

                // Fetch student_id
                try (PreparedStatement psStu = con.prepareStatement(
                        "SELECT student_id FROM students WHERE user_id = ?")) {

                    psStu.setInt(1, userId);

                    try (ResultSet rs = psStu.executeQuery()) {
                        if (rs.next()) {
                            studentId = rs.getInt("student_id");
                        } else {
                            throw new SQLException("Student not found.");
                        }
                    }
                }

                // Get current proficiency level
                int currentLevel = 0;

                try (PreparedStatement psCS = con.prepareStatement(
                        "SELECT proficiency_level FROM student_skills " +
                                "WHERE student_id = ? AND skill_id = ?")) {

                    psCS.setInt(1, studentId);
                    psCS.setInt(2, skillId);

                    try (ResultSet rs = psCS.executeQuery()) {
                        if (rs.next()) {
                            currentLevel = rs.getInt("proficiency_level");
                        }
                    }
                }

                double gapScore = targetLevel - currentLevel;

                // Insert into skill_gap_analysis
                String insertSql = "INSERT INTO skill_gap_analysis " +
                        "(analysis_id, student_id, skill_id, current_level, target_level, gap_score) " +
                        "VALUES (seq_skill_gap_analysis.NEXTVAL, ?, ?, ?, ?, ?)";

                try (PreparedStatement psIns = con.prepareStatement(insertSql)) {
                    psIns.setInt(1, studentId);
                    psIns.setInt(2, skillId);
                    psIns.setInt(3, currentLevel);
                    psIns.setInt(4, targetLevel);
                    psIns.setDouble(5, gapScore);
                    psIns.executeUpdate();
                }

                con.commit();

            } catch (SQLException e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                        "Database error occurred.");
                return;
            }

            // After insertion, forward to GET to refresh list
            doGet(request, response);

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid input format.");
        }
    }
}