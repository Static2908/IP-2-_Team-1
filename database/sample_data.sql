-- Insert sample users
INSERT INTO users (user_id, username, password_hash, email) VALUES
(seq_users.NEXTVAL, 'student1', '$2a$10$samplehash1', 'student1@example.com');
INSERT INTO users (user_id, username, password_hash, email) VALUES
(seq_users.NEXTVAL, 'student2', '$2a$10$samplehash2', 'student2@example.com');
INSERT INTO users (user_id, username, password_hash, email) VALUES
(seq_users.NEXTVAL, 'student3', '$2a$10$samplehash3', 'student3@example.com');
COMMIT;

-- Insert sample students
INSERT INTO students (student_id, user_id, first_name, last_name, department, semester, cgpa) VALUES
(seq_students.NEXTVAL, 1, 'John', 'Doe', 'Computer Science', 4, 3.5);
INSERT INTO students (student_id, user_id, first_name, last_name, department, semester, cgpa) VALUES
(seq_students.NEXTVAL, 2, 'Jane', 'Smith', 'Information Technology', 3, 3.8);
INSERT INTO students (student_id, user_id, first_name, last_name, department, semester, cgpa) VALUES
(seq_students.NEXTVAL, 3, 'Mike', 'Johnson', 'Computer Science', 5, 3.2);
COMMIT;

-- Insert sample skills
INSERT INTO skills (skill_id, skill_name, category, description) VALUES
(seq_skills.NEXTVAL, 'Java', 'Programming', 'Core Java programming language');
INSERT INTO skills (skill_id, skill_name, category, description) VALUES
(seq_skills.NEXTVAL, 'Python', 'Programming', 'Python programming for data science');
INSERT INTO skills (skill_id, skill_name, category, description) VALUES
(seq_skills.NEXTVAL, 'Web Development', 'Frontend', 'HTML, CSS, JavaScript web development');
INSERT INTO skills (skill_id, skill_name, category, description) VALUES
(seq_skills.NEXTVAL, 'Database Design', 'Backend', 'SQL and database design patterns');
INSERT INTO skills (skill_id, skill_name, category, description) VALUES
(seq_skills.NEXTVAL, 'Data Structures', 'Fundamentals', 'Core data structure algorithms');
INSERT INTO skills (skill_id, skill_name, category, description) VALUES
(seq_skills.NEXTVAL, 'Machine Learning', 'AI/ML', 'Machine learning algorithms and models');
INSERT INTO skills (skill_id, skill_name, category, description) VALUES
(seq_skills.NEXTVAL, 'Cloud Computing', 'DevOps', 'AWS, Azure cloud platforms');
INSERT INTO skills (skill_id, skill_name, category, description) VALUES
(seq_skills.NEXTVAL, 'System Design', 'Architecture', 'Distributed systems and architecture');
COMMIT;

-- Insert sample student skills
INSERT INTO student_skills (student_skill_id, student_id, skill_id, proficiency_level, assessed_date) VALUES
(seq_student_skills.NEXTVAL, 1, 1, 4, TO_DATE('2024-01-15', 'YYYY-MM-DD'));
INSERT INTO student_skills (student_skill_id, student_id, skill_id, proficiency_level, assessed_date) VALUES
(seq_student_skills.NEXTVAL, 1, 2, 2, TO_DATE('2024-01-15', 'YYYY-MM-DD'));
INSERT INTO student_skills (student_skill_id, student_id, skill_id, proficiency_level, assessed_date) VALUES
(seq_student_skills.NEXTVAL, 1, 5, 3, TO_DATE('2024-01-15', 'YYYY-MM-DD'));
INSERT INTO student_skills (student_skill_id, student_id, skill_id, proficiency_level, assessed_date) VALUES
(seq_student_skills.NEXTVAL, 2, 3, 4, TO_DATE('2024-01-20', 'YYYY-MM-DD'));
INSERT INTO student_skills (student_skill_id, student_id, skill_id, proficiency_level, assessed_date) VALUES
(seq_student_skills.NEXTVAL, 2, 4, 3, TO_DATE('2024-01-20', 'YYYY-MM-DD'));
INSERT INTO student_skills (student_skill_id, student_id, skill_id, proficiency_level, assessed_date) VALUES
(seq_student_skills.NEXTVAL, 2, 6, 2, TO_DATE('2024-01-20', 'YYYY-MM-DD'));
INSERT INTO student_skills (student_skill_id, student_id, skill_id, proficiency_level, assessed_date) VALUES
(seq_student_skills.NEXTVAL, 3, 1, 3, TO_DATE('2024-01-25', 'YYYY-MM-DD'));
INSERT INTO student_skills (student_skill_id, student_id, skill_id, proficiency_level, assessed_date) VALUES
(seq_student_skills.NEXTVAL, 3, 5, 2, TO_DATE('2024-01-25', 'YYYY-MM-DD'));
INSERT INTO student_skills (student_skill_id, student_id, skill_id, proficiency_level, assessed_date) VALUES
(seq_student_skills.NEXTVAL, 3, 7, 1, TO_DATE('2024-01-25', 'YYYY-MM-DD'));
COMMIT;

