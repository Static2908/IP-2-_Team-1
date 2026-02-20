package com.skillgap.ai;

import java.util.*;

public class SkillGapCalculator {
    
    /**
     * Calculate skill gap for a student
     */
    public static SkillGap calculateGap(int currentLevel, int targetLevel) {
        if (targetLevel < currentLevel) {
            targetLevel = currentLevel;
        }
        
        double gapScore = targetLevel - currentLevel;
        double gapPercentage = (gapScore / 5.0) * 100;
        
        return new SkillGap(currentLevel, targetLevel, gapScore, gapPercentage);
    }
    
    /**
     * Analyze all skill gaps for a student
     */
    public static List<SkillGap> analyzeAllGaps(Map<String, Integer> currentSkills, Map<String, Integer> targetSkills) {
        List<SkillGap> gaps = new ArrayList<>();
        
        for (String skill : targetSkills.keySet()) {
            int current = currentSkills.getOrDefault(skill, 0);
            int target = targetSkills.get(skill);
            SkillGap gap = calculateGap(current, target);
            gaps.add(gap);
        }
        
        // Sort by gap score (descending)
        gaps.sort((g1, g2) -> Double.compare(g2.getGapScore(), g1.getGapScore()));
        
        return gaps;
    }
    
    /**
     * Calculate overall skill gap score
     */
    public static double calculateOverallGap(List<SkillGap> gaps) {
        if (gaps.isEmpty()) return 0;
        
        double totalGap = gaps.stream()
                .mapToDouble(SkillGap::getGapScore)
                .sum();
        
        return totalGap / gaps.size();
    }
    
    /**
     * Determine learning priority based on gap score
     */
    public static String determinePriority(double gapScore) {
        if (gapScore >= 3.0) {
            return "CRITICAL";
        } else if (gapScore >= 2.0) {
            return "HIGH";
        } else if (gapScore >= 1.0) {
            return "MEDIUM";
        } else {
            return "LOW";
        }
    }
    
    /**
     * Calculate skill progression time estimate (in days)
     */
    public static int estimateLearningTime(double gapScore) {
        // Base estimate: 10 days per gap point
        return (int) Math.ceil(gapScore * 10);
    }
    
    /**
     * Inner class to represent a skill gap
     */
    public static class SkillGap {
        private int currentLevel;
        private int targetLevel;
        private double gapScore;
        private double gapPercentage;
        
        public SkillGap(int currentLevel, int targetLevel, double gapScore, double gapPercentage) {
            this.currentLevel = currentLevel;
            this.targetLevel = targetLevel;
            this.gapScore = gapScore;
            this.gapPercentage = gapPercentage;
        }
        
        // Getters
        public int getCurrentLevel() { return currentLevel; }
        public int getTargetLevel() { return targetLevel; }
        public double getGapScore() { return gapScore; }
        public double getGapPercentage() { return gapPercentage; }
    }
}
