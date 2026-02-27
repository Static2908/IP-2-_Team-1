<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
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
    <title>Submit Assessment</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <h1>Submit Assessment Result</h1>
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
        <form action="AssessmentServlet" method="post">
            <div class="form-group">
                <label for="assessmentId">Assessment ID:</label>
                <input type="number" id="assessmentId" name="assessmentId" required>
            </div>
            <div class="form-group">
                <label for="score">Score:</label>
                <input type="number" id="score" name="score" required>
            </div>
            <div class="form-group">
                <label for="completionTime">Completion Time (seconds):</label>
                <input type="number" id="completionTime" name="completionTime" required>
            </div>
            <button type="submit" class="btn btn-primary">Submit</button>
        </form>
        <p><a href="DashboardServlet">Back to Dashboard</a></p>
    </div>
</body>
</html>