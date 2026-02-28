<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Registration</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <h1>Student Registration</h1>
        <%
            String error = request.getParameter("error");
            if (error != null) {
        %>
            <div class="error"><%= error %></div>
        <%
            }
        %>
        <form id="studentForm" action="RegisterStudentServlet" method="post">
            <fieldset>
                <legend>Personal Information</legend>
                <div class="form-group">
                    <label for="firstName">First Name:</label>
                    <input type="text" id="firstName" name="firstName" required>
                </div>
                <div class="form-group">
                    <label for="lastName">Last Name:</label>
                    <input type="text" id="lastName" name="lastName" required>
                </div>
                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" required>
                </div>
                <div class="form-group">
                    <label for="username">Username:</label>
                    <input type="text" id="username" name="username" required>
                </div>
                <div class="form-group">
                    <label for="password">Password:</label>
                    <input type="password" id="password" name="password" required>
                </div>
            </fieldset>

            <fieldset>
                <legend>Academic Information</legend>
                <div class="form-group">
                    <label for="department">Department:</label>
                    <select id="department" name="department" required>
                        <option value="">Select Department</option>
                        <option value="Computer Science">Computer Science</option>
                        <option value="Information Technology">Information Technology</option>
                        <option value="Software Engineering">Software Engineering</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="semester">Semester:</label>
                    <input type="number" id="semester" name="semester" min="1" max="8" required>
                </div>
                <div class="form-group">
    <label for="cgpa">CGPA (0 - 10):</label>
    <input type="number"
           id="cgpa"
           name="cgpa"
           step="0.01"
           min="0"
           max="10"
           required>
</div>
<div class="form-group">
    <label for="targetJob">Target Job:</label>
    <input type="text"
           id="targetJob"
           name="targetJob"
           required>
</div>
            </fieldset>

            <button type="submit" class="btn btn-success">Register</button>
            <a href="login.jsp" class="btn btn-secondary">Back to Login</a>
        </form>
    </div>
    <script src="${pageContext.request.contextPath}/js/validation.js"></script>
</body>
</html>