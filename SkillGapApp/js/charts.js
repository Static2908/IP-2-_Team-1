// Bar, pie, radar chart scripts (frontend/js/charts.js)

function generateBarChart(ctx, labels, data) {
    new Chart(ctx, {
        type: 'bar',
        data: {
            labels: labels,
            datasets: [{
                label: 'Skill Level',
                data: data,
                backgroundColor: 'rgba(102, 126, 234, 0.6)',
                borderColor: 'rgba(102, 126, 234, 1)',
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            scales: {
                y: { beginAtZero: true }
            }
        }
    });
}

function generatePieChart(ctx, labels, data) {
    new Chart(ctx, {
        type: 'pie',
        data: {
            labels: labels,
            datasets: [{
                data: data,
                backgroundColor: [
                    'rgba(102, 126, 234, 0.6)',
                    'rgba(201, 213, 224, 0.6)',
                    'rgba(118, 75, 162, 0.6)'
                ],
                borderWidth: 1
            }]
        }
    });
}

function generateRadarChart(ctx, labels, data) {
    new Chart(ctx, {
        type: 'radar',
        data: {
            labels: labels,
            datasets: [{
                label: 'Skill Profile',
                data: data,
                backgroundColor: 'rgba(102, 126, 234, 0.4)',
                borderColor: 'rgba(102, 126, 234, 1)',
                pointBackgroundColor: 'rgba(201, 213, 224, 0.6)'
            }]
        },
        options: {
            responsive: true,
            scales: {
                r: { beginAtZero: true }
            }
        }
    });
}