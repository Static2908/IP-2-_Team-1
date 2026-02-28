-- =========================================================
-- MCQ Question Engine Setup for SkillGapApp
-- =========================================================

-- Create sequence
CREATE SEQUENCE seq_questions START WITH 1 INCREMENT BY 1;

-- Create questions table
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

-- =========================================================
-- JAVA QUESTIONS
-- =========================================================

INSERT INTO questions
SELECT seq_questions.NEXTVAL, skill_id, 1,
'What is the default value of int in Java?',
'0','null','1','-1','A'
FROM skills WHERE skill_name='Java';

INSERT INTO questions
SELECT seq_questions.NEXTVAL, skill_id, 1,
'Which method is entry point of Java program?',
'start()','main()','run()','init()','B'
FROM skills WHERE skill_name='Java';

INSERT INTO questions
SELECT seq_questions.NEXTVAL, skill_id, 2,
'Which keyword is used for inheritance?',
'implements','extends','super','inherits','B'
FROM skills WHERE skill_name='Java';

INSERT INTO questions
SELECT seq_questions.NEXTVAL, skill_id, 2,
'Which package contains Scanner class?',
'java.util','java.io','java.lang','java.sql','A'
FROM skills WHERE skill_name='Java';

INSERT INTO questions
SELECT seq_questions.NEXTVAL, skill_id, 3,
'What does JVM stand for?',
'Java Virtual Machine','Java Variable Model','Joint VM','None','A'
FROM skills WHERE skill_name='Java';

INSERT INTO questions
SELECT seq_questions.NEXTVAL, skill_id, 3,
'Which concept enables runtime polymorphism?',
'Overloading','Overriding','Encapsulation','Abstraction','B'
FROM skills WHERE skill_name='Java';

INSERT INTO questions
SELECT seq_questions.NEXTVAL, skill_id, 4,
'Which collection allows dynamic resizing?',
'ArrayList','HashSet','TreeMap','Stack','A'
FROM skills WHERE skill_name='Java';

INSERT INTO questions
SELECT seq_questions.NEXTVAL, skill_id, 4,
'Which interface provides key-value mapping?',
'List','Set','Map','Queue','C'
FROM skills WHERE skill_name='Java';

INSERT INTO questions
SELECT seq_questions.NEXTVAL, skill_id, 5,
'Which memory area stores class metadata?',
'Heap','Stack','Method Area','Cache','C'
FROM skills WHERE skill_name='Java';

INSERT INTO questions
SELECT seq_questions.NEXTVAL, skill_id, 5,
'What ensures thread safety in Java?',
'Serialization','Synchronization','Binding','ThreadLocal','B'
FROM skills WHERE skill_name='Java';


-- =========================================================
-- PYTHON QUESTIONS
-- =========================================================

INSERT INTO questions
SELECT seq_questions.NEXTVAL, skill_id, 1,
'Which symbol is used for comments?',
'#','//','/*','--','A'
FROM skills WHERE skill_name='Python';

INSERT INTO questions
SELECT seq_questions.NEXTVAL, skill_id, 1,
'Which function prints output?',
'echo()','print()','printf()','display()','B'
FROM skills WHERE skill_name='Python';

INSERT INTO questions
SELECT seq_questions.NEXTVAL, skill_id, 2,
'How do you define a function?',
'function foo()','def foo():','func foo','lambda foo','B'
FROM skills WHERE skill_name='Python';

INSERT INTO questions
SELECT seq_questions.NEXTVAL, skill_id, 2,
'Which data type is immutable?',
'List','Dictionary','Tuple','Set','C'
FROM skills WHERE skill_name='Python';

INSERT INTO questions
SELECT seq_questions.NEXTVAL, skill_id, 3,
'What is output of len("hello")?',
'4','5','6','error','B'
FROM skills WHERE skill_name='Python';

INSERT INTO questions
SELECT seq_questions.NEXTVAL, skill_id, 3,
'Which keyword handles exceptions?',
'catch','except','handle','error','B'
FROM skills WHERE skill_name='Python';

INSERT INTO questions
SELECT seq_questions.NEXTVAL, skill_id, 4,
'Which library is used for data analysis?',
'numpy','matplotlib','pandas','flask','C'
FROM skills WHERE skill_name='Python';

INSERT INTO questions
SELECT seq_questions.NEXTVAL, skill_id, 4,
'Which concept supports OOP in Python?',
'Classes','Macros','Pointers','Modules','A'
FROM skills WHERE skill_name='Python';

INSERT INTO questions
SELECT seq_questions.NEXTVAL, skill_id, 5,
'What does PEP stand for?',
'Python Enhancement Proposal','Programming Evaluation Plan','Python Entry Protocol','None','A'
FROM skills WHERE skill_name='Python';

INSERT INTO questions
SELECT seq_questions.NEXTVAL, skill_id, 5,
'Which module supports concurrency?',
'thread','asyncio','sys','math','B'
FROM skills WHERE skill_name='Python';


-- =========================================================
-- DATA STRUCTURES QUESTIONS
-- =========================================================

INSERT INTO questions
SELECT seq_questions.NEXTVAL, skill_id, 1,
'Which structure follows FIFO?',
'Stack','Queue','Tree','Graph','B'
FROM skills WHERE skill_name='Data Structures';

INSERT INTO questions
SELECT seq_questions.NEXTVAL, skill_id, 1,
'Which structure follows LIFO?',
'Queue','Stack','Heap','Graph','B'
FROM skills WHERE skill_name='Data Structures';

INSERT INTO questions
SELECT seq_questions.NEXTVAL, skill_id, 2,
'Binary search time complexity?',
'O(n)','O(log n)','O(n log n)','O(1)','B'
FROM skills WHERE skill_name='Data Structures';

INSERT INTO questions
SELECT seq_questions.NEXTVAL, skill_id, 2,
'Stack operations are performed at?',
'Front','Rear','Top','Middle','C'
FROM skills WHERE skill_name='Data Structures';

INSERT INTO questions
SELECT seq_questions.NEXTVAL, skill_id, 3,
'Inorder traversal visits?',
'Left-Root-Right','Root-Left-Right','Left-Right-Root','Levelwise','A'
FROM skills WHERE skill_name='Data Structures';

INSERT INTO questions
SELECT seq_questions.NEXTVAL, skill_id, 3,
'Which DS uses nodes and pointers?',
'Array','Linked List','Stack','Queue','B'
FROM skills WHERE skill_name='Data Structures';

INSERT INTO questions
SELECT seq_questions.NEXTVAL, skill_id, 4,
'Height of balanced tree?',
'log n','n','sqrt(n)','n log n','A'
FROM skills WHERE skill_name='Data Structures';

INSERT INTO questions
SELECT seq_questions.NEXTVAL, skill_id, 4,
'Heap is used for?',
'Sorting','Searching','Recursion','Traversal','A'
FROM skills WHERE skill_name='Data Structures';

INSERT INTO questions
SELECT seq_questions.NEXTVAL, skill_id, 5,
'Shortest path algorithm?',
'DFS','BFS','Dijkstra','Prim','C'
FROM skills WHERE skill_name='Data Structures';

INSERT INTO questions
SELECT seq_questions.NEXTVAL, skill_id, 5,
'Which structure supports priority scheduling?',
'Queue','Stack','Heap','Tree','C'
FROM skills WHERE skill_name='Data Structures';

COMMIT;