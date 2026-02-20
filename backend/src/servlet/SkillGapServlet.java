package com.skillgap.servlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class SkillGapServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.html");
            return;
        }
        
        int studentId = (int) session.getAttribute("userId");
        
        // TODO: Fetch skill gap analysis from database
        // List<SkillGapAnalysis> gapAnalysis = getSkillGapAnalysis(studentId);
        
        // Forward to JSP for display
        request.setAttribute("gapAnalysis", null); // Replace with actual data
        request.getRequestDispatcher("skillGap.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }
        
        String skillId = request.getParameter("skillId");
        String targetLevel = request.getParameter("targetLevel");
        
        // TODO: Trigger skill gap analysis and generate recommendations
        // SkillGapCalculator calculator = new SkillGapCalculator();
        // SkillGapAnalysis analysis = calculator.analyzeGap(studentId, Integer.parseInt(skillId), Integer.parseInt(targetLevel));
        
        response.setContentType("application/json");
        response.getWriter().println("{\"status\":\"success\"}");
    }
}
