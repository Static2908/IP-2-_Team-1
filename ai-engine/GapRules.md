# Skill Gap Analysis Rules and Algorithms

## Overview
This document describes the rules and algorithms used for skill gap analysis and recommendations.

## 1. Skill Gap Calculation

### Formula
```
Gap Score = Target Level - Current Level
Gap Percentage = (Gap Score / 5) * 100
```

### Proficiency Levels (1-5)
- **Level 1**: Beginner - Basic understanding
- **Level 2**: Basic - Can perform simple tasks
- **Level 3**: Intermediate - Can handle moderate complexity
- **Level 4**: Advanced - Expert-level knowledge
- **Level 5**: Expert - Mastery of the skill

## 2. Priority Classification

| Gap Score | Priority | Action |
|-----------|----------|--------|
| >= 3.0 | CRITICAL | Immediate attention required |
| 2.0 - 2.9 | HIGH | Should be addressed soon |
| 1.0 - 1.9 | MEDIUM | Consider for development |
| < 1.0 | LOW | Optional improvement |

## 3. Learning Time Estimation

**Base Formula**: `Estimated Days = Gap Score × 10`

Adjustments based on skill category:
- Programming skills: ×1.0
- Soft skills: ×0.8
- Specialized skills: ×1.2

## 4. Recommendation Rules

### Rule 1: Related Skills
If a student has low proficiency in skill A and high demand for skill B (where B depends on A), recommend improving A first.

### Rule 2: Foundation Skills
Critical foundation skills (Data Structures, Algorithms) should be prioritized if gap score >= 2.

### Rule 3: Career Path Alignment
Recommendations should align with student's:
- Current semester/level
- Department
- Demonstrated interests

## 5. Assessment Scoring

### Quiz Score Calculation
```
Score = (Correct Answers / Total Questions) × 100
```

### Proficiency Update Rule
```
New Proficiency = (Current Proficiency × 0.6) + (Assessment Performance × 0.4)
```

## 6. Skill Recommendations Algorithm

1. **Identify gaps**: Calculate gap score for each skill
2. **Prioritize**: Sort by priority (CRITICAL → LOW)
3. **Generate text**: Create specific, actionable recommendations
4. **Estimate effort**: Calculate time and resources needed
5. **Suggest resources**: Recommend courses and materials

## 7. Performance Metrics

### Student Progress Indicator
```
Progress = (Improvements / Total Gaps) × 100
```

### Overall Skill Index
```
Skill Index = (Total Proficiency / Number of Skills) × 100
```

### Gap Closure Rate
```
Gap Closure Rate = (Initial Gap - Current Gap) / Time Period
```

## 8. Recommendation Threshold

Recommendations are generated when:
- Gap Score >= 1.0
- Student has taken at least 1 assessment
- Current proficiency < 3

## 9. Update Frequency

- Skill gap analysis: After each assessment
- Recommendations: Daily (or manual trigger)
- Proficiency levels: After assessment completion

## 10. Constraints and Validations

1. Proficiency levels must be between 1-5
2. Target level must be >= current level
3. Gap score cannot be negative
4. Assessment completion time must be logged
5. All inputs must be validated before processing
