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
            String msg = request.getParameter("message");
            if (msg != null) {
        %>
            <div class="success"><%= msg %></div>
        <%
            }

            Object gapObj = request.getAttribute("gapAnalysis");
        %>
        <section id="profile" class="section">
            <h2>Student Profile</h2>
            <div class="profile-info">
                <p><strong>Username:</strong> <%= username %></p>
                <p><strong>Login Time:</strong> <%= new java.util.Date() %></p>
                <p><strong>Target Job:</strong> <%= request.getAttribute("targetJob") != null ? request.getAttribute("targetJob") : "Target job not set" %></p>
            </div>
        </section>

        <section id="skills" class="section">
            <h2>Your Skills</h2>
            <%
                java.util.List<java.util.Map<String, Object>> skills = 
                    (java.util.List<java.util.Map<String, Object>>) request.getAttribute("skills");
                if (skills != null && !skills.isEmpty()) {
            %>
            <div class="skills-list">
                <ul>
                    <% for (java.util.Map<String, Object> skill : skills) { %>
                    <li><strong><%= skill.get("name") %></strong> - Level: <%= skill.get("level") %></li>
                    <% } %>
                </ul>
            </div>
            <% } else { %>
            <p>No skills added yet. <a href="skillEntry.jsp">Add a skill</a> to get started.</p>
            <% } %>
        </section>

        <%
            java.util.List<String> jRecs = (java.util.List<String>) request.getAttribute("jobRecommendations");
            if (jRecs != null && !jRecs.isEmpty()) {
        %>
        <section id="job-recs" class="section">
            <h2>Job-based Recommendations</h2>
            <ul>
                <% for (String rec : jRecs) { %>
                <li><%= rec %></li>
                <% } %>
            </ul>
        </section>
        <% } %>

        <section id="gaps" class="section">
            <h2>Skill Gaps Analysis</h2>
            <%
                if (gapObj != null) {
                    if (gapObj instanceof java.util.List) {
                        java.util.List list = (java.util.List) gapObj;
                        if (!list.isEmpty()) {
            %>
            <table class="gap-table">
                <tr><th>Skill</th><th>Current</th><th>Target</th><th>Gap</th><th>Date</th></tr>
                <%
                            for (Object o : list) {
                                java.util.Map map = (java.util.Map) o;
                %>
                <tr>
                    <td><%= map.get("skillName") %></td>
                    <td><%= map.get("currentLevel") %></td>
                    <td><%= map.get("targetLevel") %></td>
                    <td><%= map.get("gapScore") %></td>
                    <td><%= map.get("analysisDate") %></td>
                </tr>
                <%
                            }
                %>
            </table>
            <%
                        } else {
            %>
            <p>No gap analyses recorded yet.</p>
            <%
                        }
                    } else if (gapObj instanceof java.util.Map) {
                        java.util.Map mapOnly = (java.util.Map) gapObj;
                        out.println("Latest analysis: " + mapOnly.toString());
                    } else {
                        out.println(gapObj.toString());
                    }
                } else {
            %>
            <p>Skill gap analysis will be displayed here...</p>
            <%
                }
            %>
        </section>

        <div class="action-buttons">
            <a href="skillEntry.jsp" class="btn btn-primary">Add Skills</a>
            <a href="assessment.jsp" class="btn btn-primary">Take Assessment</a>
        </div>
    </div>
    <script src="${pageContext.request.contextPath}/js/charts.js"></script>
    <script src="${pageContext.request.contextPath}/js/skillMapping.js"></script>
</body>
</html>
