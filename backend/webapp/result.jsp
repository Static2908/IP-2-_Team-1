<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Result</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <%
            String resultMessage = (String) request.getAttribute("resultMessage");
            String resultType = (String) request.getAttribute("resultType"); // success or error
            String percParam = request.getParameter("percentage");
            if (percParam != null) {
                resultMessage = "Your score percentage: " + percParam + "%";
                resultType = "success";
            }
            if (resultMessage != null) {
        %>
            <div class="<%= "success".equals(resultType) ? "success" : "error" %>">
                <%= resultMessage %>
            </div>
        <%
            } else {
        %>
            <div class="error">No result available</div>
        <%
            }
        %>
        <a href="DashboardServlet" class="btn btn-primary">Back to Dashboard</a>
    </div>
</body>
</html>