-- Insert sample assessments
INSERT INTO assessments (assessment_id, assessment_name, skill_id, total_questions, passing_score) VALUES
(seq_assessments.NEXTVAL, 'Java Basics', 1, 20, 60);
INSERT INTO assessments (assessment_id, assessment_name, skill_id, total_questions, passing_score) VALUES
(seq_assessments.NEXTVAL, 'Python Fundamentals', 2, 25, 70);
INSERT INTO assessments (assessment_id, assessment_name, skill_id, total_questions, passing_score) VALUES
(seq_assessments.NEXTVAL, 'Web Dev Challenge', 3, 30, 75);
INSERT INTO assessments (assessment_id, assessment_name, skill_id, total_questions, passing_score) VALUES
(seq_assessments.NEXTVAL, 'Database Design', 4, 15, 65);
INSERT INTO assessments (assessment_id, assessment_name, skill_id, total_questions, passing_score) VALUES
(seq_assessments.NEXTVAL, 'Data Structures', 5, 20, 70);
COMMIT;

-- Insert sample questions (5 per each of Java/Python/Data Structures with difficulty 1-5)
INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option) VALUES
(seq_questions.NEXTVAL, 1, 1, 'What is the default value of an int in Java?', '0', 'null', '1', '-1', 'A');
INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option) VALUES
(seq_questions.NEXTVAL, 1, 2, 'Which keyword is used to inherit a class in Java?', 'implements', 'extends', 'inherits', 'super', 'B');
INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option) VALUES
(seq_questions.NEXTVAL, 1, 3, 'What does JVM stand for?', 'Java Virtual Machine', 'Java Visual Model', 'Just Virtual Machine', 'Java Variable Memory', 'A');
INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option) VALUES
(seq_questions.NEXTVAL, 1, 4, 'Which collection class allows you to grow or shrink an array?', 'ArrayList', 'HashMap', 'Vector', 'LinkedList', 'A');
INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option) VALUES
(seq_questions.NEXTVAL, 1, 5, 'What mechanism prevents two threads from accessing the same resource simultaneously?', 'Serializaton', 'Synchronization', 'Lang Binding', 'Thread Interrupt', 'B');

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option) VALUES
(seq_questions.NEXTVAL, 2, 1, 'Which symbol is used for comments in Python?', '#', '//', '/*', '<!--', 'A');
INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option) VALUES
(seq_questions.NEXTVAL, 2, 2, 'How do you define a function in Python?', 'function foo():', 'def foo():', 'func foo() {}', 'lambda foo:', 'B');
INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option) VALUES
(seq_questions.NEXTVAL, 2, 3, 'What is the output of len("hello")?', '4', '5', '6', 'error', 'B');
INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option) VALUES
(seq_questions.NEXTVAL, 2, 4, 'Which keyword is used to handle exceptions in Python?', 'catch', 'except', 'handle', 'error', 'B');
INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option) VALUES
(seq_questions.NEXTVAL, 2, 5, 'What does PEP stand for?', 'Python Enhancement Proposal', 'Programming Enactment Plan', 'Python Entry Point', 'Performance Evaluation Protocol', 'A');

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option) VALUES
(seq_questions.NEXTVAL, 5, 1, 'Which data structure uses FIFO order?', 'Stack', 'Queue', 'Tree', 'Graph', 'B');
INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option) VALUES
(seq_questions.NEXTVAL, 5, 2, 'What is the time complexity of binary search?', 'O(n)', 'O(log n)', 'O(n log n)', 'O(1)', 'B');
INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option) VALUES
(seq_questions.NEXTVAL, 5, 3, 'Which traversal visits left subtree, node, right subtree?', 'Preorder', 'Inorder', 'Postorder', 'Levelorder', 'B');
INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option) VALUES
(seq_questions.NEXTVAL, 5, 4, 'What is the height of a balanced binary tree with n nodes?', 'log n', 'n/log n', 'sqrt(n)', 'n', 'A');
INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option) VALUES
(seq_questions.NEXTVAL, 5, 5, 'Which algorithm is used for shortest path in weighted graph?', 'DFS', 'BFS', 'Dijkstra', 'Prim', 'C');

