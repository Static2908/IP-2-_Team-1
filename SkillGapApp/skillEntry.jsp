<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
        <form action="SkillEntryServlet" method="post">
            <div class="form-group">
                <label for="skillName">Skill Name:</label>
                <input type="text" id="skillName" name="skillName" required>
            </div>
            <div class="form-group">
                <label for="proficiencyLevel">Proficiency Level (1-5):</label>
                <input type="number" id="proficiencyLevel" name="proficiencyLevel" min="1" max="5" required>
            </div>
            <div class="form-group">
                <label for="experience">Experience (years):</label>
                <input type="number" id="experience" name="experience" min="0" required>
            </div>
            <button type="submit" class="btn btn-primary">Add Skill</button>
        </form>
        <p><a href="DashboardServlet">Back to Dashboard</a></p>
    </div>
</body>
</html>