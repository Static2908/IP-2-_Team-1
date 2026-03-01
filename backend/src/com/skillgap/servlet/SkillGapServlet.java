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

            // Fetch student_id and target job
            int studentId;
            String targetJob = null;
            try (PreparedStatement ps = con.prepareStatement(
                    "SELECT student_id, target_job FROM students WHERE user_id = ?")) {
                ps.setInt(1, userId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        studentId = rs.getInt("student_id");
                        targetJob = rs.getString("target_job");
                    } else {
                        throw new SQLException("Student record not found.");
                    }
                }
            }
            request.setAttribute("targetJob", targetJob);

            // PHASE 3: Fetch full gap history from database only (DB-DRIVEN)
            List<Map<String, Object>> gapHistory = new ArrayList<>();
            String gapSql = "SELECT s.skill_name, g.current_level, g.target_level, " +
                    "g.gap_score, g.analysis_date " +
                    "FROM skill_gap_analysis g " +
                    "JOIN skills s ON g.skill_id = s.skill_id " +
                    "WHERE g.student_id = ? " +
                    "ORDER BY g.analysis_date DESC";

            try (PreparedStatement psGap = con.prepareStatement(gapSql)) {
                psGap.setInt(1, studentId);
                try (ResultSet rs = psGap.executeQuery()) {
                    while (rs.next()) {
                        Map<String, Object> row = new HashMap<>();
                        row.put("skillName", rs.getString("skill_name"));
                        row.put("currentLevel", rs.getInt("current_level"));
                        row.put("targetLevel", rs.getInt("target_level"));
                        row.put("gapScore", rs.getDouble("gap_score"));
                        row.put("analysisDate", rs.getTimestamp("analysis_date"));
                        gapHistory.add(row);
                    }
                }
            }
            request.setAttribute("gapHistory", gapHistory);

            // PHASE 6: Generate recommendations only from latest record per skill
            Map<String, Map<String, Object>> latestGapPerSkill = new LinkedHashMap<>();
            for (Map<String, Object> row : gapHistory) {
                String skillName = (String) row.get("skillName");
                if (!latestGapPerSkill.containsKey(skillName)) {
                    latestGapPerSkill.put(skillName, row);
                }
            }

            LinkedHashSet<String> jobRecSet = new LinkedHashSet<>();
            LinkedHashSet<String> skillRecSet = new LinkedHashSet<>();

            for (Map<String, Object> row : latestGapPerSkill.values()) {
                String skillName = (String) row.get("skillName");
                int currentLvl = (int) row.get("currentLevel");
                int targetLvl = (int) row.get("targetLevel");
                double gapScore = (double) row.get("gapScore");

                Map<String, List<String>> recBundle = com.skillgap.service.RecommendationEngine
                        .generateRecommendations(skillName, currentLvl, targetLvl, gapScore, targetJob);
                List<String> jobRecs = recBundle.get("jobRecommendations");
                List<String> skillRecs = recBundle.get("skillRecommendations");
                if (jobRecs != null)
                    jobRecSet.addAll(jobRecs);
                if (skillRecs != null)
                    skillRecSet.addAll(skillRecs);
            }

            request.setAttribute("jobRecommendations", new ArrayList<>(jobRecSet));
            request.setAttribute("skillRecommendations", new ArrayList<>(skillRecSet));

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("gapHistory", new ArrayList<>());
            request.setAttribute("jobRecommendations", new ArrayList<>());
            request.setAttribute("skillRecommendations", new ArrayList<>());
        }

        request.getRequestDispatcher("skillgap.jsp").forward(request, response);
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
                        "(analysis_id, student_id, skill_id, current_level, target_level, gap_score, analysis_date) " +
                        "VALUES (seq_skill_gap_analysis.NEXTVAL, ?, ?, ?, ?, ?, SYSTIMESTAMP)";

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