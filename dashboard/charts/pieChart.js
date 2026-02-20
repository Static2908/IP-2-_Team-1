// Pie Chart Specific Functions

function createPieChartData(skills, values) {
    return {
        labels: skills,
        datasets: [{
            data: values,
            backgroundColor: [
                '#667eea', '#764ba2', '#f093fb', '#ae3ec9', '#f5576c'
            ],
            borderColor: '#fff',
            borderWidth: 2
        }]
    };
}

function formatPieChartOptions() {
    return {
        responsive: true,
        maintainAspectRatio: true,
        plugins: {
            legend: {
                position: 'bottom',
                labels: {
                    font: {
                        size: 12
                    },
                    padding: 15
                }
            },
            tooltip: {
                callbacks: {
                    label: function(context) {
                        let sum = context.dataset.data.reduce((a, b) => a + b, 0);
                        let percentage = (context.parsed * 100 / sum).toFixed(1) + "%";
                        return context.label + ": " + percentage;
                    }
                }
            }
        }
    };
}

// Export for module usage
if (typeof module !== 'undefined' && module.exports) {
    module.exports = {
        createPieChartData,
        formatPieChartOptions
    };
}
