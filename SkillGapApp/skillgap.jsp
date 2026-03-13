<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    String assetVersion = "gapfix-20260313-2";
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Skill Gap Analysis</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css?v=<%= assetVersion %>" />
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/dashboard.css?v=<%= assetVersion %>" />
</head>
<body>

<%
    if (session == null || session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<nav class="navbar">
    <div class="nav-container">
        <h1>Skill Gap Analysis</h1>
        <ul class="nav-menu">
            <li><a href="DashboardServlet">Dashboard</a></li>
            <li><a href="SkillsServlet">Skills</a></li>
            <li><a href="SkillGapServlet">Skill Gaps</a></li>
            <li><a href="LogoutServlet" class="btn btn-logout">Logout</a></li>
        </ul>
    </div>
</nav>

<div class="container">

    <h2>Skill Gap Analysis</h2>
    <a href="DashboardServlet" class="btn btn-secondary">Back to Dashboard</a>

    <%
        List<String> jobRecommendations =
                (List<String>) request.getAttribute("jobRecommendations");

        Map<String, List<String>> skillRecommendationsMap =
            (Map<String, List<String>>) request.getAttribute("skillRecommendationsMap");

        List<String> skillRecommendations =
                (List<String>) request.getAttribute("skillRecommendations");

        List<Map<String,Object>> gapHistory =
                (List<Map<String,Object>>) request.getAttribute("gapHistory");
    %>

    <section class="section dashboard-card">
    <h3>Career Recommendations</h3>

    <%
        if (jobRecommendations != null && !jobRecommendations.isEmpty()) {
    %>
        <ul class="recommendation-list">
        <%
            for (String rec : jobRecommendations) {
        %>
            <li><%= rec %></li>
        <%
            }
        %>
        </ul>
    <%
        } else {
    %>
        <p>No career recommendations at this time.</p>
    <%
        }
    %>

    <%
        Map<String, Object> cmmiInfo = (Map<String, Object>) request.getAttribute("cmmiEligibility");
        Double avgLevel = (Double) request.getAttribute("avgSkillLevel");
        if (cmmiInfo != null) {
            String badgeColor = (String) cmmiInfo.get("badgeColor");
            String badgeBg;
            if      ("blue".equals(badgeColor))   { badgeBg = "#3b82f6"; }
            else if ("teal".equals(badgeColor))   { badgeBg = "#14b8a6"; }
            else if ("green".equals(badgeColor))  { badgeBg = "#22c55e"; }
            else if ("orange".equals(badgeColor)) { badgeBg = "#f97316"; }
            else if ("purple".equals(badgeColor)) { badgeBg = "#8b5cf6"; }
            else if ("gold".equals(badgeColor))   { badgeBg = "#f59e0b"; }
            else                                  { badgeBg = "#9ca3af"; }
    %>
    <div class="card" style="margin-top:1.25rem; border-left:4px solid <%= badgeBg %>; padding:1rem 1.25rem;">
        <h4 style="margin-top:0; margin-bottom:0.75rem; color:#1e293b;">CMMI Company Eligibility</h4>
        <div style="display:flex; align-items:center; flex-wrap:wrap; gap:0.75rem; margin-bottom:0.75rem;">
            <span style="background:<%= badgeBg %>; color:#fff; padding:0.3rem 0.85rem; border-radius:20px; font-weight:700; font-size:0.85rem;">
                <%= cmmiInfo.get("cmmiLevel") %>
            </span>
            <span style="color:#6b7280; font-size:0.9rem;"><%= cmmiInfo.get("status") %></span>
            <% if (avgLevel != null && avgLevel > 0.0) { %>
            <span style="margin-left:auto; background:#f1f5f9; padding:0.3rem 0.75rem; border-radius:12px; font-size:0.85rem; color:#374151;">
                Avg. Skill Level: <strong><%= String.format("%.1f", avgLevel) %> / 5.0</strong>
            </span>
            <% } %>
        </div>
        <p style="color:#475569; margin-bottom:0.75rem; font-size:0.95rem;"><%= cmmiInfo.get("description") %></p>
        <p style="font-size:0.9rem; font-weight:600; color:#374151; margin-bottom:0.4rem;">Eligible Organizations:</p>
        <ul class="recommendation-list">
        <% for (String company : (List<String>) cmmiInfo.get("companies")) { %>
            <li><%= company %></li>
        <% } %>
        </ul>
    </div>
    <%
        }
    %>

    </section>

    <section class="section dashboard-card">
    <h3>Skill Improvement Recommendations</h3>

    <%
        if (skillRecommendationsMap != null && !skillRecommendationsMap.isEmpty()) {
            for (Map.Entry<String, List<String>> skillEntry : skillRecommendationsMap.entrySet()) {
    %>
        <div class="card">
            <h4><%= skillEntry.getKey() %></h4>
            <ul class="recommendation-list">
            <%
                for (String rec : skillEntry.getValue()) {
            %>
                <li><%= rec %></li>
            <%
                }
            %>
            </ul>
        </div>
    <%
            }
        } else if (skillRecommendations != null && !skillRecommendations.isEmpty()) {
    %>
        <ul class="recommendation-list">
        <%
            for (String rec : skillRecommendations) {
        %>
            <li><%= rec %></li>
        <%
            }
        %>
        </ul>
    <%
        } else {
    %>
        <p>No skill recommendations at this time.</p>
    <%
        }
    %>

    </section>

    <section class="section dashboard-card">
    <h3>Gap Records</h3>

    <%
        if (gapHistory != null && !gapHistory.isEmpty()) {
    %>

        <div class="card">
        <table class="gap-table">
            <thead>
                <tr>
                    <th>Skill</th>
                    <th>Claimed Level</th>
                    <th>Actual Level</th>
                    <th>Gap</th>
                    <th>Assessment Date</th>
                </tr>
            </thead>
            <tbody>
            <%
                for (Map<String,Object> g : gapHistory) {
                    int current = (Integer) g.get("currentLevel");
                    int target = (Integer) g.get("targetLevel");
                    double gap = ((Number) g.get("gapScore")).doubleValue();

                    String gapClass = "";
                    String gapStyle = "";
                    if (gap > 0) {
                        gapClass = "gap-positive";
                        gapStyle = "color:#2e7d32;font-weight:bold;";
                    } else if (gap < 0) {
                        gapClass = "gap-negative";
                        gapStyle = "color:#c62828;font-weight:bold;";
                    } else {
                        gapClass = "gap-neutral";
                        gapStyle = "color:#a16207;font-weight:bold;";
                    }

                    Object analysisDateObj = g.get("analysisDate");
                    String formattedDate;
                    if (analysisDateObj instanceof java.sql.Timestamp) {
                        formattedDate = new SimpleDateFormat("dd MMM yyyy, hh:mm a").format((java.sql.Timestamp) analysisDateObj);
                    } else if (analysisDateObj instanceof java.util.Date) {
                        formattedDate = new SimpleDateFormat("dd MMM yyyy, hh:mm a").format((java.util.Date) analysisDateObj);
                    } else {
                        formattedDate = analysisDateObj != null ? analysisDateObj.toString() : "N/A";
                    }
            %>
                <tr>
                    <td><%= g.get("skillName") %></td>
                    <td><%= current %></td>
                    <td><%= target %></td>
                    <td class="<%= gapClass %>" style="<%= gapStyle %>"><%= String.format("%.2f", gap) %></td>
                    <td><%= formattedDate %></td>
                </tr>
            <%
                }
            %>
            </tbody>
        </table>
        </div>

    <%
        } else {
    %>
        <p>No gap analyses performed yet.</p>
    <%
        }
    %>

    </section>

</div>

</body>
</html>