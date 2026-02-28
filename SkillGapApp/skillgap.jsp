<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Skill Gap Analysis</title>
    <link rel="stylesheet" href="css/style.css" />
    <link rel="stylesheet" href="css/dashboard.css" />
</head>
<body>
<%
    if (session == null || session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<div class="container">
    <h1>Skill Gap Analysis</h1>
    <a href="DashboardServlet" class="btn btn-secondary">Back to Dashboard</a>
    
    <%
        String lastSkillName = (String) request.getAttribute("lastSkillName");
        Integer lastClaimedLevel = (Integer) request.getAttribute("lastClaimedLevel");
        Integer lastActualLevel = (Integer) request.getAttribute("lastActualLevel");
        Double lastGapScore = (Double) request.getAttribute("lastGapScore");
        if (lastSkillName != null) {
    %>
    <div class="recent-gap">
        <h2>Recent Assessment Gap</h2>
        <p>Skill: <%= lastSkillName %></p>
        <p>Claimed level: <%= lastClaimedLevel %>, Actual level: <%= lastActualLevel %>, Gap: <%= lastGapScore %></p>
    </div>
    <% } %>
    <h2>Recommendations Based on Target Job</h2>
    <%
        java.util.List<String> recs = (java.util.List<String>) request.getAttribute("jobRecommendations");
        if (recs != null && !recs.isEmpty()) {
    %>
    <ul>
        <% for (String r : recs) { %>
        <li><%= r %></li>
        <% } %>
    </ul>
    <% } else { %>
    <p>No specific recommendations at this time.</p>
    <% } %>
    
    <h2>Gap Records</h2>
    <%
        java.util.List<java.util.Map<String,Object>> gaps =
                (java.util.List<java.util.Map<String,Object>>) request.getAttribute("gapAnalysis");
        if (gaps != null && !gaps.isEmpty()) {
    %>
    <table class="gap-table">
        <tr><th>Skill</th><th>Current</th><th>Target</th><th>Gap</th><th>Date</th></tr>
        <% for (java.util.Map<String,Object> g : gaps) { %>
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