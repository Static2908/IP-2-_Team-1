<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
    <%
        // Check if user is logged in
        String username = (String) session.getAttribute("username");
        if (username == null) {
            response.sendRedirect("login.jsp");
            return;
        }
    %>
    
    <nav class="navbar">
        <div class="nav-container">
            <h1>Dashboard</h1>
            <ul class="nav-menu">
                <li><a href="#profile">Profile</a></li>
                <li><a href="#skills">Skills</a></li>
                <li><a href="#gaps">Skill Gaps</a></li>
                <li><a href="LogoutServlet" class="btn btn-logout">Logout</a></li>
            </ul>
        </div>
    </nav>

    <div class="container">
        <%
            // summary stats
            Integer total = (Integer) request.getAttribute("totalSkills");
            Double avg = (Double) request.getAttribute("avgProficiency");
        %>
        <script>
            // data provided by DashboardServlet
            var __skillJson = '<%= request.getAttribute("skillJson") %>';
            var __targetJson = '<%= request.getAttribute("targetJson") %>';
            var __gapJson = '<%= request.getAttribute("gapJson") %>';
            try { __skillJson = JSON.parse(__skillJson); } catch(e){ __skillJson = {}; }
            try { __targetJson = JSON.parse(__targetJson); } catch(e){ __targetJson = {}; }
            try { __gapJson = JSON.parse(__gapJson); } catch(e){ __gapJson = {}; }

            window.studentData = {
                name: "<%= username %>",
                skills: __skillJson,
                targetLevels: __targetJson,
                skillGaps: __gapJson
            };
        </script>
        <section class="section">
            <h2>Overview</h2>
            <div class="profile-info">
                <p><strong>Username:</strong> <%= username %></p>
                <p><strong>Login Time:</strong> <%= new java.util.Date() %></p>
                <p><strong>Target Job:</strong> <%= request.getAttribute("targetJob") != null ? request.getAttribute("targetJob") : "Target job not set" %></p>
                <p><strong>Total Skills:</strong> <%= total != null ? total : 0 %></p>
                <p><strong>Average Proficiency:</strong> <%= avg != null ? String.format("%.2f", avg) : "N/A" %></p>
            </div>
        </section>

        <div class="action-buttons">
            <a href="SkillsServlet" class="btn btn-primary">Manage Skills</a>
            <a href="AssessmentServlet" class="btn btn-primary">Take Assessment</a>
            <a href="SkillGapServlet" class="btn btn-primary">View Skill Gap</a>
        </div>

        <section class="section charts-section">
            <h2>Visual Overview</h2>
            <div class="charts-container">
                <div class="chart-box">
                    <h3>Skill Proficiency</h3>
                    <canvas id="skillsChart"></canvas>
                </div>
                <div class="chart-box">
                    <h3>Skill Gaps</h3>
                    <canvas id="gapChart"></canvas>
                </div>
            </div>
        </section>
    </div>
    <script src="${pageContext.request.contextPath}/js/charts.js"></script>
    <script src="${pageContext.request.contextPath}/js/skillMapping.js"></script>
</body>
</html>
