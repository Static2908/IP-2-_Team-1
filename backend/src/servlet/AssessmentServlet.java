package com.skillgap.servlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

public class AssessmentServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.html");
            return;
        }
        
        String assessmentIdStr = request.getParameter("assessmentId");
        String answersStr = request.getParameter("answers");
        String completionTimeStr = request.getParameter("completionTime");
        
        try {
            int assessmentId = Integer.parseInt(assessmentIdStr);
            int completionTime = Integer.parseInt(completionTimeStr);
            
            // Parse answers (format: "1,0,2,1,...")
            String[] answers = answersStr.split(",");
            
            // TODO: Calculate score based on correct answers
            // int score = calculateScore(assessmentId, answers);
            // int percentage = (score / totalQuestions) * 100;
            
            // TODO: Store assessment result in database
            // AssessmentResult result = new AssessmentResult(studentId, assessmentId, score, percentage, completionTime);
            
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.println("{\"status\":\"success\",\"message\":\"Assessment submitted successfully\"}");
            
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid input format");
        }
    }
}
