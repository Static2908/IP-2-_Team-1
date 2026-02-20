// Radar Chart Specific Functions for Skill Assessment

function createRadarChartData(skills, currentLevels, targetLevels) {
    return {
        labels: skills,
        datasets: [
            {
                label: 'Current Level',
                data: currentLevels,
                borderColor: '#667eea',
                backgroundColor: 'rgba(102, 126, 234, 0.2)',
                pointBackgroundColor: '#667eea',
                borderWidth: 2
            },
            {
                label: 'Target Level',
                data: targetLevels,
                borderColor: '#f093fb',
                backgroundColor: 'rgba(240, 147, 251, 0.2)',
                pointBackgroundColor: '#f093fb',
                borderWidth: 2,
                borderDash: [5, 5]
            }
        ]
    };
}

function formatRadarChartOptions() {
    return {
        responsive: true,
        maintainAspectRatio: true,
        scales: {
            r: {
                beginAtZero: true,
                max: 5,
                ticks: {
                    stepSize: 1,
                    font: {
                        size: 11
                    }
                },
                grid: {
                    drawBorder: true
                }
            }
        },
        plugins: {
            legend: {
                position: 'top',
                labels: {
                    font: {
                        size: 12
                    },
                    padding: 15
                }
            },
            tooltip: {
                backgroundColor: 'rgba(0, 0, 0, 0.8)',
                padding: 12,
                titleFont: {
                    size: 13
                },
                bodyFont: {
                    size: 12
                }
            }
        }
    };
}

/**
 * Assess proficiency using radar chart
 */
function assessProficiency(skill, level, target) {
    const gap = Math.max(0, target - level);
    const percentage = (level / target) * 100;
    
    return {
        skill: skill,
        currentLevel: level,
        targetLevel: target,
        gapScore: gap,
        progressPercentage: Math.round(percentage)
    };
}

/**
 * Compare multiple students' skills
 */
function compareStudentSkills(studentArray) {
    const skillNames = [];
    const datasets = [];
    
    studentArray.forEach((student, index) => {
        datasets.push({
            label: student.name,
            data: student.proficiencies,
            borderColor: ['#667eea', '#f093fb', '#43e97b', '#4facfe'][index],
            backgroundColor: [`rgba(102, 126, 234, 0.1)`, `rgba(240, 147, 251, 0.1)`, `rgba(67, 233, 123, 0.1)`, `rgba(79, 172, 254, 0.1)`][index],
            borderWidth: 2
        });
    });
    
    return {
        labels: studentArray[0].skills || [],
        datasets: datasets
    };
}

// Export for module usage
if (typeof module !== 'undefined' && module.exports) {
    module.exports = {
        createRadarChartData,
        formatRadarChartOptions,
        assessProficiency,
        compareStudentSkills
    };
}
