-- Create Sequences for ID generation
CREATE SEQUENCE seq_users START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_students START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_skills START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_student_skills START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_assessments START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_assessment_results START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_skill_gap_analysis START WITH 1 INCREMENT BY 1;

-- sequence for MCQ questions
CREATE SEQUENCE seq_questions START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE seq_recommendations START WITH 1 INCREMENT BY 1;

-- Create Users table
CREATE TABLE users (
    user_id NUMBER PRIMARY KEY,
    username VARCHAR2(100) UNIQUE NOT NULL,
    password_hash VARCHAR2(255) NOT NULL,
    email VARCHAR2(100) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT SYSDATE
);

-- Create Students table
CREATE TABLE students (
    student_id NUMBER PRIMARY KEY,
    user_id NUMBER NOT NULL,
    first_name VARCHAR2(100) NOT NULL,
    last_name VARCHAR2(100) NOT NULL,
    department VARCHAR2(100),
    semester NUMBER,
    cgpa NUMBER(3, 2),
    created_at TIMESTAMP DEFAULT SYSDATE,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Create Skills table
CREATE TABLE skills (
    skill_id NUMBER PRIMARY KEY,
    skill_name VARCHAR2(100) UNIQUE NOT NULL,
    category VARCHAR2(100),
    description VARCHAR2(4000)
);

-- Create Student Skills table
CREATE TABLE student_skills (
    student_skill_id NUMBER PRIMARY KEY,
    student_id NUMBER NOT NULL,
    skill_id NUMBER NOT NULL,
    proficiency_level NUMBER CHECK (proficiency_level BETWEEN 1 AND 5),
    assessed_date DATE,
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (skill_id) REFERENCES skills(skill_id) ON DELETE CASCADE
);

-- Create Questions table for MCQ engine
CREATE TABLE questions (
    question_id NUMBER PRIMARY KEY,
    skill_id NUMBER NOT NULL,
    difficulty_level NUMBER CHECK (difficulty_level BETWEEN 1 AND 5),
    question_text VARCHAR2(1000) NOT NULL,
    option_a VARCHAR2(255) NOT NULL,
    option_b VARCHAR2(255) NOT NULL,
    option_c VARCHAR2(255) NOT NULL,
    option_d VARCHAR2(255) NOT NULL,
    correct_option CHAR(1) CHECK (correct_option IN ('A','B','C','D')),
    FOREIGN KEY (skill_id) REFERENCES skills(skill_id) ON DELETE CASCADE
);

-- Create Assessments table
CREATE TABLE assessments (
    assessment_id NUMBER PRIMARY KEY,
    assessment_name VARCHAR2(100) NOT NULL,
    skill_id NUMBER NOT NULL,
    total_questions NUMBER,
    passing_score NUMBER,
    created_at TIMESTAMP DEFAULT SYSDATE,
    FOREIGN KEY (skill_id) REFERENCES skills(skill_id) ON DELETE CASCADE
);

-- Create Assessment Results table
CREATE TABLE assessment_results (
    result_id NUMBER PRIMARY KEY,
    student_id NUMBER NOT NULL,
    assessment_id NUMBER NOT NULL,
    score NUMBER,
    percentage NUMBER(5, 2),
    completion_time NUMBER,
    taken_at TIMESTAMP DEFAULT SYSDATE,
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (assessment_id) REFERENCES assessments(assessment_id) ON DELETE CASCADE
);

-- Create Skill Gap Analysis table
CREATE TABLE skill_gap_analysis (
    analysis_id NUMBER PRIMARY KEY,
    student_id NUMBER NOT NULL,
    skill_id NUMBER NOT NULL,
    current_level NUMBER,
    target_level NUMBER,
    gap_score NUMBER(5, 2),
    analysis_date TIMESTAMP DEFAULT SYSDATE,
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (skill_id) REFERENCES skills(skill_id) ON DELETE CASCADE
);

-- Create Recommendations table
CREATE TABLE recommendations (
    recommendation_id NUMBER PRIMARY KEY,
    student_id NUMBER NOT NULL,
    skill_id NUMBER NOT NULL,
    recommendation_text VARCHAR2(4000) NOT NULL,
    priority NUMBER,
    created_at TIMESTAMP DEFAULT SYSDATE,
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (skill_id) REFERENCES skills(skill_id) ON DELETE CASCADE
);
