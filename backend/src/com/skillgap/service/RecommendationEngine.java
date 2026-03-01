package com.skillgap.service;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

public class RecommendationEngine {

    public static List<String> generateRecommendations(
            String skillName,
            int currentLevel,
            int actualLevel,
            double gapScore,
            String targetJob) {

        Set<String> recs = new LinkedHashSet<>();

        // ==============================
        // 1) GAP PRIORITY LOGIC
        // ==============================
        if (gapScore <= -2) {
            recs.add("Revisit core fundamentals of " + skillName + " through structured foundational courses.");
        } else if (gapScore == -1) {
            recs.add("Strengthen practical understanding of " + skillName + " with guided practice.");
        } else if (gapScore >= 1) {
            recs.add("You are underestimating your ability in " + skillName + ". Consider advanced challenges.");
        } else {
            recs.add("Your self-assessment in " + skillName + " is accurate. Focus on consistency.");
        }

        // ==============================
        // 2) SKILL LEVEL PATH
        // ==============================
        if (actualLevel <= 2) {
            recs.add("Follow a beginner-to-intermediate roadmap for " + skillName + ".");
        } else if (actualLevel == 3) {
            recs.add("Build real-world projects to deepen your " + skillName + " expertise.");
        } else if (actualLevel >= 4) {
            recs.add("Pursue advanced system-level or architecture-level work in " + skillName + ".");
        }

        // ==============================
        // 3) JOB-CENTRIC LOGIC
        // ==============================
        if (targetJob != null) {
            String tj = targetJob.toLowerCase();

            if (tj.contains("accenture")) {
                recs.add("Strengthen DSA, SQL, and system design for consulting roles.");
            }
            if (tj.contains("google")) {
                recs.add("Focus on advanced DSA, algorithms, and competitive coding.");
            }
            if (tj.contains("machine learning")) {
                recs.add("Develop strong foundations in Python, ML models, and statistics.");
            }
            if (tj.contains("cloud")) {
                recs.add("Pursue AWS/Azure certification and distributed systems knowledge.");
            }
        }

        return new ArrayList<>(recs);
    }
}
