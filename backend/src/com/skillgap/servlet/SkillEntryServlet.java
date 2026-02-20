package com.skillgap.servlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.skillgap.util.InputValidator;
import java.io.IOException;

public class SkillEntryServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.html");
            return;
        }
        
        String skillName = request.getParameter("skillName");
        String levelStr = request.getParameter("proficiencyLevel");
        String expStr = request.getParameter("experience");
        
        // Validate inputs
        if (skillName == null || skillName.trim().isEmpty()) {
            response.sendRedirect("skillEntry.html?error=Skill name is required");
            return;
        }
        
        try {
            int proficiencyLevel = Integer.parseInt(levelStr);
            int experience = Integer.parseInt(expStr);
            
            if (!InputValidator.isValidProficiencyLevel(proficiencyLevel)) {
                response.sendRedirect("skillEntry.html?error=Invalid proficiency level");
                return;
            }
            
            if (experience < 0) {
                response.sendRedirect("skillEntry.html?error=Experience cannot be negative");
                return;
            }
            
            // TODO: Store skill entry in database
            // int studentId = (int) session.getAttribute("userId");
            // StudentSkill studentSkill = new StudentSkill(studentId, skillId, proficiencyLevel);
            
            response.sendRedirect("skillEntry.html?success=Skill added successfully!");
            
        } catch (NumberFormatException e) {
            response.sendRedirect("skillEntry.html?error=Invalid input format");
        }
    }
}
