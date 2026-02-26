package com.skillgap.servlet;

import com.skillgap.db.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/AssessmentServlet")
public class AssessmentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String assessmentIdStr = request.getParameter("assessmentId");
        String scoreStr = request.getParameter("score");
        String completionTimeStr = request.getParameter("completionTime");

        try {
            int assessmentId = Integer.parseInt(assessmentIdStr);
            int score = Integer.parseInt(scoreStr);
            int completionTime = Integer.parseInt(completionTimeStr);
            int userId = (int) session.getAttribute("userId");

            if (completionTime < 0) {
                response.sendRedirect("assessment.jsp?error=Invalid completion time");
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
                            throw new SQLException("Student not found");
                        }
                    }
                }

                int totalQuestions;

                // Fetch total_questions
                try (PreparedStatement psAss = con.prepareStatement(
                        "SELECT total_questions FROM assessments WHERE assessment_id = ?")) {

                    psAss.setInt(1, assessmentId);

                    try (ResultSet rs = psAss.executeQuery()) {
                        if (rs.next()) {
                            totalQuestions = rs.getInt("total_questions");
                        } else {
                            throw new SQLException("Assessment not found");
                        }
                    }
                }

                if (totalQuestions <= 0) {
                    response.sendRedirect("assessment.jsp?error=Invalid assessment configuration");
                    return;
                }

                if (score < 0 || score > totalQuestions) {
                    response.sendRedirect("assessment.jsp?error=Invalid score value");
                    return;
                }

                int percentage = (int) ((score * 100.0) / totalQuestions);

                // Insert into assessment_results
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
                // map percentage to proficiency level
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

                // fetch skill_id from assessment
                int skillId;
                try (PreparedStatement psSkill = con.prepareStatement(
                        "SELECT skill_id FROM assessments WHERE assessment_id = ?")) {
                    psSkill.setInt(1, assessmentId);
                    try (ResultSet rs = psSkill.executeQuery()) {
                        if (rs.next()) {
                            skillId = rs.getInt("skill_id");
                        } else {
                            throw new SQLException("Assessment not found when syncing skills");
                        }
                    }
                }

                // check if student_skill exists
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