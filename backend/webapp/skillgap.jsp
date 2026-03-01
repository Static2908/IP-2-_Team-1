<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Skill Gap Analysis</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css" />
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/dashboard.css" />
</head>
<body>

<%
    if (session == null || session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

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

<div class="container">

    <h2>Skill Gap Analysis</h2>
    <a href="DashboardServlet" class="btn btn-secondary">Back to Dashboard</a>

    <hr/>

    <%
        List<String> jobRecommendations =
                (List<String>) request.getAttribute("jobRecommendations");

        List<String> skillRecommendations =
                (List<String>) request.getAttribute("skillRecommendations");

        List<Map<String,Object>> gapHistory =
                (List<Map<String,Object>>) request.getAttribute("gapHistory");
    %>

    <!-- ================= Career Recommendations ================= -->

    <h3>🎯 Career Recommendations</h3>

    <%
        if (jobRecommendations != null && !jobRecommendations.isEmpty()) {
    %>
        <ul class="recommendation-list">
        <%
            for (String rec : jobRecommendations) {
        %>
            <li><%= rec %></li>
        <%
            }
        %>
        </ul>
    <%
        } else {
    %>
        <p>No career recommendations at this time.</p>
    <%
        }
    %>

    <hr/>

    <!-- ================= Skill Recommendations ================= -->

    <h3>🛠 Skill Improvement Recommendations</h3>

    <%
        if (skillRecommendations != null && !skillRecommendations.isEmpty()) {
    %>
        <ul class="recommendation-list">
        <%
            for (String rec : skillRecommendations) {
        %>
            <li><%= rec %></li>
        <%
            }
        %>
        </ul>
    <%
        } else {
    %>
        <p>No skill recommendations at this time.</p>
    <%
        }
    %>

    <hr/>

    <!-- ================= Gap History ================= -->

    <h3>Gap Records</h3>

    <%
        if (gapHistory != null && !gapHistory.isEmpty()) {
    %>

        <table class="gap-table">
            <thead>
                <tr>
                    <th>Skill</th>
                    <th>Current Level</th>
                    <th>Target Level</th>
                    <th>Gap Score</th>
                    <th>Date</th>
                </tr>
            </thead>
            <tbody>
            <%
                for (Map<String,Object> g : gapHistory) {
            %>
                <tr>
                    <td><%= g.get("skillName") %></td>
                    <td><%= g.get("currentLevel") %></td>
                    <td><%= g.get("targetLevel") %></td>
                    <td><%= g.get("gapScore") %></td>
                    <td><%= g.get("analysisDate") %></td>
                </tr>
            <%
                }
            %>
            </tbody>
        </table>

    <%
        } else {
    %>
        <p>No gap analyses performed yet.</p>
    <%
        }
    %>

</div>

</body>
</html>