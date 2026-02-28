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

            // Fetch student_id (we still need it for stats and later screens)
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

            // Compute simple statistics
            try (PreparedStatement psStats = con.prepareStatement(
                    "SELECT COUNT(*) AS total, AVG(proficiency_level) AS avg_prof " +
                            "FROM student_skills WHERE student_id = ?")) {
                psStats.setInt(1, studentId);
                try (ResultSet rs = psStats.executeQuery()) {
                    if (rs.next()) {
                        request.setAttribute("totalSkills", rs.getInt("total"));
                        request.setAttribute("avgProficiency", rs.getDouble("avg_prof"));
                    }
                }
            }

            // Load current skill proficiencies into a map for the charts
            Map<String, Integer> skillMap = new LinkedHashMap<>();
            try (PreparedStatement psSkills = con.prepareStatement(
                    "SELECT s.skill_name, ss.proficiency_level " +
                            "FROM student_skills ss " +
                            "JOIN skills s ON ss.skill_id = s.skill_id " +
                            "WHERE ss.student_id = ?")) {
                psSkills.setInt(1, studentId);
                try (ResultSet rs = psSkills.executeQuery()) {
                    while (rs.next()) {
                        skillMap.put(rs.getString("skill_name"), rs.getInt("proficiency_level"));
                    }
                }
            }
            request.setAttribute("skillMap", skillMap);

            // Load most recent gap/target levels per skill
            Map<String, Integer> targetMap = new LinkedHashMap<>();
            Map<String, Double> gapMap = new LinkedHashMap<>();
            try (PreparedStatement psGap = con.prepareStatement(
                    "SELECT s.skill_name, g.target_level, g.gap_score " +
                            "FROM skill_gap_analysis g " +
                            "JOIN skills s ON g.skill_id = s.skill_id " +
                            "WHERE g.student_id = ? " +
                            "AND (g.skill_id, g.analysis_id) IN (" +
                            "   SELECT skill_id, MAX(analysis_id) " +
                            "   FROM skill_gap_analysis " +
                            "   WHERE student_id = ? " +
                            "   GROUP BY skill_id)")) {
                psGap.setInt(1, studentId);
                psGap.setInt(2, studentId);
                try (ResultSet rs = psGap.executeQuery()) {
                    while (rs.next()) {
                        String name = rs.getString("skill_name");
                        targetMap.put(name, rs.getInt("target_level"));
                        gapMap.put(name, rs.getDouble("gap_score"));
                    }
                }
            }
            request.setAttribute("targetMap", targetMap);
            request.setAttribute("gapMap", gapMap);

            // prepare JSON strings for client-side use
            request.setAttribute("skillJson", toJson(skillMap));
            request.setAttribute("targetJson", toJson(targetMap));
            request.setAttribute("gapJson", toJson(gapMap));

        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    }

    // utility to convert a map to a JSON object string
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