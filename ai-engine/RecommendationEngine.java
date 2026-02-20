package com.skillgap.ai;

import java.util.*;

public class RecommendationEngine {
    
    /**
     * Generate learning recommendations based on skill gaps
     */
    public static List<Recommendation> generateRecommendations(Map<String, Integer> skillGaps, Map<String, String> skillCategories) {
        List<Recommendation> recommendations = new ArrayList<>();
        
        // Sort skills by gap score (descending)
        List<Map.Entry<String, Integer>> sortedGaps = skillGaps.entrySet().stream()
                .sorted((a, b) -> b.getValue().compareTo(a.getValue()))
                .toList();
        
        for (Map.Entry<String, Integer> entry : sortedGaps) {
            String skillName = entry.getKey();
            int gapLevel = entry.getValue();
            String category = skillCategories.getOrDefault(skillName, "General");
            
            String recommendationText = generateRecommendationText(skillName, gapLevel, category);
            int priority = calculatePriority(gapLevel);
            long estimatedDays = estimateLearningTime(gapLevel);
            
            recommendations.add(new Recommendation(skillName, recommendationText, priority, estimatedDays));
        }
        
        return recommendations;
    }
    
    /**
     * Generate specific recommendation text based on skill and gap level
     */
    private static String generateRecommendationText(String skill, int gapLevel, String category) {
        String baseText = "Focus on ";
        String specificText = "";
        
        switch (skill.toLowerCase()) {
            case "java":
                if (gapLevel >= 3) {
                    specificText = "advanced Java concepts including multithreading, JVM internals, and design patterns";
                } else {
                    specificText = "core Java fundamentals and object-oriented programming principles";
                }
                break;
            case "python":
                if (gapLevel >= 3) {
                    specificText = "advanced Python with data science libraries like NumPy, Pandas, and Scikit-learn";
                } else {
                    specificText = "Python fundamentals and basic data structures";
                }
                break;
            case "machine learning":
                if (gapLevel >= 3) {
                    specificText = "deep learning frameworks like TensorFlow and PyTorch for advanced ML";
                } else {
                    specificText = "ML algorithms and model evaluation techniques";
                }
                break;
            case "web development":
                specificText = "responsive web design, frontend frameworks, and accessibility standards";
                break;
            case "database design":
                if (gapLevel >= 3) {
                    specificText = "advanced SQL, query optimization, and database architecture";
                } else {
                    specificText = "relational database design and normalization techniques";
                }
                break;
            default:
                specificText = "skill development through online courses and hands-on projects";
        }
        
        return baseText + specificText + " to improve your proficiency.";
    }
    
    /**
     * Calculate priority based on gap level
     */
    private static int calculatePriority(int gapLevel) {
        if (gapLevel >= 4) return 1;      // CRITICAL
        if (gapLevel >= 3) return 2;      // HIGH
        if (gapLevel >= 2) return 3;      // MEDIUM
        return 4;                          // LOW
    }
    
    /**
     * Estimate learning time in days
     */
    private static long estimateLearningTime(int gapLevel) {
        return (long) gapLevel * 15;  // 15 days per gap level
    }
    
    /**
     * Get course recommendations for a skill
     */
    public static List<String> getRecommendedCourses(String skill) {
        Map<String, List<String>> courseMap = new HashMap<>();
        courseMap.put("java", Arrays.asList(
                "Complete Java Programming Masterclass",
                "Java Design Patterns",
                "Advanced Java Concurrency"
        ));
        courseMap.put("python", Arrays.asList(
                "Python for Data Science",
                "Python Advanced Topics",
                "Machine Learning with Python"
        ));
        courseMap.put("machine learning", Arrays.asList(
                "Introduction to Machine Learning",
                "Deep Learning Specialization",
                "Applied Machine Learning"
        ));
        
        return courseMap.getOrDefault(skill.toLowerCase(), new ArrayList<>());
    }
    
    /**
     * Get recommended resources for skill improvement
     */
    public static List<String> getRecommendedResources(String skill) {
        Map<String, List<String>> resourceMap = new HashMap<>();
        resourceMap.put("java", Arrays.asList(
                "Official Java Documentation",
                "LeetCode - Java Problems",
                "HackerRank - Java Challenges"
        ));
        resourceMap.put("python", Arrays.asList(
                "Python Official Tutorial",
                "Real Python Articles",
                "CodeWars - Python Katas"
        ));
        
        return resourceMap.getOrDefault(skill.toLowerCase(), new ArrayList<>());
    }
    
    /**
     * Inner class to represent a recommendation
     */
    public static class Recommendation {
        private String skillName;
        private String text;
        private int priority;
        private long estimatedDays;
        
        public Recommendation(String skillName, String text, int priority, long estimatedDays) {
            this.skillName = skillName;
            this.text = text;
            this.priority = priority;
            this.estimatedDays = estimatedDays;
        }
        
        // Getters
        public String getSkillName() { return skillName; }
        public String getText() { return text; }
        public int getPriority() { return priority; }
        public long getEstimatedDays() { return estimatedDays; }
        
        @Override
        public String toString() {
            return "[" + priority + "] " + skillName + ": " + text + " (Est. " + estimatedDays + " days)";
        }
    }
}
