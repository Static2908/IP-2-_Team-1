// Skill Mapping Functions

// Sample skill mapping data
const skillMappingData = {
    'Java': {
        category: 'Programming',
        relatedSkills: ['Python', 'Data Structures', 'System Design'],
        learningPath: ['Object-Oriented Programming', 'Collections Framework', 'Concurrency']
    },
    'Python': {
        category: 'Programming',
        relatedSkills: ['Java', 'Data Science', 'Machine Learning'],
        learningPath: ['Core Syntax', 'Libraries', 'Advanced Python']
    },
    'Web Development': {
        category: 'Frontend',
        relatedSkills: ['JavaScript', 'CSS', 'HTML'],
        learningPath: ['HTML Basics', 'CSS Styling', 'JavaScript DOM']
    },
    'Database Design': {
        category: 'Backend',
        relatedSkills: ['SQL', 'System Design', 'Data Structures'],
        learningPath: ['Normalization', 'Query Optimization', 'Advanced SQL']
    },
    'Machine Learning': {
        category: 'AI/ML',
        relatedSkills: ['Python', 'Statistics', 'Data Science'],
        learningPath: ['Algorithms', 'Model Training', 'Neural Networks']
    }
};

// Get skill information
function getSkillInfo(skillName) {
    return skillMappingData[skillName] || null;
}

// Get related skills
function getRelatedSkills(skillName) {
    const skill = getSkillInfo(skillName);
    return skill ? skill.relatedSkills : [];
}

// Get learning path for a skill
function getLearningPath(skillName) {
    const skill = getSkillInfo(skillName);
    return skill ? skill.learningPath : [];
}

// Calculate skill compatibility
function calculateCompatibility(skill1, skill2) {
    const relatedSkills = getRelatedSkills(skill1);
    return relatedSkills.includes(skill2);
}

// Get skill recommendations based on proficiency
function getSkillRecommendations(currentSkills) {
    const recommendations = new Set();
    
    currentSkills.forEach(skill => {
        const relatedSkills = getRelatedSkills(skill);
        relatedSkills.forEach(related => {
            if (!currentSkills.includes(related)) {
                recommendations.add(related);
            }
        });
    });
    
    return Array.from(recommendations);
}

// Display skill information in UI
function displaySkillInfo(skillName) {
    const skillInfo = getSkillInfo(skillName);
    if (skillInfo) {
        console.log('Skill:', skillName);
        console.log('Category:', skillInfo.category);
        console.log('Related Skills:', skillInfo.relatedSkills);
        console.log('Learning Path:', skillInfo.learningPath);
    }
}

// Add skill to user's profile
function addSkillToProfile(skillName, proficiencyLevel) {
    const skillData = {
        name: skillName,
        proficiencyLevel: proficiencyLevel,
        dateAdded: new Date().toISOString(),
        learningPath: getLearningPath(skillName)
    };
    
    console.log('Skill added to profile:', skillData);
    return skillData;
}

// Calculate skill gap between current and target level
function calculateSkillGap(skillName, currentLevel, targetLevel) {
    return Math.max(0, targetLevel - currentLevel);
}

// Get next learning milestone
function getNextMilestone(skillName, currentLevel) {
    const path = getLearningPath(skillName);
    const nextIndex = Math.min(currentLevel, path.length - 1);
    return path[nextIndex] || 'Advanced Topics';
}

// Export functions for use in other modules
if (typeof module !== 'undefined' && module.exports) {
    module.exports = {
        getSkillInfo,
        getRelatedSkills,
        getLearningPath,
        calculateCompatibility,
        getSkillRecommendations,
        displaySkillInfo,
        addSkillToProfile,
        calculateSkillGap,
        getNextMilestone
    };
}
