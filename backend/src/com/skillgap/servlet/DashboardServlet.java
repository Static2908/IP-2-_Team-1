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
            // Build role-based expected levels for dashboard comparison
            // ============================================================
            // The dashboard should compare current skill levels against
            // target-role expectations, not against assessment results.
            // Assessment flow updates current proficiency separately.
            // ============================================================
            Map<String, Integer> targetMap = buildRoleExpectedLevels(targetJob, skillMap);
            Map<String, Double> gapMap = new LinkedHashMap<>();
            for (Map.Entry<String, Integer> entry : skillMap.entrySet()) {
                String skill = entry.getKey();
                int currentLevel = entry.getValue();
                int expectedLevel = targetMap.getOrDefault(skill, currentLevel);
                gapMap.put(skill, (double) (expectedLevel - currentLevel));
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

    private Map<String, Integer> buildRoleExpectedLevels(String targetJob, Map<String, Integer> skillMap) {
        Map<String, Integer> roleTargets = new LinkedHashMap<>();

        String role = targetJob == null ? "" : targetJob.toLowerCase(Locale.ROOT);

        if (role.contains("backend") || role.contains("server")) {
            roleTargets.put("Java", 4);
            roleTargets.put("Database Design", 4);
            roleTargets.put("Data Structures", 4);
            roleTargets.put("System Design", 3);
            roleTargets.put("Cloud Computing", 3);
            roleTargets.put("Python", 2);
            roleTargets.put("Web Development", 2);
            roleTargets.put("Machine Learning", 1);
        } else if (role.contains("full stack") || role.contains("fullstack")) {
            roleTargets.put("Java", 4);
            roleTargets.put("Web Development", 4);
            roleTargets.put("Database Design", 4);
            roleTargets.put("Data Structures", 4);
            roleTargets.put("System Design", 3);
            roleTargets.put("Cloud Computing", 3);
            roleTargets.put("Python", 2);
            roleTargets.put("Machine Learning", 1);
        } else if (role.contains("frontend") || role.contains("front end")) {
            roleTargets.put("Web Development", 5);
            roleTargets.put("Java", 2);
            roleTargets.put("Python", 1);
            roleTargets.put("Database Design", 2);
            roleTargets.put("Data Structures", 3);
            roleTargets.put("System Design", 2);
            roleTargets.put("Cloud Computing", 1);
            roleTargets.put("Machine Learning", 1);
        } else if (role.contains("machine learning") || role.contains("ml") || role.contains("ai")) {
            roleTargets.put("Machine Learning", 5);
            roleTargets.put("Python", 4);
            roleTargets.put("Data Structures", 4);
            roleTargets.put("Cloud Computing", 3);
            roleTargets.put("System Design", 3);
            roleTargets.put("Database Design", 2);
            roleTargets.put("Java", 2);
            roleTargets.put("Web Development", 1);
        } else if ((role.contains("data") && role.contains("scientist")) || role.contains("analyst")) {
            roleTargets.put("Python", 4);
            roleTargets.put("Machine Learning", 4);
            roleTargets.put("Data Structures", 4);
            roleTargets.put("Database Design", 3);
            roleTargets.put("Cloud Computing", 2);
            roleTargets.put("System Design", 2);
            roleTargets.put("Java", 1);
            roleTargets.put("Web Development", 1);
        } else if (role.contains("cloud") || role.contains("devops")) {
            roleTargets.put("Cloud Computing", 5);
            roleTargets.put("System Design", 4);
            roleTargets.put("Java", 3);
            roleTargets.put("Python", 3);
            roleTargets.put("Database Design", 3);
            roleTargets.put("Data Structures", 2);
            roleTargets.put("Web Development", 1);
            roleTargets.put("Machine Learning", 1);
        } else {
            roleTargets.put("Java", 3);
            roleTargets.put("Python", 3);
            roleTargets.put("Data Structures", 4);
            roleTargets.put("Database Design", 3);
            roleTargets.put("System Design", 3);
            roleTargets.put("Cloud Computing", 2);
            roleTargets.put("Web Development", 2);
            roleTargets.put("Machine Learning", 1);
        }

        Map<String, Integer> normalizedTargets = new LinkedHashMap<>();
        for (Map.Entry<String, Integer> entry : skillMap.entrySet()) {
            normalizedTargets.put(entry.getKey(), roleTargets.getOrDefault(entry.getKey(), entry.getValue()));
        }

        return normalizedTargets;
    }
}