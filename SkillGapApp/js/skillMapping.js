// Maps skill levels to descriptive text (frontend/js/skillMapping.js)

function levelToText(level) {
    switch (level) {
        case 1: return "Beginner";
        case 2: return "Intermediate";
        case 3: return "Advanced";
        case 4: return "Expert";
        default: return "Unknown";
    }
}