<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Skill Gap Analysis</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css" />
</head>
<body>
    <nav class="navbar">
        <div class="nav-container">
            <h1>Skill Gap Analysis</h1>
            <ul class="nav-menu">
                <li><a href="DashboardServlet">Dashboard</a></li>
                <li><a href="SkillsServlet">Skills</a></li>
                <li><a href="SkillGapServlet">Skill Gaps</a></li>
                <li><a href="LogoutServlet" class="btn btn-logout">Logout</a></li>
            </ul>
        </div>
    </nav>
<%
    if (session == null || session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<div class="container">
    <h1>Skill Gap Analysis</h1>
    <a href="DashboardServlet" class="btn btn-secondary">Back to Dashboard</a>
    
    <h2>Recommendations Based on Target Job</h2>
    <%
        java.util.List<String> recommendations = (java.util.List<String>) request.getAttribute("recommendations");
        if (recommendations != null && !recommendations.isEmpty()) {
    %>
    <ul>
        <% for (String r : recommendations) { %>
        <li><%= r %></li>
        <% } %>
    </ul>
    <% } else { %>
    <p>No specific recommendations at this time.</p>
    <% } %>
    
    <h2>Gap Records</h2>
    <%
        java.util.List<java.util.Map<String,Object>> gapHistory =
                (java.util.List<java.util.Map<String,Object>>) request.getAttribute("gapHistory");
        if (gapHistory != null && !gapHistory.isEmpty()) {
    %>
    <table class="gap-table">
        <tr><th>Skill</th><th>Current Level</th><th>Target Level</th><th>Gap Score</th><th>Date</th></tr>
        <% for (java.util.Map<String,Object> g : gapHistory) { %>
        <tr>
            <td><%= g.get("skillName") %></td>
            <td><%= g.get("currentLevel") %></td>
            <td><%= g.get("targetLevel") %></td>
            <td><%= g.get("gapScore") %></td>
            <td><%= g.get("analysisDate") %></td>
        </tr>
        <% } %>
    </table>
    <% } else { %>
    <p>No gap analyses performed yet.</p>
    <% } %>
</div>
</body>
</html>