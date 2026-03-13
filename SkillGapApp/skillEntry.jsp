<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%
    // session protection
    if (session == null || session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Skill</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <h1>Add Skill</h1>
        <%
            String error = request.getParameter("error");
            String success = request.getParameter("success");
            if (error != null) {
        %>
            <div class="error"><%= error %></div>
        <%
            }
            if (success != null) {
        %>
            <div class="success"><%= success %></div>
        <%
            }
        %>
        <section class="card skill-guide">
            <h2>Skill Level Guide</h2>
            <div class="profile-info">
                <p><strong>1 - Beginner:</strong> Basic awareness and limited hands-on practice.</p>
                <p><strong>2 - Novice:</strong> Can complete simple tasks with guidance.</p>
                <p><strong>3 - Intermediate:</strong> Works independently on common tasks.</p>
                <p><strong>4 - High Proficiency:</strong> Handles complex tasks and mentors others.</p>
                <p><strong>5 - Advanced:</strong> Expert-level depth with strong problem solving.</p>
            </div>
        </section>

        <section class="section">
            <h2>Skill Details</h2>
        <form action="SkillEntryServlet" method="post">
            <div class="form-group">
                <label for="skillName">Skill Name:</label>
                    <%
                        List<String> skills = (List<String>) request.getAttribute("skills");
                    %>
                    <select id="skillName" name="skillName" required>
                        <option value="" disabled selected>Select a skill</option>
                        <%
                            if (skills != null) {
                                for (String skill : skills) {
                        %>
                        <option value="<%= skill %>"><%= skill %></option>
                        <%
                                }
                            }
                        %>
                    </select>
            </div>
            <div class="form-group">
                <label for="proficiencyLevel">Proficiency Level:</label>
                <select id="proficiencyLevel" name="proficiencyLevel" required>
                    <option value="" disabled selected>Select level</option>
                    <option value="1">1 - Beginner</option>
                    <option value="2">2 - Novice</option>
                    <option value="3">3 - Intermediate</option>
                    <option value="4">4 - High Proficiency</option>
                    <option value="5">5 - Advanced</option>
                </select>
            </div>
            <div class="form-group">
                <label for="experience">Experience (years):</label>
                <input type="number" id="experience" name="experience" min="0" required>
            </div>
            <button type="submit" class="btn btn-primary">Add Skill</button>
        </form>
        </section>
        <p><a href="DashboardServlet">Back to Dashboard</a></p>
    </div>
</body>
</html>