-- Fix missing assessments for Machine Learning, Cloud Computing, and System Design
-- This file adds assessment records for skills 6, 7, and 8 to prevent database errors

-- Insert assessment for Machine Learning (skill_id = 6)
INSERT INTO assessments (assessment_id, assessment_name, skill_id, total_questions, passing_score) VALUES
(seq_assessments.NEXTVAL, 'Machine Learning Fundamentals', 6, 20, 70);

-- Insert assessment for Cloud Computing (skill_id = 7)
INSERT INTO assessments (assessment_id, assessment_name, skill_id, total_questions, passing_score) VALUES
(seq_assessments.NEXTVAL, 'Cloud Computing Basics', 7, 20, 65);

-- Insert assessment for System Design (skill_id = 8)
INSERT INTO assessments (assessment_id, assessment_name, skill_id, total_questions, passing_score) VALUES
(seq_assessments.NEXTVAL, 'System Design Principles', 8, 20, 70);

COMMIT;
