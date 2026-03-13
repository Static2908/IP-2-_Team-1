package com.skillgap.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class RecommendationEngine {

    public static class SkillContext {
        private final int currentLevel;
        private final int actualLevel;
        private final double gapScore;

        public SkillContext(int currentLevel, int actualLevel, double gapScore) {
            this.currentLevel = currentLevel;
            this.actualLevel = actualLevel;
            this.gapScore = gapScore;
        }

        public int getCurrentLevel() {
            return currentLevel;
        }

        public int getActualLevel() {
            return actualLevel;
        }

        public double getGapScore() {
            return gapScore;
        }
    }

    /**
     * CMMI company eligibility result for a student.
     */
    public static class CMMIEligibility {
        public final String cmmiLevel;
        public final String status;
        public final List<String> companies;
        public final String description;
        public final String badgeColor;

        public CMMIEligibility(String cmmiLevel, String status, List<String> companies,
                String description, String badgeColor) {
            this.cmmiLevel = cmmiLevel;
            this.status = status;
            this.companies = companies;
            this.description = description;
            this.badgeColor = badgeColor;
        }
    }

    /**
     * Returns CMMI company eligibility tier based on the student's average assessed
     * skill level.
     * Levels 1-5 map to progressively higher-tier CMMI-certified organizations.
     */
    public static CMMIEligibility generateCMMIEligibility(double avgSkillLevel) {
        if (avgSkillLevel < 1.0) {
            return new CMMIEligibility(
                    "No Data",
                    "Complete assessments to determine eligibility",
                    Arrays.asList("Take at least one skill assessment first"),
                    "Complete at least one skill assessment to calculate your CMMI company eligibility.",
                    "gray");
        } else if (avgSkillLevel < 2.0) {
            return new CMMIEligibility(
                    "Not Yet Eligible",
                    "Below Entry Threshold",
                    Arrays.asList("Internships at small firms", "Entry-level freelance projects",
                            "College placement opportunities"),
                    "Build your skills to an average level of 2.0+ across all assessed skills to qualify for CMMI-certified organizations.",
                    "gray");
        } else if (avgSkillLevel < 2.5) {
            return new CMMIEligibility(
                    "CMMI Level 2",
                    "Entry Level Eligible",
                    Arrays.asList("Small IT service firms", "Local software development companies",
                            "Tech startups with managed processes"),
                    "You qualify for entry-level roles at CMMI Level 2 organizations. Improve core skills to unlock Level 3 companies.",
                    "blue");
        } else if (avgSkillLevel < 3.0) {
            return new CMMIEligibility(
                    "CMMI Level 3 (Fresher)",
                    "Fresher Roles Eligible",
                    Arrays.asList("TCS (Trainee)", "Infosys (Fresher)", "Wipro (Fresher)",
                            "Capgemini", "L&T Infotech"),
                    "You qualify for fresher and trainee roles at large CMMI Level 3 IT service companies.",
                    "teal");
        } else if (avgSkillLevel < 3.5) {
            return new CMMIEligibility(
                    "CMMI Level 3",
                    "Junior / Mid-Level Eligible",
                    Arrays.asList("TCS", "Infosys", "Wipro", "Cognizant", "HCL Technologies", "Mphasis"),
                    "You are eligible for junior to mid-level developer roles at major CMMI Level 3 organizations.",
                    "green");
        } else if (avgSkillLevel < 4.0) {
            return new CMMIEligibility(
                    "CMMI Level 4-5 (Entry)",
                    "Senior Roles Eligible",
                    Arrays.asList("HCL Technologies", "Tech Mahindra", "Mphasis",
                            "Hexaware", "Persistent Systems", "KPIT"),
                    "You are competitive for senior developer positions at CMMI Level 4-5 enterprises.",
                    "orange");
        } else if (avgSkillLevel < 4.5) {
            return new CMMIEligibility(
                    "CMMI Level 5",
                    "Top Tier Eligible",
                    Arrays.asList("Accenture", "IBM", "Capgemini", "DXC Technology",
                            "Deloitte Digital", "Infosys BPM"),
                    "You qualify for senior software engineer and lead roles at top-tier CMMI Level 5 global organizations.",
                    "purple");
        } else {
            return new CMMIEligibility(
                    "CMMI Level 5 (Elite)",
                    "Elite Tier - Lead / Architect",
                    Arrays.asList("Accenture", "IBM Global Services", "McKinsey Digital",
                            "BCG Gamma", "Top-tier MNCs & Product Companies"),
                    "Your skill profile qualifies for technical lead, architect, and principal engineer roles at elite global organizations.",
                    "gold");
        }
    }

    /**
     * Generate grouped skill-specific recommendations for multiple skills.
     * Returns a map where key = skill name, value = list of unique recommendations.
     * Maximum 5 recommendations per skill.
     */
    public static Map<String, List<String>> generateRecommendations(
            Map<String, SkillContext> skillContexts) {

        Map<String, List<String>> groupedRecommendations = new LinkedHashMap<>();
        Set<String> globalDedup = new LinkedHashSet<>();

        for (Map.Entry<String, SkillContext> entry : skillContexts.entrySet()) {
            String skillName = entry.getKey();
            SkillContext context = entry.getValue();

            Set<String> skillRecs = new LinkedHashSet<>();

            // Generate level-appropriate recommendations
            addLevelBasedRecommendations(skillRecs, skillName, context.getActualLevel());

            // Add gap-based learning path
            addGapBasedRecommendation(skillRecs, skillName, context.getCurrentLevel(), context.getActualLevel());

            // Convert to list with global deduplication, max 5
            List<String> cleaned = new ArrayList<>();
            for (String rec : skillRecs) {
                String normalized = rec.trim().toLowerCase();
                if (!globalDedup.contains(normalized)) {
                    globalDedup.add(normalized);
                    cleaned.add(rec);
                    if (cleaned.size() >= 5) {
                        break;
                    }
                }
            }

            if (cleaned.isEmpty()) {
                cleaned.add("Practice " + skillName + " with guided exercises and small projects");
            }

            groupedRecommendations.put(skillName, cleaned);
        }

        return groupedRecommendations;
    }

    /**
     * Generate job/career recommendations based on target role.
     * Returns actionable suggestions for the specified career path.
     */
    public static List<String> generateJobRecommendations(String targetJob) {
        Set<String> jobRecs = new LinkedHashSet<>();

        if (targetJob == null || targetJob.trim().isEmpty()) {
            return new ArrayList<>(jobRecs);
        }

        String role = targetJob.toLowerCase();

        // Backend Developer
        if (role.contains("backend") || role.contains("server")) {
            jobRecs.add("Build RESTful APIs with proper authentication and error handling");
            jobRecs.add("Learn system design patterns for scalable backend architecture");
            jobRecs.add("Practice database optimization and query performance tuning");
        }

        // Full Stack Developer
        if (role.contains("full stack") || role.contains("fullstack")) {
            jobRecs.add("Build end-to-end applications with frontend and backend integration");
            jobRecs.add("Learn deployment strategies and CI/CD pipelines");
            jobRecs.add("Master both client and server-side state management");
        }

        // Data Scientist / Data Analyst
        if (role.contains("data") && (role.contains("scientist") || role.contains("analyst"))) {
            jobRecs.add("Master data analysis libraries like Pandas, NumPy, and visualization tools");
            jobRecs.add("Build end-to-end data pipelines with cleaning and transformation steps");
            jobRecs.add("Create portfolio projects demonstrating statistical analysis and insights");
        }

        // Machine Learning Engineer
        if (role.contains("ml") || role.contains("machine learning") || role.contains("ai")) {
            jobRecs.add("Implement and compare multiple ML algorithms on real datasets");
            jobRecs.add("Learn model deployment, monitoring, and retraining strategies");
            jobRecs.add("Practice feature engineering and model optimization techniques");
        }

        // Cloud Engineer / DevOps
        if (role.contains("cloud") || role.contains("devops")) {
            jobRecs.add("Deploy applications to cloud platforms (AWS, Azure, or GCP)");
            jobRecs.add("Learn infrastructure as code with tools like Terraform or CloudFormation");
            jobRecs.add("Implement monitoring, logging, and automated scaling solutions");
        }

        // Frontend Developer
        if (role.contains("frontend") || role.contains("front end")) {
            jobRecs.add("Master modern JavaScript frameworks like React, Vue, or Angular");
            jobRecs.add("Build responsive, accessible web applications following best practices");
            jobRecs.add("Learn state management, routing, and API integration patterns");
        }

        // Software Engineer (Generic)
        if (role.contains("software") || role.contains("developer") || role.contains("engineer")) {
            if (jobRecs.isEmpty()) {
                jobRecs.add("Practice data structures and algorithms for technical interviews");
                jobRecs.add("Build projects showcasing clean code and design patterns");
                jobRecs.add("Contribute to open source projects to gain collaborative experience");
            }
        }

        // Default fallback
        if (jobRecs.isEmpty()) {
            jobRecs.add("Align your learning with the target role's key technical requirements");
            jobRecs.add("Build portfolio projects that demonstrate skills needed for " + targetJob);
        }

        return new ArrayList<>(jobRecs);
    }

    /**
     * Add level-appropriate recommendations based on actual skill level (1-5).
     */
    private static void addLevelBasedRecommendations(Set<String> out, String skillName, int actualLevel) {
        String skill = skillName.trim();

        switch (actualLevel) {
            case 1: // Beginner
                addBeginnerRecommendations(out, skill);
                break;
            case 2: // Novice
                addNoviceRecommendations(out, skill);
                break;
            case 3: // Intermediate
                addIntermediateRecommendations(out, skill);
                break;
            case 4: // Advanced
                addAdvancedRecommendations(out, skill);
                break;
            case 5: // Expert
                addExpertRecommendations(out, skill);
                break;
            default:
                out.add("Practice " + skill + " fundamentals with guided exercises");
        }
    }

    /**
     * Level 1 - Beginner: Focus on fundamentals and basic concepts.
     */
    private static void addBeginnerRecommendations(Set<String> out, String skill) {
        out.add("Learn core syntax and fundamental concepts of " + skill);
        out.add("Complete beginner tutorials and coding exercises in " + skill);
        out.add("Build a simple project like a calculator or to-do list using " + skill);
        out.add("Follow structured beginner courses with hands-on practice");
    }

    /**
     * Level 2 - Novice: Structured learning and small projects.
     */
    private static void addNoviceRecommendations(Set<String> out, String skill) {
        out.add("Practice intermediate exercises and challenges in " + skill);
        out.add("Build small practical projects using " + skill + " core features");
        out.add("Follow a beginner-to-intermediate learning path for " + skill);
        out.add("Read documentation and implement examples for " + skill);
    }

    /**
     * Level 3 - Intermediate: Applied projects and deeper understanding.
     */
    private static void addIntermediateRecommendations(Set<String> out, String skill) {
        out.add("Build real-world applications using " + skill + " best practices");
        out.add("Explore advanced libraries, frameworks, and tools in " + skill);
        out.add("Contribute to small open source projects using " + skill);
        out.add("Implement design patterns and architectural concepts in " + skill);
    }

    /**
     * Level 4 - Advanced: Architecture, optimization, and mentoring.
     */
    private static void addAdvancedRecommendations(Set<String> out, String skill) {
        out.add("Implement scalable, production-ready applications using " + skill);
        out.add("Study design patterns, best practices, and architectural principles in " + skill);
        out.add("Optimize performance, memory usage, and efficiency in " + skill + " projects");
        out.add("Mentor junior developers and conduct code reviews for " + skill);
    }

    /**
     * Level 5 - Expert: Leadership, system design, and specialization.
     */
    private static void addExpertRecommendations(Set<String> out, String skill) {
        out.add("Design large-scale systems and architect enterprise solutions using " + skill);
        out.add("Lead technical discussions and establish standards for " + skill + " in your team");
        out.add("Mentor other developers and share expertise through talks or articles on " + skill);
        out.add("Contribute to " + skill + " community through open source leadership or innovation");
    }

    /**
     * Add gap-based guidance using claimed level vs assessed level.
     * A negative delta means the assessed level is below the claimed level and
     * requires remediation, not advanced guidance.
     */
    private static void addGapBasedRecommendation(Set<String> out, String skillName, int claimedLevel,
            int actualLevel) {
        int delta = actualLevel - claimedLevel;

        if (delta <= -2) {
            out.add("Rebuild your " + skillName
                    + " foundation with a structured roadmap before moving to harder topics");
        } else if (delta == -1) {
            out.add("Focus on practice problems and guided projects to close the gap in " + skillName);
        } else if (delta == 0) {
            out.add("Strengthen consistency in " + skillName + " with regular practice before moving up a level");
        } else {
            out.add("Your assessed level is ahead of your claimed level - take on more challenging " + skillName
                    + " projects");
        }
    }

    /**
     * Backward-compatible method for single skill recommendation.
     * Returns a map with "skillRecommendations" and "jobRecommendations" keys.
     */
    public static Map<String, List<String>> generateRecommendations(
            String skillName,
            int currentLevel,
            int actualLevel,
            double gapScore,
            String targetJob) {
        Map<String, List<String>> result = new LinkedHashMap<>();

        Map<String, SkillContext> oneSkill = new LinkedHashMap<>();
        oneSkill.put(skillName, new SkillContext(currentLevel, actualLevel, gapScore));

        Map<String, List<String>> grouped = generateRecommendations(oneSkill);
        List<String> forSkill = grouped.getOrDefault(skillName, new ArrayList<>());

        result.put("skillRecommendations", forSkill);
        result.put("jobRecommendations", generateJobRecommendations(targetJob));
        return result;
    }
}
