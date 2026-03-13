package com.skillgap.servlet;

import com.skillgap.db.DBConnection;
import com.skillgap.util.InputValidator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/SkillEntryServlet")
public class SkillEntryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<String> skillsList = new ArrayList<>();
        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(
                        "SELECT skill_name FROM skills ORDER BY skill_name");
                ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                skillsList.add(rs.getString("skill_name"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("skills", skillsList);
        request.getRequestDispatcher("skillEntry.jsp").forward(request, response);
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

        String skillName = request.getParameter("skillName");
        String levelStr = request.getParameter("proficiencyLevel");
        String expStr = request.getParameter("experience");

        if (skillName == null || skillName.trim().isEmpty()) {
            response.sendRedirect("SkillEntryServlet?error=Please+select+a+skill");
            return;
        }

        try {
            int proficiencyLevel = Integer.parseInt(levelStr);
            int experience = Integer.parseInt(expStr);
            int userId = (int) session.getAttribute("userId");

            if (!InputValidator.isValidProficiencyLevel(proficiencyLevel)) {
                response.sendRedirect("SkillEntryServlet?error=Invalid+proficiency+level");
                return;
            }

            if (experience < 0) {
                response.sendRedirect("SkillEntryServlet?error=Experience+cannot+be+negative");
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
                            con.rollback();
                            response.sendRedirect("SkillEntryServlet?error=Invalid+skill+selected");
                            return;
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
                response.sendRedirect("SkillEntryServlet?success=Skill+added+successfully");
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
                response.sendRedirect("SkillEntryServlet?error=Database+error+occurred");
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
            response.sendRedirect("SkillEntryServlet?error=Invalid+input+format");
        }
    }
}