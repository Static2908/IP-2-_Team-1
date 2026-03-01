<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Skills</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css" />
</head>
<body>
    <nav class="navbar">
        <div class="nav-container">
            <h1>Skills</h1>
            <ul class="nav-menu">
                <li><a href="DashboardServlet">Dashboard</a></li>
                <li><a href="SkillsServlet">Skills</a></li>
                <li><a href="SkillGapServlet">Skill Gaps</a></li>
                <li><a href="LogoutServlet" class="btn btn-logout">Logout</a></li>
            </ul>
        </div>
    </nav>
    <div class="container">
        <h1>Your Skills</h1>
        <div class="action-buttons">
            <a href="skillEntry.jsp" class="btn btn-primary">Add New Skill</a>
        </div>
        <a href="DashboardServlet" class="btn btn-secondary">Back to Dashboard</a>
        <%
            java.util.List<java.util.Map<String,Object>> skills =
                    (java.util.List<java.util.Map<String,Object>>) request.getAttribute("skills");
            if (skills != null && !skills.isEmpty()) {
        %>
        <table class="skills-table">
            <thead>
                <tr>
                    <th>Skill</th>
                    <th>Level</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
            <% for (java.util.Map<String,Object> sk : skills) { %>
                <tr>
                    <td><%= sk.get("name") %></td>
                    <td><%= sk.get("level") %></td>
                    <td>
                        <a href="AssessmentServlet?skill_id=<%= sk.get("skillId") %>" class="btn btn-sm btn-primary">Assess</a>
                        <form action="SkillsServlet" method="post" style="display:inline;">
                            <input type="hidden" name="action" value="delete" />
                            <input type="hidden" name="id" value="<%= sk.get("id") %>" />
                            <button type="submit" class="btn btn-secondary btn-sm">Delete</button>
                        </form>
                    </td>
                </tr>
            <% } %>
            </tbody>
        </table>
        <% } else { %>
        <p>No skills recorded yet.</p>
        <% } %>
    </div>
</body>
</html>