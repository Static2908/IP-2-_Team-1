// Dashboard Charts Initialization

// studentData may be injected by servlet; fallback placeholder
const studentData = (typeof window !== 'undefined' && window.studentData) ? window.studentData : {
    name: 'John Doe',
    department: 'Computer Science',
    semester: 4,
    cgpa: 3.5,
    skills: {},
    targetLevels: {},
    skillGaps: {}
};

// Initialize all charts when page loads
document.addEventListener('DOMContentLoaded', function() {
    loadProfileInfo();
    renderChartColorGuide();
    initSkillsChart();
    initTargetRadarChart();
    initGapChart();
    loadRecommendations();
});

function getLevelColor(level) {
    const numericLevel = Number(level);
    if (numericLevel <= 1) return '#dc2626';
    if (numericLevel <= 2) return '#f97316';
    if (numericLevel <= 3) return '#eab308';
    if (numericLevel <= 4) return '#86efac';
    return '#15803d';
}

function renderChartColorGuide() {
    const legendEl = document.getElementById('skillColorLegend');
    if (!legendEl) return;

    const skills = Object.entries(studentData.skills || {});
    if (skills.length === 0) {
        legendEl.innerHTML = '<span class="legend-note">No skill data available yet.</span>';
        return;
    }

    legendEl.innerHTML = skills.map(([skillName, level]) => {
        const color = getLevelColor(level);
        const numericLevel = Number(level) || 0;
        return `<span class="legend-item"><span class="legend-dot" style="background:${color}"></span>${skillName} (L${numericLevel})</span>`;
    }).join('');
}

// Load student profile information
function loadProfileInfo() {
    if (!studentData) return;
    const nameEl = document.getElementById('studentName');
    const deptEl = document.getElementById('studentDept');
    const semEl = document.getElementById('studentSem');
    const cgpaEl = document.getElementById('studentCGPA');
    if (nameEl) nameEl.textContent = studentData.name || '';
    if (deptEl) deptEl.textContent = studentData.department || '';
    if (semEl) semEl.textContent = studentData.semester || '';
    if (cgpaEl && studentData.cgpa != null) cgpaEl.textContent = studentData.cgpa.toFixed(2);
}

