<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
</head>
<body>
    <%
        // Check if user is logged in
        String username = (String) session.getAttribute("username");
        if (username == null) {
            response.sendRedirect("login.html");
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
        <section id="profile" class="section">
            <h2>Student Profile</h2>
            <div class="profile-info">
                <p><strong>Username:</strong> <%= username %></p>
                <p><strong>Login Time:</strong> <%= new java.util.Date() %></p>
            </div>
        </section>

        <section id="skills" class="section">
            <h2>Your Skills</h2>
            <p>Skills information will be loaded here...</p>
        </section>

        <section id="gaps" class="section">
            <h2>Skill Gaps Analysis</h2>
            <p>Skill gap analysis will be displayed here...</p>
        </section>

        <div class="action-buttons">
            <a href="skillEntry.html" class="btn btn-primary">Add Skills</a>
            <a href="assessmentQuiz.html" class="btn btn-primary">Take Assessment</a>
        </div>
    </div>
</body>
</html>
