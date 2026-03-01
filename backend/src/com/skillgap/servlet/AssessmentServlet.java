package com.skillgap.servlet;

import com.skillgap.db.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/AssessmentServlet")
public class AssessmentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String skillIdStr = request.getParameter("skill_id");
        if (skillIdStr == null) {
            response.sendRedirect("DashboardServlet");
            return;
        }

        int skillId;
        try {
            skillId = Integer.parseInt(skillIdStr);
        } catch (NumberFormatException e) {
            response.sendRedirect("DashboardServlet");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        try (Connection con = DBConnection.getConnection()) {
            // get student id
            int studentId;
            try (PreparedStatement psStu = con.prepareStatement(
                    "SELECT student_id FROM students WHERE user_id = ?")) {
                psStu.setInt(1, userId);
                try (ResultSet rs = psStu.executeQuery()) {
                    if (rs.next()) {
                        studentId = rs.getInt("student_id");
                    } else {
                        response.sendRedirect("DashboardServlet");
                        return;
                    }
                }
            }

            // fetch claimed proficiency level
            int claimedLevel = 1;
            try (PreparedStatement psLvl = con.prepareStatement(
                    "SELECT proficiency_level FROM student_skills " +
                            "WHERE student_id = ? AND skill_id = ?")) {
                psLvl.setInt(1, studentId);
                psLvl.setInt(2, skillId);
                try (ResultSet rs = psLvl.executeQuery()) {
                    if (rs.next()) {
                        claimedLevel = rs.getInt("proficiency_level");
                    }
                }
            }

            int totalQuestions = 5 + claimedLevel;
            int minDifficulty = Math.max(1, claimedLevel - 1);
            int maxDifficulty = Math.min(5, claimedLevel + 1);

            // obtain assessment_id for this skill for results linking
            int assessmentId = -1;
            try (PreparedStatement psAss = con.prepareStatement(
                    "SELECT assessment_id FROM assessments WHERE skill_id = ?")) {
                psAss.setInt(1, skillId);
                try (ResultSet rs = psAss.executeQuery()) {
                    if (rs.next()) {
                        assessmentId = rs.getInt("assessment_id");
                    }
                }
            }

            // fetch random questions within difficulty range
            List<Map<String, Object>> questions = new ArrayList<>();
            String qSql = "SELECT question_id, question_text, option_a, option_b, option_c, option_d " +
                    "FROM (SELECT * FROM questions WHERE skill_id = ? " +
                    "AND difficulty_level BETWEEN ? AND ? ORDER BY DBMS_RANDOM.VALUE) " +
                    "WHERE ROWNUM <= ?";
            try (PreparedStatement psQ = con.prepareStatement(qSql)) {
                psQ.setInt(1, skillId);
                psQ.setInt(2, minDifficulty);
                psQ.setInt(3, maxDifficulty);
                psQ.setInt(4, totalQuestions);
                try (ResultSet rs = psQ.executeQuery()) {
                    while (rs.next()) {
                        Map<String, Object> q = new HashMap<>();
                        q.put("questionId", rs.getInt("question_id"));
                        q.put("questionText", rs.getString("question_text"));
                        q.put("optionA", rs.getString("option_a"));
                        q.put("optionB", rs.getString("option_b"));
                        q.put("optionC", rs.getString("option_c"));
                        q.put("optionD", rs.getString("option_d"));
                        questions.add(q);
                    }
                }
            }

            request.setAttribute("questions", questions);
            request.setAttribute("skillId", skillId);
            request.setAttribute("assessmentId", assessmentId);
            request.setAttribute("totalQuestions", totalQuestions);

            request.getRequestDispatcher("assessment.jsp").forward(request, response);
            return;

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("DashboardServlet");
        }
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

        // new dynamic parameters
        String skillIdStr = request.getParameter("skillId");
        String assessmentIdStr = request.getParameter("assessmentId");
        String completionTimeStr = request.getParameter("completionTime");

        try {
            int skillId = Integer.parseInt(skillIdStr);
            int assessmentId = Integer.parseInt(assessmentIdStr);
            int completionTime = Integer.parseInt(completionTimeStr);
            int userId = (int) session.getAttribute("userId");

            if (completionTime < 0) {
                response.sendRedirect("assessment.jsp?error=Invalid completion time");
                return;
            }

            // collect answers
            String[] qIds = request.getParameterValues("questionIds");
            if (qIds == null || qIds.length == 0) {
                response.sendRedirect("assessment.jsp?error=No answers submitted");
                return;
            }

            int totalQuestions = qIds.length;

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
                            throw new SQLException("Student not found");
                        }
                    }
                }

                // compute score by fetching correct options
                Map<Integer, String> correctMap = new HashMap<>();
                String inClause = String.join(",", Collections.nCopies(qIds.length, "?"));
                String correctSql = "SELECT question_id, correct_option FROM questions WHERE question_id IN ("
                        + inClause + ")";
                try (PreparedStatement psCorr = con.prepareStatement(correctSql)) {
                    for (int i = 0; i < qIds.length; i++) {
                        psCorr.setInt(i + 1, Integer.parseInt(qIds[i]));
                    }
                    try (ResultSet rs = psCorr.executeQuery()) {
                        while (rs.next()) {
                            correctMap.put(rs.getInt("question_id"), rs.getString("correct_option"));
                        }
                    }
                }

                int score = 0;
                for (String qidStr : qIds) {
                    int qid = Integer.parseInt(qidStr);
                    String ans = request.getParameter("ans_" + qid);
                    if (ans != null && ans.equalsIgnoreCase(correctMap.get(qid))) {
                        score++;
                    }
                }
                int percentage = (int) ((score * 100.0) / totalQuestions);

                // Insert into assessment_results using assessmentId (from GET)
                String insertSql = "INSERT INTO assessment_results " +
                        "(result_id, student_id, assessment_id, score, percentage, completion_time) " +
                        "VALUES (seq_assessment_results.NEXTVAL, ?, ?, ?, ?, ?)";
                try (PreparedStatement psIns = con.prepareStatement(insertSql)) {
                    psIns.setInt(1, studentId);
                    psIns.setInt(2, assessmentId);
                    psIns.setInt(3, score);
                    psIns.setInt(4, percentage);
                    psIns.setInt(5, completionTime);
                    psIns.executeUpdate();
                }

                // --- auto-sync student_skills start ---
                // fetch claimed level before updating
                int claimedLevel = 1;
                try (PreparedStatement psCL = con.prepareStatement(
                        "SELECT proficiency_level FROM student_skills WHERE student_id = ? AND skill_id = ?")) {
                    psCL.setInt(1, studentId);
                    psCL.setInt(2, skillId);
                    try (ResultSet rs = psCL.executeQuery()) {
                        if (rs.next()) {
                            claimedLevel = rs.getInt("proficiency_level");
                        }
                    }
                }

                // map percentage to actual level
                int profLevel;
                if (percentage >= 90)
                    profLevel = 5;
                else if (percentage >= 75)
                    profLevel = 4;
                else if (percentage >= 60)
                    profLevel = 3;
                else if (percentage >= 40)
                    profLevel = 2;
                else
                    profLevel = 1;

                // update or insert student_skills
                boolean hasEntry = false;
                try (PreparedStatement psCheck = con.prepareStatement(
                        "SELECT student_skill_id FROM student_skills WHERE student_id = ? AND skill_id = ?")) {
                    psCheck.setInt(1, studentId);
                    psCheck.setInt(2, skillId);
                    try (ResultSet rs = psCheck.executeQuery()) {
                        if (rs.next()) {
                            hasEntry = true;
                        }
                    }
                }

                if (hasEntry) {
                    String updateSql = "UPDATE student_skills SET proficiency_level = ?, assessed_date = SYSDATE " +
                            "WHERE student_id = ? AND skill_id = ?";
                    try (PreparedStatement psUpd = con.prepareStatement(updateSql)) {
                        psUpd.setInt(1, profLevel);
                        psUpd.setInt(2, studentId);
                        psUpd.setInt(3, skillId);
                        psUpd.executeUpdate();
                    }
                } else {
                    String insertSkillSql = "INSERT INTO student_skills " +
                            "(student_skill_id, student_id, skill_id, proficiency_level, assessed_date) " +
                            "VALUES (seq_student_skills.NEXTVAL, ?, ?, ?, SYSDATE)";
                    try (PreparedStatement psNew = con.prepareStatement(insertSkillSql)) {
                        psNew.setInt(1, studentId);
                        psNew.setInt(2, skillId);
                        psNew.setInt(3, profLevel);
                        psNew.executeUpdate();
                    }
                }
                // --- auto-sync student_skills end ---

                // --- Insert gap analysis into database (DB-DRIVEN, NOT SESSION) ---
                // Fetch claimed level (already have it from before UPDATE)
                int claimedLevelForGap = claimedLevel; // from earlier query
                double gapScore = profLevel - claimedLevelForGap;
                String gapInsertSql = "INSERT INTO skill_gap_analysis " +
                        "(analysis_id, student_id, skill_id, current_level, target_level, gap_score, analysis_date) " +
                        "VALUES (seq_skill_gap_analysis.NEXTVAL, ?, ?, ?, ?, ?, SYSTIMESTAMP)";
                try (PreparedStatement psGapIns = con.prepareStatement(gapInsertSql)) {
                    psGapIns.setInt(1, studentId);
                    psGapIns.setInt(2, skillId);
                    psGapIns.setInt(3, claimedLevelForGap);
                    psGapIns.setInt(4, profLevel);
                    psGapIns.setDouble(5, gapScore);
                    psGapIns.executeUpdate();
                }
                // --- gap analysis persistence end ---

                // Remove session dependency - do NOT set session attributes
                // SkillGapServlet will fetch all data from database on next page

                con.commit();

                response.sendRedirect("result.jsp?percentage=" + percentage);
                return;

            } catch (SQLException e) {
                e.printStackTrace();
                response.sendRedirect("assessment.jsp?error=Database error occurred");
            }

        } catch (NumberFormatException e) {
            response.sendRedirect("assessment.jsp?error=Invalid input format");
        }
    }
}
