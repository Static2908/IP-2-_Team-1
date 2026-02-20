// Dashboard Chart Generation Functions

/**
 * Bar Chart for Skill Distribution
 */
function generateBarChart(skills, proficiencies) {
    return {
        type: 'bar',
        data: {
            labels: skills,
            datasets: [{
                label: 'Proficiency Level',
                data: proficiencies,
                backgroundColor: '#667eea',
                borderColor: '#5568d3',
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            scales: {
                y: {
                    beginAtZero: true,
                    max: 5
                }
            }
        }
    };
}

/**
 * Pie Chart for Skill Category Distribution
 */
function generatePieChart(categories, counts) {
    const colors = ['#667eea', '#764ba2', '#f093fb', '#4facfe', '#43e97b'];
    
    return {
        type: 'pie',
        data: {
            labels: categories,
            datasets: [{
                data: counts,
                backgroundColor: colors,
                borderColor: '#fff',
                borderWidth: 2
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: {
                    position: 'bottom'
                }
            }
        }
    };
}

/**
 * Radar Chart for Skill Comparison
 */
function generateRadarChart(skillLabels, datasetArray) {
    const datasets = datasetArray.map((data, index) => ({
        label: data.label,
        data: data.values,
        borderColor: ['#667eea', '#f093fb', '#43e97b'][index],
        backgroundColor: [`rgba(102, 126, 234, 0.2)`, `rgba(240, 147, 251, 0.2)`, `rgba(67, 233, 123, 0.2)`][index],
        borderWidth: 2
    }));
    
    return {
        type: 'radar',
        data: {
            labels: skillLabels,
            datasets: datasets
        },
        options: {
            responsive: true,
            scales: {
                r: {
                    beginAtZero: true,
                    max: 5
                }
            }
        }
    };
}

/**
 * Line Chart for Progress Tracking
 */
function generateLineChart(months, progressData) {
    return {
        type: 'line',
        data: {
            labels: months,
            datasets: [{
                label: 'Proficiency Progress',
                data: progressData,
                borderColor: '#667eea',
                backgroundColor: 'rgba(102, 126, 234, 0.1)',
                tension: 0.4,
                fill: true,
                pointBackgroundColor: '#667eea',
                pointBorderColor: '#fff',
                pointBorderWidth: 2,
                pointRadius: 5
            }]
        },
        options: {
            responsive: true,
            scales: {
                y: {
                    beginAtZero: true,
                    max: 5
                }
            }
        }
    };
}

/**
 * Doughnut Chart for Gap Analysis
 */
function generateDoughnutChart(gapLabels, gapValues) {
    const colors = ['#f56565', '#ed8936', '#ecc94b', '#48bb78', '#38b2ac'];
    
    return {
        type: 'doughnut',
        data: {
            labels: gapLabels,
            datasets: [{
                data: gapValues,
                backgroundColor: colors,
                borderColor: '#fff',
                borderWidth: 2
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: {
                    position: 'right'
                }
            }
        }
    };
}

/**
 * Bubble Chart for Skill vs Assessment Performance
 */
function generateBubbleChart(dataPoints) {
    return {
        type: 'bubble',
        data: {
            datasets: [{
                label: 'Skills Performance',
                data: dataPoints.map(point => ({
                    x: point.proficiency,
                    y: point.assessmentScore,
                    r: point.importance
                })),
                backgroundColor: 'rgba(102, 126, 234, 0.6)',
                borderColor: '#667eea'
            }]
        },
        options: {
            responsive: true,
            scales: {
                x: {
                    title: {
                        display: true,
                        text: 'Proficiency Level'
                    },
                    max: 5
                },
                y: {
                    title: {
                        display: true,
                        text: 'Assessment Score (%)'
                    },
                    max: 100
                }
            }
        }
    };
}

/**
 * Export chart utility function
 */
function exportChartAsImage(canvasId, filename) {
    const canvas = document.getElementById(canvasId);
    if (canvas) {
        const image = canvas.toDataURL('image/png');
        const link = document.createElement('a');
        link.href = image;
        link.download = filename + '.png';
        link.click();
    }
}

// Export functions for use in other modules
if (typeof module !== 'undefined' && module.exports) {
    module.exports = {
        generateBarChart,
        generatePieChart,
        generateRadarChart,
        generateLineChart,
        generateDoughnutChart,
        generateBubbleChart,
        exportChartAsImage
    };
}
