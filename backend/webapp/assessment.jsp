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
        <form action="AssessmentServlet" method="post" id="mcqForm">
            <input type="hidden" name="skillId" value="<%= request.getAttribute("skillId") %>" />
            <input type="hidden" name="assessmentId" value="<%= request.getAttribute("assessmentId") %>" />
            <input type="hidden" id="completionTime" name="completionTime" value="0">

            <div class="mcq-section">
                <%
                    java.util.List<java.util.Map<String,Object>> questions =
                            (java.util.List<java.util.Map<String,Object>>) request.getAttribute("questions");
                    if (questions != null && !questions.isEmpty()) {
                        int qnum = 1;
                        for (java.util.Map<String,Object> q : questions) {
                            int qid = (Integer) q.get("questionId");
                %>
                <div class="question-block">
                    <h3>Question <%= qnum++ %></h3>
                    <p><%= q.get("questionText") %></p>
                    <input type="hidden" name="questionIds" value="<%= qid %>" />
                    <label><input type="radio" name="ans_<%= qid %>" value="A" required> <%= q.get("optionA") %></label><br>
                    <label><input type="radio" name="ans_<%= qid %>" value="B"> <%= q.get("optionB") %></label><br>
                    <label><input type="radio" name="ans_<%= qid %>" value="C"> <%= q.get("optionC") %></label><br>
                    <label><input type="radio" name="ans_<%= qid %>" value="D"> <%= q.get("optionD") %></label><br>
                </div>
                <%      }
                    } else {
                %>
                <p>No questions available for this skill.</p>
                <% }
                %>
            </div>

            <button type="submit" class="btn btn-primary">Submit</button>
        </form>
        <script>
            document.getElementById('mcqForm').addEventListener('submit', function(e) {

                document.getElementById('completionTime').value = Math.floor(Math.random()*300);
            });
        </script>
        <p><a href="DashboardServlet">Back to Dashboard</a></p>
    </div>
</body>
</html>