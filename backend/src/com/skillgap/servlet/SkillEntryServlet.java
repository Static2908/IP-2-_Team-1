package com.skillgap.servlet;

import com.skillgap.db.DBConnection;
import com.skillgap.util.InputValidator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/SkillEntryServlet")
public class SkillEntryServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String skillName = request.getParameter("skillName");
        String levelStr = request.getParameter("proficiencyLevel");
        String expStr = request.getParameter("experience");

        if (skillName == null || skillName.trim().isEmpty()) {
            response.sendRedirect("skillEntry.jsp?error=Skill name is required");
            return;
        }

        try {
            int proficiencyLevel = Integer.parseInt(levelStr);
            int experience = Integer.parseInt(expStr);
            int userId = (int) session.getAttribute("userId");

            if (!InputValidator.isValidProficiencyLevel(proficiencyLevel)) {
                response.sendRedirect("skillEntry.jsp?error=Invalid proficiency level");
                return;
            }

            if (experience < 0) {
                response.sendRedirect("skillEntry.jsp?error=Experience cannot be negative");
                return;
            }

            // perform database operations: fetch student_id then insert skill
            Connection con = null;
            try {
                con = DBConnection.getConnection();
                con.setAutoCommit(false);
                int studentId;
                // fetch student_id from students table
                String queryStu = "SELECT student_id FROM students WHERE user_id = ?";
                try (PreparedStatement psStu = con.prepareStatement(queryStu)) {
                    psStu.setInt(1, userId);
                    try (ResultSet rs = psStu.executeQuery()) {
                        if (rs.next()) {
                            studentId = rs.getInt("student_id");
                        } else {
                            throw new SQLException("Student not found for user id " + userId);
                        }
                    }
                }

                int skillId;
                String selectSkill = "SELECT skill_id FROM skills WHERE skill_name = ?";
                try (PreparedStatement psSel = con.prepareStatement(selectSkill)) {
                    psSel.setString(1, skillName);
                    try (ResultSet rs = psSel.executeQuery()) {
                        if (rs.next()) {
                            skillId = rs.getInt("skill_id");
                        } else {
                            String insertSkill = "INSERT INTO skills (skill_id, skill_name) VALUES (seq_skills.NEXTVAL, ?)";
                            try (PreparedStatement psIns = con.prepareStatement(insertSkill)) {
                                psIns.setString(1, skillName);
                                psIns.executeUpdate();
                            }
                            // fetch currval for skill_id
                            try (PreparedStatement psCurr = con
                                    .prepareStatement("SELECT seq_skills.CURRVAL FROM dual")) {
                                try (ResultSet rs2 = psCurr.executeQuery()) {
                                    if (rs2.next()) {
                                        skillId = rs2.getInt(1);
                                    } else {
                                        throw new SQLException("Failed to obtain skill_id CURRVAL");
                                    }
                                }
                            }
                        }
                    }
                }

                String insertStudentSkill = "INSERT INTO student_skills (student_skill_id, student_id, skill_id, proficiency_level, assessed_date) "
                        +
                        "VALUES (seq_student_skills.NEXTVAL, ?, ?, ?, SYSDATE)";
                try (PreparedStatement psSS = con.prepareStatement(insertStudentSkill)) {
                    psSS.setInt(1, studentId);
                    psSS.setInt(2, skillId);
                    psSS.setInt(3, proficiencyLevel);
                    psSS.executeUpdate();
                }

                con.commit();
                response.sendRedirect("skillEntry.jsp?success=Skill added successfully");
                return;
            } catch (SQLException sqle) {
                sqle.printStackTrace();
                if (con != null) {
                    try {
                        con.rollback();
                    } catch (SQLException ex) {
                        ex.printStackTrace();
                    }
                }
                response.sendRedirect("skillEntry.jsp?error=Database error occurred");
                return;
            } finally {
                if (con != null) {
                    try {
                        con.close();
                    } catch (SQLException ex) {
                    }
                }
            }

        } catch (NumberFormatException e) {
            response.sendRedirect("skillEntry.jsp?error=Invalid input format");
        }
    }
}