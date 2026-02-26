<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- Simple redirect to login page to avoid 404 on root --%>
<%
    response.sendRedirect("login.jsp");
%>