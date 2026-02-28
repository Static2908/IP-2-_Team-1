package com.skillgap.util;

public class InputValidator {

    /**
     * Validate email format
     */
    public static boolean isValidEmail(String email) {
        return email != null && email.matches("^[A-Za-z0-9+_.-]+@(.+)$");
    }

    /**
     * Validate username (3-50 characters)
     */
    public static boolean isValidUsername(String username) {
        return username != null && username.length() >= 3 && username.length() <= 50;
    }

    /**
     * Validate password (minimum 6 characters)
     */
    public static boolean isValidPassword(String password) {
        return password != null && password.length() >= 6;
    }

    /**
     * Validate name (not empty, proper length)
     */
    public static boolean isValidName(String name) {
        return name != null && !name.trim().isEmpty() && name.length() <= 100;
    }

    /**
     * Validate CGPA (0-10, some institutions use 10-scale)
     */
    public static boolean isValidCGPA(double cgpa) {
        return cgpa >= 0 && cgpa <= 10;
    }

    /**
     * Validate semester (1-8)
     */
    public static boolean isValidSemester(int semester) {
        return semester >= 1 && semester <= 8;
    }

    /**
     * Validate proficiency level (1-5)
     */
    public static boolean isValidProficiencyLevel(int level) {
        return level >= 1 && level <= 5;
    }

    /**
     * Check for SQL injection attempts (basic protection)
     */
    public static boolean isSafe(String input) {
        if (input == null)
            return true;
        String[] dangerousPatterns = { "'", "\"", ";", "--", "/*", "*/", "xp_", "sp_", "drop", "insert", "delete",
                "update" };
        String lowerInput = input.toLowerCase();
        for (String pattern : dangerousPatterns) {
            if (lowerInput.contains(pattern)) {
                return false;
            }
        }
        return true;
    }

    /**
     * Sanitize input by removing dangerous characters
     */
    public static String sanitizeInput(String input) {
        if (input == null)
            return "";
        return input.replaceAll("[^a-zA-Z0-9@._-]", "");
    }

    /**
     * Validate department
     */
    public static boolean isValidDepartment(String department) {
        String[] validDepts = { "Computer Science", "Information Technology", "Software Engineering" };
        if (department == null)
            return false;
        for (String dept : validDepts) {
            if (dept.equals(department))
                return true;
        }
        return false;
    }
}
