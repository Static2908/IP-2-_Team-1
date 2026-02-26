package com.skillgap.servlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/AssessmentServlet")
public class AssessmentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
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

                // compute percentage using total_questions from assessments
                int percentage = 0;
                try (PreparedStatement psAss = con.prepareStatement(
                        "SELECT total_questions FROM assessments WHERE assessment_id = ?")) {
                    psAss.setInt(1, assessmentId);
                    try (ResultSet rs = psAss.executeQuery()) {
                        if (rs.next()) {
                            int total = rs.getInt("total_questions");
                            if (total > 0) {
                                percentage = (int) ((score * 100.0) / total);
                            }
                        } else {
                            throw new SQLException("Assessment not found: " + assessmentId);
                        }
                    }
                }

                // insert result
                String insertSql = "INSERT INTO assessment_results (result_id, student_id, assessment_id, score, percentage, completion_time) "
                        +
                        "VALUES (seq_assessment_results.NEXTVAL, ?, ?, ?, ?, ?)";
                try (PreparedStatement psIns = con.prepareStatement(insertSql)) {
                    psIns.setInt(1, studentId);
                    psIns.setInt(2, assessmentId);
                    psIns.setInt(3, score);
                    psIns.setInt(4, percentage);
                    psIns.setInt(5, completionTime);
                    psIns.executeUpdate();
                }
                // redirect to result page with percentage
                response.sendRedirect("result.jsp?percentage=" + percentage);
                return;
            }

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid input format");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("assessment.jsp?error=Database error occurred");
        }
    }
}
