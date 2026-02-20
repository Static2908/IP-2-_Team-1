// Dashboard Charts Initialization

// Sample data for charts
const studentData = {
    name: 'John Doe',
    department: 'Computer Science',
    semester: 4,
    cgpa: 3.5,
    skills: {
        'Java': 4,
        'Python': 2,
        'Web Development': 4,
        'Database': 3,
        'Data Structures': 3,
        'Machine Learning': 1
    },
    skillGaps: {
        'Python': 2,
        'Machine Learning': 3,
        'Cloud Computing': 2.5,
        'System Design': 2.0
    }
};

// Initialize all charts when page loads
document.addEventListener('DOMContentLoaded', function() {
    loadProfileInfo();
    initSkillsChart();
    initGapChart();
    loadRecommendations();
});

// Load student profile information
function loadProfileInfo() {
    document.getElementById('studentName').textContent = studentData.name;
    document.getElementById('studentDept').textContent = studentData.department;
    document.getElementById('studentSem').textContent = studentData.semester;
    document.getElementById('studentCGPA').textContent = studentData.cgpa.toFixed(2);
}

// Initialize Skills Radar/Bar Chart
function initSkillsChart() {
    const ctx = document.getElementById('skillsChart');
    if (!ctx) return;
    
    const skillLabels = Object.keys(studentData.skills);
    const skillValues = Object.values(studentData.skills);
    
    new Chart(ctx, {
        type: 'radar',
        data: {
            labels: skillLabels,
            datasets: [{
                label: 'Your Proficiency Levels',
                data: skillValues,
                borderColor: '#667eea',
                backgroundColor: 'rgba(102, 126, 234, 0.2)',
                borderWidth: 2,
                pointRadius: 5,
                pointBackgroundColor: '#667eea',
                pointHoverBackgroundColor: '#764ba2'
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

// Initialize Skill Gap Chart
function initGapChart() {
    const ctx = document.getElementById('gapChart');
    if (!ctx) return;
    
    const gapLabels = Object.keys(studentData.skillGaps);
    const gapValues = Object.values(studentData.skillGaps);
    
    new Chart(ctx, {
        type: 'bar',
        data: {
            labels: gapLabels,
            datasets: [{
                label: 'Skill Gap Score',
                data: gapValues,
                backgroundColor: [
                    '#f56565',
                    '#ed8936',
                    '#ecc94b',
                    '#48bb78'
                ],
                borderRadius: 5
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: true,
            indexAxis: 'y',
            scales: {
                x: {
                    beginAtZero: true,
                    max: 5
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
        initGapChart,
        loadRecommendations,
        updateChart
    };
}
