<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Skills</title>
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
    <h1>Your Skills</h1>
    <a href="skillEntry.jsp" class="btn btn-primary">Add New Skill</a>
    <a href="DashboardServlet" class="btn btn-secondary">Back to Dashboard</a>
    <%
        java.util.List<java.util.Map<String,Object>> skills =
                (java.util.List<java.util.Map<String,Object>>) request.getAttribute("skills");
        if (skills != null && !skills.isEmpty()) {
    %>
    <table class="gap-table">
        <tr><th>Skill</th><th>Level</th><th>Actions</th></tr>
        <% for (java.util.Map<String,Object> sk : skills) { %>
        <tr>
            <td><%= sk.get("name") %></td>
            <td><%= sk.get("level") %></td>
            <td>
                <form action="SkillsServlet" method="post" style="display:inline;">
                    <input type="hidden" name="action" value="delete" />
                    <input type="hidden" name="id" value="<%= sk.get("id") %>" />
                    <button type="submit" class="btn btn-secondary">Delete</button>
                </form>
            </td>
        </tr>
        <% } %>
    </table>
    <% } else { %>
    <p>No skills recorded yet.</p>
    <% } %>
</div>
</body>
</html>