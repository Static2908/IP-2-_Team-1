<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <%
            String errorMessage = (String) request.getAttribute("errorMessage");
            int errorCode = (Integer) request.getAttribute("errorCode");
            
            if (errorMessage == null) {
                errorMessage = "An unexpected error occurred!";
            }
            if (errorCode == 0) {
                errorCode = 500;
            }
        %>
        <div class="error">
            <h2>Error <%= errorCode %></h2>
            <p><%= errorMessage %></p>
        </div>
        <a href="login.jsp" class="btn btn-primary">Back to Login</a>
    </div>
</body>
</html>