// Initialize Skills Radar/Bar Chart
function initSkillsChart() {
    const ctx = document.getElementById('skillsChart');
    if (!ctx || !studentData || !studentData.skills) return;
    
    const skillLabels = Object.keys(studentData.skills);
    const skillValues = Object.values(studentData.skills).map(Number);
    const levelColors = skillValues.map(getLevelColor);

    if (skillLabels.length === 0) return;
    
    new Chart(ctx, {
        type: 'radar',
        data: {
            labels: skillLabels,
            datasets: [{
                label: 'Your Current Skill Levels',
                data: skillValues,
                borderColor: '#2563eb',
                backgroundColor: 'rgba(37, 99, 235, 0.16)',
                borderWidth: 2,
                pointRadius: 5,
                pointBackgroundColor: levelColors,
                pointHoverBackgroundColor: levelColors,
                pointBorderColor: '#1f2937'
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: true,
            scales: {
                r: {
                    beginAtZero: true,
                    max: 5,
                    ticks: {
                        stepSize: 1
                    }
                }
            },
            plugins: {
                legend: {
                    position: 'top',
                    labels: {
                        font: {
                            size: 12
                        }
                    }
                }
            }
        }
    });
}

function initTargetRadarChart() {
    const ctx = document.getElementById('targetRadarChart');
    if (!ctx || !studentData) return;

    const skillLabels = Object.keys(studentData.skills || {});
    const currentValues = skillLabels.map(skill => Number((studentData.skills || {})[skill] || 0));
    const targetValues = skillLabels.map(skill => Number((studentData.targetLevels || {})[skill] || 0));

    if (skillLabels.length === 0) return;

    new Chart(ctx, {
        type: 'radar',
        data: {
            labels: skillLabels,
            datasets: [
                {
                    label: 'Your Current Level',
                    data: currentValues,
                    borderColor: '#2563eb',
                    backgroundColor: 'rgba(37, 99, 235, 0.12)',
                    borderWidth: 2,
                    pointBackgroundColor: currentValues.map(getLevelColor),
                    pointRadius: 4
                },
                {
                    label: 'Expected for Target Role',
                    data: targetValues,
                    borderColor: '#4b5563',
                    backgroundColor: 'rgba(75, 85, 99, 0.10)',
                    borderWidth: 2,
                    pointBackgroundColor: targetValues.map(getLevelColor),
                    pointRadius: 4
                }
            ]
        },
        options: {
            responsive: true,
            maintainAspectRatio: true,
            scales: {
                r: {
                    beginAtZero: true,
                    max: 5,
                    ticks: {
                        stepSize: 1
                    }
                }
            },
            plugins: {
                legend: {
                    position: 'top'
                }
            }
        }
    });
}

// Initialize Skill Gap Chart
function initGapChart() {
    const ctx = document.getElementById('gapChart');
    if (!ctx || !studentData) return;

    const parent = ctx.parentElement;
    const existingStatus = parent ? parent.querySelector('.gap-chart-status') : null;
    if (existingStatus) {
        existingStatus.remove();
    }

    if (studentData.gapAssessmentAttempted !== true) {
        ctx.style.display = 'none';
        if (parent) {
            const status = document.createElement('div');
            status.className = 'gap-chart-status';
            status.style.margin = '1rem 0';
            status.style.padding = '0.9rem 1rem';
            status.style.border = '1px solid #f59e0b';
            status.style.borderRadius = '8px';
            status.style.background = '#fffbeb';
            status.style.color = '#92400e';
            status.style.fontWeight = '600';
            status.style.textAlign = 'center';
            status.textContent = 'Assessment not attempted yet. Complete at least one assessment to view skill gap chart.';
            parent.appendChild(status);
        }
        return;
    }

    ctx.style.display = 'block';

    const gapSource = studentData.skillGaps || {};
    const gapLabels = Object.keys(gapSource);
    const gapValues = Object.values(gapSource).map(Number);
    if (gapLabels.length === 0) {
        if (parent) {
            const status = document.createElement('div');
            status.className = 'gap-chart-status';
            status.style.margin = '1rem 0';
            status.style.padding = '0.9rem 1rem';
            status.style.border = '1px solid #93c5fd';
            status.style.borderRadius = '8px';
            status.style.background = '#eff6ff';
            status.style.color = '#1e3a8a';
            status.style.fontWeight = '600';
            status.style.textAlign = 'center';
            status.textContent = 'No skill gap analysis records available yet.';
            parent.appendChild(status);
        }
        return;
    }

    const gapColors = gapValues.map((value) => {
        if (value > 0) return '#16a34a';
        if (value < 0) return '#dc2626';
        return '#eab308';
    });
    
    new Chart(ctx, {
        type: 'bar',
        data: {
            labels: gapLabels,
            datasets: [{
                label: 'Skill Gap Score',
                data: gapValues,
                backgroundColor: gapColors,
                borderColor: gapColors,
                borderWidth: 1,
                borderRadius: 5,
                minBarLength: 4 // Ensures even a 0 gap is visible as a small sliver
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: true,
            indexAxis: 'y',
            scales: {
                x: {
                    min: -5,
                    max: 5,
                    grid: {
                        color: (context) => {
                            if (context.tick.value === 0) {
                                return '#333'; // Make the zero line bold and visible
                            }
                            return '#e5e7eb';
                        }
                    }
                }
            },
            plugins: {
                legend: {
                    display: true,
                    labels: {
                        font: {
                            size: 12
                        }
                    }
                }
            }
        }
    });
}

// Load recommendations
function loadRecommendations() {
    const recommendations = [
        {
            skill: 'Python',
            text: 'Focus on Python fundamentals and practice with data science libraries like NumPy and Pandas.',
            priority: 'High'
        },
        {
            skill: 'Machine Learning',
            text: 'Take online courses in ML algorithms and work on real-world projects to gain practical experience.',
            priority: 'High'
        },
        {
            skill: 'Cloud Computing',
            text: 'Learn AWS or Azure basics and work on cloud deployment projects.',
            priority: 'Medium'
        },
        {
            skill: 'System Design',
            text: 'Study distributed systems concepts and practice system design problems.',
            priority: 'Medium'
        }
    ];
    
    const recommendationsList = document.getElementById('recommendationsList');
    if (recommendationsList) {
        recommendationsList.innerHTML = recommendations.map(rec => `
            <div class="recommendation-card">
                <h3>${rec.skill}</h3>
                <p>${rec.text}</p>
                <span class="priority">Priority: ${rec.priority}</span>
            </div>
        `).join('');
    }
}

// Utility function to update chart data dynamically
function updateChart(chartId, newData) {
    if (typeof Chart === 'undefined') return;
    
    const canvas = document.getElementById(chartId);
    if (!canvas) return;
    
    const chartInstance = Chart.helpers.getChart(canvas);
    if (chartInstance) {
        chartInstance.data = newData;
        chartInstance.update();
    }
}

// Export functions for use in other modules
if (typeof module !== 'undefined' && module.exports) {
    module.exports = {
        initSkillsChart,
        initTargetRadarChart,
        initGapChart,
        loadRecommendations,
        updateChart
    };
}
