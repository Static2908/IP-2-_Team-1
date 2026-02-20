-- Query 1: Get student profile with skills
SELECT 
    s.student_id,
    s.first_name,
    s.last_name,
    s.department,
    sk.skill_name,
    ss.proficiency_level,
    ss.assessed_date
FROM students s
JOIN student_skills ss ON s.student_id = ss.student_id
JOIN skills sk ON ss.skill_id = sk.skill_id
ORDER BY s.student_id, sk.skill_name;

-- Query 2: Get skill gap analysis for a student
SELECT 
    s.student_id,
    s.first_name,
    s.last_name,
    sk.skill_name,
    sga.current_level,
    sga.target_level,
    sga.gap_score,
    sga.analysis_date
FROM students s
JOIN skill_gap_analysis sga ON s.student_id = sga.student_id
JOIN skills sk ON sga.skill_id = sk.skill_id
ORDER BY sga.gap_score DESC;

-- Query 3: Get student assessment results
SELECT 
    s.student_id,
    s.first_name,
    s.last_name,
    a.assessment_name,
    ar.score,
    ar.percentage,
    ar.completion_time,
    ar.taken_at
FROM students s
JOIN assessment_results ar ON s.student_id = ar.student_id
JOIN assessments a ON ar.assessment_id = a.assessment_id
ORDER BY s.student_id, ar.taken_at DESC;

-- Query 4: Get recommendations for a student
SELECT 
    s.student_id,
    s.first_name,
    s.last_name,
    sk.skill_name,
    r.recommendation_text,
    r.priority,
    r.created_at
FROM students s
JOIN recommendations r ON s.student_id = r.student_id
JOIN skills sk ON r.skill_id = sk.skill_id
ORDER BY r.priority ASC, s.student_id;

-- Query 5: Get students with highest skill gaps
SELECT 
    s.student_id,
    s.first_name,
    s.last_name,
    ROUND(AVG(sga.gap_score), 2) as avg_gap_score,
    COUNT(sga.skill_id) as gap_count
FROM students s
LEFT JOIN skill_gap_analysis sga ON s.student_id = sga.student_id
GROUP BY s.student_id, s.first_name, s.last_name
ORDER BY avg_gap_score DESC;

-- Query 6: Get skill assessment statistics
SELECT 
    sk.skill_name,
    COUNT(ar.result_id) as total_assessments,
    ROUND(AVG(ar.percentage), 2) as avg_percentage,
    MAX(ar.percentage) as max_percentage,
    MIN(ar.percentage) as min_percentage
FROM skills sk
LEFT JOIN assessments a ON sk.skill_id = a.skill_id
LEFT JOIN assessment_results ar ON a.assessment_id = ar.assessment_id
GROUP BY sk.skill_id, sk.skill_name
ORDER BY avg_percentage DESC;

-- Query 7: Get students needing urgent skill development
SELECT DISTINCT
    s.student_id,
    s.first_name,
    s.last_name,
    sk.skill_name,
    sga.gap_score,
    r.recommendation_text
FROM students s
JOIN skill_gap_analysis sga ON s.student_id = sga.student_id
JOIN skills sk ON sga.skill_id = sk.skill_id
JOIN recommendations r ON s.student_id = r.student_id AND sk.skill_id = r.skill_id
WHERE sga.gap_score >= 2.5 AND r.priority = 1
ORDER BY sga.gap_score DESC, s.student_id;

-- Query 8: Get department-wise skill proficiency report
SELECT 
    s.department,
    sk.skill_name,
    ROUND(AVG(ss.proficiency_level), 2) as avg_proficiency,
    COUNT(ss.student_skill_id) as student_count
FROM students s
JOIN student_skills ss ON s.student_id = ss.student_id
JOIN skills sk ON ss.skill_id = sk.skill_id
GROUP BY s.department, sk.skill_id, sk.skill_name
ORDER BY s.department, avg_proficiency DESC;
