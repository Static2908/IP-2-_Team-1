<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String assetVersion = "gapfix-20260313-2";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=<%= assetVersion %>">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css?v=<%= assetVersion %>">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
    <%
        // Check if user is logged in
        String username = (String) session.getAttribute("username");
        if (username == null) {
            response.sendRedirect("login.jsp");
            return;
        }
    %>
    
    <nav class="navbar">
        <div class="nav-container">
            <h1>Dashboard</h1>
            <ul class="nav-menu">
                <li><a href="DashboardServlet">Dashboard</a></li>
                <li><a href="SkillsServlet">Skills</a></li>
                <li><a href="SkillGapServlet">Skill Gaps</a></li>
                <li><a href="LogoutServlet" class="btn btn-logout">Logout</a></li>
            </ul>
        </div>
    </nav>

    <div class="container">
        <%
            // summary stats
            Integer total = (Integer) request.getAttribute("totalSkills");
            Double avg = (Double) request.getAttribute("avgProficiency");
        %>
        <script>
            // data provided by DashboardServlet
            var __skillJson = '<%= request.getAttribute("skillJson") %>';
            var __targetJson = '<%= request.getAttribute("targetJson") %>';
            var __gapJson = '<%= request.getAttribute("gapJson") %>';
            try { __skillJson = JSON.parse(__skillJson); } catch(e){ __skillJson = {}; }
            try { __targetJson = JSON.parse(__targetJson); } catch(e){ __targetJson = {}; }
            try { __gapJson = JSON.parse(__gapJson); } catch(e){ __gapJson = {}; }

            window.studentData = {
                name: "<%= username %>",
                skills: __skillJson,
                targetLevels: __targetJson,
                skillGaps: __gapJson
            };
        </script>
        <section class="section dashboard-card skill-summary-card">
            <h2>Skill Summary</h2>
            <div class="profile-info">
                <p><strong>Username:</strong> <%= username %></p>
                <p><strong>Login Time:</strong> <%= new java.util.Date() %></p>
                <p><strong>Target Role:</strong> <%= request.getAttribute("targetJob") != null ? request.getAttribute("targetJob") : "Target role not set" %></p>
                <p><strong>Total Skills:</strong> <%= total != null ? total : 0 %></p>
                <p><strong>Average Proficiency:</strong> <%= avg != null ? String.format("%.2f", avg) : "N/A" %></p>
            </div>
        </section>

        <section class="section dashboard-card quick-actions-card">
            <h2>Quick Actions</h2>
            <div class="action-buttons">
            <a href="SkillsServlet" class="btn btn-primary">Manage Skills</a>
            <a href="SkillsServlet" class="btn btn-primary">Take Assessment</a>
            <a href="SkillGapServlet" class="btn btn-primary">View Skill Gap</a>
            </div>
        </section>

        <section class="section charts-section dashboard-card charts-card">
            <h2>Charts</h2>
            <div class="charts-container">
                <div class="chart-box">
                    <h3>Skill Proficiency</h3>
                    <p style="margin:0 0 0.75rem; color:#64748b; font-size:0.9rem;">
                        This shows your current level in each skill.
                    </p>
                    <canvas id="skillsChart"></canvas>
                </div>
                <div class="chart-box">
                    <h3>Target Role Comparison</h3>
                    <p style="margin:0 0 0.75rem; color:#64748b; font-size:0.9rem;">
                        Blue shows your current level. Gray shows the level expected for your target role.
                    </p>
                    <canvas id="targetRadarChart"></canvas>
                </div>
                <div class="chart-box">
                    <h3>Skill Gaps</h3>
                    <canvas id="gapChart"></canvas>
                </div>
            </div>

            <div class="chart-guide" aria-label="Chart color guide">
                <div class="guide-group">
                    <h4>Skill Colors</h4>
                    <div id="skillColorLegend" class="legend-row"></div>
                </div>
                <div class="guide-group">
                    <h4>Level and Gap Key</h4>
                    <div class="legend-row legend-static">
                        <span class="legend-item"><span class="legend-dot" style="background:#dc2626"></span>Level 1 / Negative Gap</span>
                        <span class="legend-item"><span class="legend-dot" style="background:#f97316"></span>Level 2</span>
                        <span class="legend-item"><span class="legend-dot" style="background:#eab308"></span>Level 3 / Zero Gap</span>
                        <span class="legend-item"><span class="legend-dot" style="background:#86efac"></span>Level 4</span>
                        <span class="legend-item"><span class="legend-dot" style="background:#15803d"></span>Level 5 / Positive Gap</span>
                    </div>
                    <p style="margin:0.6rem 0 0; color:#64748b; font-size:0.88rem;">
                        Negative gap means you are below the expected level. Positive gap means you are above it.
                    </p>
                </div>
            </div>
        </section>
    </div>
    <script src="${pageContext.request.contextPath}/js/charts.js?v=<%= assetVersion %>"></script>
    <script src="${pageContext.request.contextPath}/js/skillMapping.js?v=<%= assetVersion %>"></script>
    <script>
        (function applyGapChartColorOverride() {
            function getGapColor(value) {
                const numericValue = Number(value);
                if (numericValue > 0) return '#16a34a';
                if (numericValue < 0) return '#dc2626';
                return '#eab308';
            }

            function syncGapChartColors() {
                if (typeof Chart === 'undefined' || !window.studentData || !window.studentData.skillGaps) {
                    return;
                }

                const gapCanvas = document.getElementById('gapChart');
                if (!gapCanvas) {
                    return;
                }

                const chart = Chart.getChart(gapCanvas);
                if (!chart || !chart.data || !chart.data.datasets || !chart.data.datasets.length) {
                    return;
                }

                const gapValues = Object.values(window.studentData.skillGaps).map(Number);
                chart.data.datasets[0].backgroundColor = gapValues.map(getGapColor);
                chart.update();
            }

            if (document.readyState === 'loading') {
                document.addEventListener('DOMContentLoaded', function() {
                    setTimeout(syncGapChartColors, 0);
                });
            } else {
                setTimeout(syncGapChartColors, 0);
            }
        })();
    </script>
</body>
</html>
