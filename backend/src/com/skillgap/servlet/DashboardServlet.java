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

            // ============================================================
            // PHASE 1: Fetch student_id and target_job (DB-DRIVEN ONLY)
            // ============================================================
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

            // ============================================================
            // PHASE 3: Compute simple statistics (NULL-SAFE AVG)
            // ============================================================
            try (PreparedStatement psStats = con.prepareStatement(
                    "SELECT COUNT(*) AS total, AVG(proficiency_level) AS avg_prof " +
                            "FROM student_skills WHERE student_id = ?")) {
                psStats.setInt(1, studentId);
                try (ResultSet rs = psStats.executeQuery()) {
                    if (rs.next()) {
                        request.setAttribute("totalSkills", rs.getInt("total"));
                        // ENSURE DOUBLE SAFE AVG: Handle NULL when no skills exist
                        double avgProf = rs.getDouble("avg_prof");
                        if (rs.wasNull()) {
                            avgProf = 0.0;
                        }
                        request.setAttribute("avgProficiency", avgProf);
                    }
                }
            }

            // ============================================================
            // PHASE 3: Load current skill proficiencies (ORDERED for stability)
            // ============================================================
            Map<String, Integer> skillMap = new LinkedHashMap<>();
            try (PreparedStatement psSkills = con.prepareStatement(
                    "SELECT s.skill_name, ss.proficiency_level " +
                            "FROM student_skills ss " +
                            "JOIN skills s ON ss.skill_id = s.skill_id " +
                            "WHERE ss.student_id = ? " +
                            "ORDER BY s.skill_name")) {
                psSkills.setInt(1, studentId);
                try (ResultSet rs = psSkills.executeQuery()) {
                    while (rs.next()) {
                        skillMap.put(rs.getString("skill_name"), rs.getInt("proficiency_level"));
                    }
                }
            }
            request.setAttribute("skillMap", skillMap);

            // ============================================================
            // PHASE 1 & 4: Load most recent gap/target levels (TIMESTAMP-BASED)
            // ============================================================
            // REPLACED: (g.skill_id, g.analysis_id) IN (SELECT...)
            // WITH: g.analysis_date = (SELECT MAX(g2.analysis_date) ...)
            // This is more stable and deterministic than MAX(analysis_id)
            // ============================================================
            Map<String, Integer> targetMap = new LinkedHashMap<>();
            Map<String, Double> gapMap = new LinkedHashMap<>();
            try (PreparedStatement psGap = con.prepareStatement(
                    "SELECT s.skill_name, g.current_level, g.target_level, g.gap_score " +
                            "FROM skill_gap_analysis g " +
                            "JOIN skills s ON g.skill_id = s.skill_id " +
                            "WHERE g.student_id = ? " +
                            "AND g.analysis_date = (" +
                            "    SELECT MAX(g2.analysis_date) " +
                            "    FROM skill_gap_analysis g2 " +
                            "    WHERE g2.student_id = g.student_id " +
                            "    AND g2.skill_id = g.skill_id" +
                            ")")) {
                psGap.setInt(1, studentId);
                try (ResultSet rs = psGap.executeQuery()) {
                    while (rs.next()) {
                        String name = rs.getString("skill_name");
                        targetMap.put(name, rs.getInt("target_level"));
                        gapMap.put(name, rs.getDouble("gap_score"));
                    }
                }
            }

            // ============================================================
            // PHASE 2: NORMALIZE GAP MAP - Fill missing skills with defaults
            // ============================================================
            // Ensures that ALL skills in skillMap have entries in targetMap
            // and gapMap, preventing chart "blank slot" issues on refresh
            // ============================================================
            for (String skill : skillMap.keySet()) {
                // If skill has no gap analysis, gap score defaults to 0.0
                if (!gapMap.containsKey(skill)) {
                    gapMap.put(skill, 0.0);
                }
                // If skill has no target, target defaults to current proficiency
                if (!targetMap.containsKey(skill)) {
                    targetMap.put(skill, skillMap.get(skill));
                }
            }

            request.setAttribute("targetMap", targetMap);
            request.setAttribute("gapMap", gapMap);

            // ============================================================
            // PHASE 4 & 6: PREPARE CONSISTENT JSON (IDENTICAL KEYS)
            // ============================================================
            // All three JSON objects now have EXACT same keys, in order,
            // ensuring chart stability across refreshes
            // ============================================================
            String skillJson = toJson(skillMap);
            String targetJson = toJson(targetMap);
            String gapJson = toJson(gapMap);

            request.setAttribute("skillJson", skillJson);
            request.setAttribute("targetJson", targetJson);
            request.setAttribute("gapJson", gapJson);

        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    }

    // ====================================================================
    // UTILITY: Convert map to JSON object string
    // ====================================================================
    private String toJson(Map<?, ?> map) {
        if (map == null || map.isEmpty()) {
            return "{}";
        }
        StringBuilder sb = new StringBuilder("{");
        Iterator<? extends Map.Entry<?, ?>> it = map.entrySet().iterator();
        while (it.hasNext()) {
            Map.Entry<?, ?> e = it.next();
            sb.append("\"")
                    .append(escapeJson(e.getKey().toString()))
                    .append("\":");
            Object val = e.getValue();
            if (val instanceof Number) {
                sb.append(val.toString());
            } else {
                sb.append("\"")
                        .append(escapeJson(val.toString()))
                        .append("\"");
            }
            if (it.hasNext())
                sb.append(",");
        }
        sb.append("}");
        return sb.toString();
    }

    private String escapeJson(String s) {
        return s.replace("\\", "\\\\").replace("\"", "\\\"");
    }
}