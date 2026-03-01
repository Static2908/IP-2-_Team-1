package com.skillgap.service;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class RecommendationEngine {

    public static Map<String, List<String>> generateRecommendations(
            String skillName,
            int currentLevel,
            int actualLevel,
            double gapScore,
            String targetJob) {

        Set<String> skillRecs = new LinkedHashSet<>();
        Set<String> jobRecs = new LinkedHashSet<>();

        // ==============================
        // skill recommendations (gap + level)
        // ==============================
        if (gapScore <= -2) {
            skillRecs.add("Foundational course for " + skillName);
        } else if (gapScore == -1) {
            skillRecs.add("Practice + intermediate projects for " + skillName);
        } else if (gapScore >= 1) {
            skillRecs.add("Advanced certification or leadership track for " + skillName);
        }

        if (actualLevel <= 2) {
            skillRecs.add("Beginner roadmap for " + skillName);
        } else if (actualLevel == 3) {
            skillRecs.add("Intermediate projects for " + skillName);
        } else if (actualLevel >= 4) {
            skillRecs.add("Advanced system-level or architecture-level projects for " + skillName);
        }

        // ==============================
        // job-centric recommendations
        // ==============================
        if (targetJob != null) {
            String tj = targetJob.toLowerCase();
            if (tj.contains("accenture")) {
                jobRecs.add("DSA + SQL + system design");
            }
            if (tj.contains("google")) {
                jobRecs.add("DSA + algorithms + competitive coding");
            }
            if (tj.contains("ml")) {
                jobRecs.add("Python + Machine Learning + statistics");
            }
            if (tj.contains("cloud")) {
                jobRecs.add("AWS/Azure certification path");
            }
        }

        Map<String, List<String>> result = new LinkedHashMap<>();
        result.put("skillRecommendations", new ArrayList<>(skillRecs));
        result.put("jobRecommendations", new ArrayList<>(jobRecs));
        return result;
    }
}