COMMIT;

-- Insert sample assessment results
INSERT INTO assessment_results (result_id, student_id, assessment_id, score, percentage, completion_time) VALUES
(seq_assessment_results.NEXTVAL, 1, 1, 16, 80, 45);
INSERT INTO assessment_results (result_id, student_id, assessment_id, score, percentage, completion_time) VALUES
(seq_assessment_results.NEXTVAL, 1, 2, 12, 60, 50);
INSERT INTO assessment_results (result_id, student_id, assessment_id, score, percentage, completion_time) VALUES
(seq_assessment_results.NEXTVAL, 2, 3, 24, 80, 55);
INSERT INTO assessment_results (result_id, student_id, assessment_id, score, percentage, completion_time) VALUES
(seq_assessment_results.NEXTVAL, 2, 4, 11, 73, 40);
INSERT INTO assessment_results (result_id, student_id, assessment_id, score, percentage, completion_time) VALUES
(seq_assessment_results.NEXTVAL, 3, 1, 14, 70, 48);
COMMIT;

-- Insert sample skill gap analysis
INSERT INTO skill_gap_analysis (analysis_id, student_id, skill_id, current_level, target_level, gap_score) VALUES
(seq_skill_gap_analysis.NEXTVAL, 1, 2, 2, 4, 2.0);
INSERT INTO skill_gap_analysis (analysis_id, student_id, skill_id, current_level, target_level, gap_score) VALUES
(seq_skill_gap_analysis.NEXTVAL, 1, 6, 1, 4, 3.0);
INSERT INTO skill_gap_analysis (analysis_id, student_id, skill_id, current_level, target_level, gap_score) VALUES
(seq_skill_gap_analysis.NEXTVAL, 2, 1, 2, 4, 2.0);
INSERT INTO skill_gap_analysis (analysis_id, student_id, skill_id, current_level, target_level, gap_score) VALUES
(seq_skill_gap_analysis.NEXTVAL, 2, 6, 2, 5, 3.0);
INSERT INTO skill_gap_analysis (analysis_id, student_id, skill_id, current_level, target_level, gap_score) VALUES
(seq_skill_gap_analysis.NEXTVAL, 3, 7, 1, 4, 3.0);
COMMIT;

-- Insert sample recommendations
INSERT INTO recommendations (recommendation_id, student_id, skill_id, recommendation_text, priority) VALUES
(seq_recommendations.NEXTVAL, 1, 2, 'Focus on Python fundamentals and practice with data science libraries', 1);
INSERT INTO recommendations (recommendation_id, student_id, skill_id, recommendation_text, priority) VALUES
(seq_recommendations.NEXTVAL, 1, 6, 'Take Machine Learning course and work on ML projects', 1);
INSERT INTO recommendations (recommendation_id, student_id, skill_id, recommendation_text, priority) VALUES
(seq_recommendations.NEXTVAL, 2, 1, 'Strengthen core Java concepts and OOP principles', 2);
INSERT INTO recommendations (recommendation_id, student_id, skill_id, recommendation_text, priority) VALUES
(seq_recommendations.NEXTVAL, 2, 6, 'Explore ML algorithms and implement projects', 1);
INSERT INTO recommendations (recommendation_id, student_id, skill_id, recommendation_text, priority) VALUES
(seq_recommendations.NEXTVAL, 3, 7, 'Learn cloud platforms and containerization technologies', 1);
COMMIT;
