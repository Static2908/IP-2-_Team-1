<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    
    <h3> Career Recommendations</h3>
    <c:if test="${not empty jobRecommendations}">
        <ul>
            <c:forEach var="rec" items="${jobRecommendations}">
                <li>${rec}</li>
            </c:forEach>
        </ul>
    </c:if>

    <h3> Skill Improvement Recommendations</h3>
    <c:if test="${not empty skillRecommendations}">
        <ul>
            <c:forEach var="rec" items="${skillRecommendations}">
                <li>${rec}</li>
            </c:forEach>
        </ul>
    </c:if>
    
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