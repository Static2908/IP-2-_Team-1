-- =========================================================
-- SkillBridge Question Pool Seed
-- Expands existing question bank to 25 questions per skill
-- =========================================================
-- Skills 1 (Java), 2 (Python), 5 (Data Structures):
--   Already have 2 questions per difficulty → add 3 more each.
-- Skills 3 (Web Development), 4 (Database Design),
--         6 (Machine Learning), 7 (Cloud Computing),
--         8 (System Design):
--   Insert full 25 questions (5 per difficulty).
--
-- Run with:  SQL> @seed_skillbridge_questions.sql
-- =========================================================


-- =========================================================
-- JAVA  (skill_id = 1)  — add 3 per difficulty  (15 new)
-- =========================================================

-- Difficulty 1
INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 1,
'Which keyword is used to define a constant in Java?',
'static','final','const','immutable','B'
FROM skills WHERE skill_name = 'Java';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 1,
'What is the size of a boolean in Java?',
'1 bit','1 byte','2 bytes','JVM-dependent','D'
FROM skills WHERE skill_name = 'Java';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 1,
'Which of these is NOT a primitive type in Java?',
'int','char','String','double','C'
FROM skills WHERE skill_name = 'Java';

-- Difficulty 2
INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 2,
'Which access modifier makes a member accessible only within its class?',
'protected','default','private','public','C'
FROM skills WHERE skill_name = 'Java';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 2,
'What does the "this" keyword refer to?',
'Current method','Superclass','Current object instance','Static context','C'
FROM skills WHERE skill_name = 'Java';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 2,
'Which OOP principle hides internal state behind methods?',
'Inheritance','Polymorphism','Encapsulation','Abstraction','C'
FROM skills WHERE skill_name = 'Java';

-- Difficulty 3
INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 3,
'What is the output of Integer.parseInt("42")?',
'Error','42 (int)','42 (double)','42.0','B'
FROM skills WHERE skill_name = 'Java';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 3,
'Which Java feature introduced lambda expressions?',
'Java 6','Java 7','Java 8','Java 11','C'
FROM skills WHERE skill_name = 'Java';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 3,
'Which class is the parent of all Java classes?',
'Class','Superclass','Object','Base','C'
FROM skills WHERE skill_name = 'Java';

-- Difficulty 4
INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 4,
'What is the time complexity of HashMap.get() in the best case?',
'O(n)','O(log n)','O(1)','O(n log n)','C'
FROM skills WHERE skill_name = 'Java';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 4,
'Which collection maintains insertion order and allows duplicates?',
'HashSet','TreeSet','LinkedList','PriorityQueue','C'
FROM skills WHERE skill_name = 'Java';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 4,
'Which keyword prevents a method from being overridden?',
'static','abstract','final','private','C'
FROM skills WHERE skill_name = 'Java';

-- Difficulty 5
INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 5,
'What is a happens-before relationship in Java concurrency?',
'A scheduling priority','A memory visibility guarantee','A lock ordering rule','A thread priority','B'
FROM skills WHERE skill_name = 'Java';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 5,
'Which garbage collector uses region-based collection?',
'Serial GC','Parallel GC','CMS','G1 GC','D'
FROM skills WHERE skill_name = 'Java';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 5,
'What does volatile guarantee in Java?',
'Atomicity only','Ordering and visibility','Mutual exclusion','Stack isolation','B'
FROM skills WHERE skill_name = 'Java';

COMMIT;


-- =========================================================
-- PYTHON  (skill_id = 2)  — add 3 per difficulty  (15 new)
-- =========================================================

-- Difficulty 1
INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 1,
'Which keyword is used to create a variable with global scope inside a function?',
'var','global','nonlocal','extern','B'
FROM skills WHERE skill_name = 'Python';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 1,
'What type does 3/2 return in Python 3?',
'int','float','complex','error','B'
FROM skills WHERE skill_name = 'Python';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 1,
'Which built-in function returns the number of items in a list?',
'count()','size()','len()','length()','C'
FROM skills WHERE skill_name = 'Python';

-- Difficulty 2
INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 2,
'What is a list comprehension used for?',
'Creating generators','Filtering functions','Constructing lists concisely','Defining classes','C'
FROM skills WHERE skill_name = 'Python';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 2,
'Which of these is a mutable data type in Python?',
'tuple','frozenset','str','list','D'
FROM skills WHERE skill_name = 'Python';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 2,
'What does the *args parameter allow in a function?',
'Keyword arguments','Variable positional arguments','Default values','Type hints','B'
FROM skills WHERE skill_name = 'Python';

-- Difficulty 3
INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 3,
'What is a decorator in Python?',
'A class attribute','A function that wraps another function','A built-in module','A type annotation','B'
FROM skills WHERE skill_name = 'Python';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 3,
'Which dunder method is called when an object is created?',
'__new__','__create__','__init__','__build__','C'
FROM skills WHERE skill_name = 'Python';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 3,
'What is the difference between is and == in Python?',
'No difference','is compares identity; == compares value','is compares value; == compares identity','is is deprecated','B'
FROM skills WHERE skill_name = 'Python';

-- Difficulty 4
INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 4,
'Which NumPy operation broadcasts arrays of shapes (3,1) and (1,4)?',
'Raises error','Produces shape (3,4)','Produces shape (1,1)','Produces shape (4,3)','B'
FROM skills WHERE skill_name = 'Python';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 4,
'What does the yield keyword create?',
'A coroutine','A generator function','A class method','A lambda','B'
FROM skills WHERE skill_name = 'Python';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 4,
'Which pandas method fills missing values?',
'dropna()','fillna()','replace()','impute()','B'
FROM skills WHERE skill_name = 'Python';

-- Difficulty 5
INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 5,
'What is the GIL in CPython?',
'Global Import Lock','Global Interpreter Lock','Generic Instruction Layer','Garbage Isolation Logic','B'
FROM skills WHERE skill_name = 'Python';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 5,
'Which module enables true parallelism in Python by bypassing the GIL?',
'threading','asyncio','multiprocessing','concurrent.futures','C'
FROM skills WHERE skill_name = 'Python';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 5,
'What is a metaclass in Python?',
'A class without attributes','A class whose instances are classes','An abstract base class','A singleton pattern','B'
FROM skills WHERE skill_name = 'Python';

COMMIT;


-- =========================================================
-- DATA STRUCTURES  (skill_id = 5)  — add 3 per difficulty
-- =========================================================

-- Difficulty 1
INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 1,
'What is the time complexity of accessing an array element by index?',
'O(n)','O(log n)','O(1)','O(n^2)','C'
FROM skills WHERE skill_name = 'Data Structures';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 1,
'Which data structure is best for implementing undo/redo operations?',
'Queue','Heap','Stack','Graph','C'
FROM skills WHERE skill_name = 'Data Structures';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 1,
'A linked list node contains?',
'Data only','Pointer only','Data and a pointer','Index and data','C'
FROM skills WHERE skill_name = 'Data Structures';

-- Difficulty 2
INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 2,
'What is the worst-case time complexity of linear search?',
'O(1)','O(log n)','O(n)','O(n^2)','C'
FROM skills WHERE skill_name = 'Data Structures';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 2,
'Which sorting algorithm is stable and has O(n log n) worst case?',
'Quick Sort','Heap Sort','Merge Sort','Selection Sort','C'
FROM skills WHERE skill_name = 'Data Structures';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 2,
'In a circular queue, how is the rear position calculated after enqueue?',
'rear + 1','(rear + 1) % size','rear - 1','size - rear','B'
FROM skills WHERE skill_name = 'Data Structures';

-- Difficulty 3
INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 3,
'What is a complete binary tree?',
'All nodes have 2 children','All levels filled except possibly the last, filled left to right','Root has no children','Leaf nodes at level 0','B'
FROM skills WHERE skill_name = 'Data Structures';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 3,
'Which data structure is used in BFS traversal?',
'Stack','Heap','Queue','Priority Queue','C'
FROM skills WHERE skill_name = 'Data Structures';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 3,
'What is a hash collision?',
'Two keys map to the same hash bucket','A hash function error','Memory overflow','Null pointer exception','A'
FROM skills WHERE skill_name = 'Data Structures';

-- Difficulty 4
INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 4,
'Which data structure supports O(log n) insert, delete, and search?',
'Hash table','Array','Balanced BST','Linked list','C'
FROM skills WHERE skill_name = 'Data Structures';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 4,
'In a min-heap, the parent node is always?',
'Greater than children','Equal to children','Less than or equal to children','The largest element','C'
FROM skills WHERE skill_name = 'Data Structures';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 4,
'Which graph algorithm detects a negative weight cycle?',
'Dijkstra','Prim','Bellman-Ford','Kruskal','C'
FROM skills WHERE skill_name = 'Data Structures';

-- Difficulty 5
INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 5,
'What is the amortized time complexity of dynamic array append?',
'O(n)','O(log n)','O(1)','O(n^2)','C'
FROM skills WHERE skill_name = 'Data Structures';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 5,
'Which algorithm finds minimum spanning tree using a greedy edge approach?',
'Dijkstra','Kruskal','Bellman-Ford','Floyd-Warshall','B'
FROM skills WHERE skill_name = 'Data Structures';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 5,
'A B-Tree of order m has at most how many keys per node?',
'm','m-1','2m','2m-1','B'
FROM skills WHERE skill_name = 'Data Structures';

COMMIT;


-- =========================================================
-- WEB DEVELOPMENT  (skill_id = 3)  — full 25 questions
-- =========================================================

-- Difficulty 1
INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 1,
'What does HTML stand for?',
'Hyper Text Markup Language','High Tech Modern Language','Hyper Transfer Markup Language','Hyper Transmission Meta Language','A'
FROM skills WHERE skill_name = 'Web Development';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 1,
'Which HTML tag creates a hyperlink?',
'<link>','<href>','<a>','<url>','C'
FROM skills WHERE skill_name = 'Web Development';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 1,
'Which CSS property changes text color?',
'font-color','text-color','color','foreground','C'
FROM skills WHERE skill_name = 'Web Development';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 1,
'Which tag defines the largest heading in HTML?',
'<h6>','<header>','<h1>','<heading>','C'
FROM skills WHERE skill_name = 'Web Development';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 1,
'Which attribute is used to apply a CSS class to an HTML element?',
'id','name','class','style','C'
FROM skills WHERE skill_name = 'Web Development';

-- Difficulty 2
INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 2,
'What is the CSS box model composed of?',
'Content, Padding, Border, Margin','Content, Font, Width, Height','Margin, Gap, Flex, Grid','None of the above','A'
FROM skills WHERE skill_name = 'Web Development';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 2,
'Which JavaScript method selects an element by ID?',
'querySelector()','getElementByClass()','getElementById()','selectById()','C'
FROM skills WHERE skill_name = 'Web Development';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 2,
'What does CSS Flexbox primarily control?',
'Typography','Animations','One-dimensional layout','3D transforms','C'
FROM skills WHERE skill_name = 'Web Development';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 2,
'Which HTTP method is used to submit a form?',
'GET','DELETE','PUT','POST','D'
FROM skills WHERE skill_name = 'Web Development';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 2,
'What is the purpose of the <meta charset="UTF-8"> tag?',
'Sets page language','Defines character encoding','Controls caching','Sets page title','B'
FROM skills WHERE skill_name = 'Web Development';

-- Difficulty 3
INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 3,
'What is a REST API?',
'A database protocol','An architectural style for web services using HTTP','A JavaScript framework','A CSS preprocessor','B'
FROM skills WHERE skill_name = 'Web Development';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 3,
'Which HTTP status code means "resource not found"?',
'200','301','404','500','C'
FROM skills WHERE skill_name = 'Web Development';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 3,
'What does CORS stand for?',
'Cross-Origin Resource Sharing','Client-Object Relaying Service','Cross-Origin Runtime Script','Cached Object Resource System','A'
FROM skills WHERE skill_name = 'Web Development';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 3,
'What is the DOM?',
'Database Object Model','Document Object Model','Dynamic Output Model','Design Object Method','B'
FROM skills WHERE skill_name = 'Web Development';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 3,
'Which CSS unit is relative to the root font size?',
'px','em','rem','vh','C'
FROM skills WHERE skill_name = 'Web Development';

COMMIT;

-- Difficulty 4
INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 4,
'What is the purpose of a JWT token in web authentication?',
'Session storage','Stateless authentication via signed payload','Encrypting passwords','CSRF protection','B'
FROM skills WHERE skill_name = 'Web Development';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 4,
'Which technique improves performance by storing API responses locally?',
'Lazy loading','Caching','Debouncing','Throttling','B'
FROM skills WHERE skill_name = 'Web Development';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 4,
'What is the difference between localStorage and sessionStorage?',
'localStorage persists after tab close; sessionStorage does not','They are identical','sessionStorage is encrypted','localStorage is per-domain only','A'
FROM skills WHERE skill_name = 'Web Development';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 4,
'What does the HTTP 401 status code indicate?',
'Not found','Server error','Unauthorized','Forbidden','C'
FROM skills WHERE skill_name = 'Web Development';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 4,
'Which CSS property enables CSS Grid layout?',
'display: block','display: flex','display: grid','display: inline','C'
FROM skills WHERE skill_name = 'Web Development';

-- Difficulty 5
INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 5,
'What is a Content Security Policy (CSP)?',
'A database access policy','An HTTP header to prevent XSS and injection attacks','A TLS configuration','A CDN rule','B'
FROM skills WHERE skill_name = 'Web Development';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 5,
'What does server-side rendering (SSR) provide over client-side rendering?',
'Faster JavaScript bundles','Better SEO and faster initial load','Simpler state management','Offline capability','B'
FROM skills WHERE skill_name = 'Web Development';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 5,
'Which design pattern is commonly used in single-page application frameworks?',
'Singleton','Observer / Reactive','Factory','Decorator','B'
FROM skills WHERE skill_name = 'Web Development';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 5,
'What is the purpose of a service worker in a web app?',
'Server-side scripting','Background sync and offline caching','DOM manipulation','Form validation','B'
FROM skills WHERE skill_name = 'Web Development';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 5,
'What is HTTP/2 multiplexing?',
'Compressing headers','Sending multiple requests over a single TCP connection simultaneously','Using UDP instead of TCP','Encrypting payloads','B'
FROM skills WHERE skill_name = 'Web Development';

COMMIT;


-- =========================================================
-- DATABASE DESIGN  (skill_id = 4)  — full 25 questions
-- =========================================================

-- Difficulty 1
INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 1,
'What is a primary key?',
'Any column in a table','A column that uniquely identifies each row','A foreign reference','A duplicate-allowed column','B'
FROM skills WHERE skill_name = 'Database Design';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 1,
'Which SQL statement retrieves data from a table?',
'INSERT','UPDATE','SELECT','DELETE','C'
FROM skills WHERE skill_name = 'Database Design';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 1,
'What does NULL represent in a database?',
'Zero','Empty string','Unknown or missing value','False','C'
FROM skills WHERE skill_name = 'Database Design';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 1,
'Which SQL keyword removes duplicate rows from a result set?',
'UNIQUE','DISTINCT','FILTER','NODUPE','B'
FROM skills WHERE skill_name = 'Database Design';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 1,
'A foreign key enforces which type of integrity?',
'Domain integrity','Entity integrity','Referential integrity','User-defined integrity','C'
FROM skills WHERE skill_name = 'Database Design';

-- Difficulty 2
INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 2,
'What is the first normal form (1NF)?',
'No repeating groups and atomic column values','No partial dependencies','No transitive dependencies','No multivalued attributes only','A'
FROM skills WHERE skill_name = 'Database Design';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 2,
'Which JOIN returns only matching rows from both tables?',
'LEFT JOIN','RIGHT JOIN','FULL OUTER JOIN','INNER JOIN','D'
FROM skills WHERE skill_name = 'Database Design';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 2,
'What does the GROUP BY clause do?',
'Filters rows','Sorts results','Aggregates rows by column values','Joins tables','C'
FROM skills WHERE skill_name = 'Database Design';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 2,
'Which aggregate function returns the number of rows?',
'SUM()','AVG()','MAX()','COUNT()','D'
FROM skills WHERE skill_name = 'Database Design';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 2,
'What is a composite key?',
'A key using multiple columns','A key using VARCHAR','A randomly generated key','A computed key','A'
FROM skills WHERE skill_name = 'Database Design';

-- Difficulty 3
INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 3,
'What does 3NF (Third Normal Form) eliminate?',
'Repeating groups','Partial dependencies','Transitive dependencies','Multivalued dependencies','C'
FROM skills WHERE skill_name = 'Database Design';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 3,
'What is a database index primarily used for?',
'Enforcing constraints','Speeding up query retrieval','Compressing data','Encrypting columns','B'
FROM skills WHERE skill_name = 'Database Design';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 3,
'What does ACID stand for in database transactions?',
'Atomicity Consistency Isolation Durability','Availability Consistency Integrity Data','Access Control Integration Design','Atomic Concurrent Indexed Data','A'
FROM skills WHERE skill_name = 'Database Design';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 3,
'Which SQL clause filters grouped results?',
'WHERE','FILTER','HAVING','GROUP FILTER','C'
FROM skills WHERE skill_name = 'Database Design';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 3,
'A LEFT JOIN returns?',
'Only matching rows','All rows from right table','All rows from left table plus matches from right','Cartesian product','C'
FROM skills WHERE skill_name = 'Database Design';

COMMIT;

-- Difficulty 4
INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 4,
'What is a B-Tree index best suited for?',
'Full-text searches','Range queries and equality lookups','JSON documents','Bitmap scans only','B'
FROM skills WHERE skill_name = 'Database Design';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 4,
'What problem does database denormalization solve?',
'Data redundancy','Read performance at the cost of update anomalies','Write consistency','Foreign key violations','B'
FROM skills WHERE skill_name = 'Database Design';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 4,
'What is a deadlock in a database?',
'A slow query','Two transactions waiting on each other indefinitely','A crashed index','A failed migration','B'
FROM skills WHERE skill_name = 'Database Design';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 4,
'Which isolation level prevents dirty reads but allows non-repeatable reads?',
'Read Uncommitted','Read Committed','Repeatable Read','Serializable','B'
FROM skills WHERE skill_name = 'Database Design';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 4,
'What is a materialized view?',
'A virtual table with no storage','A view whose result is physically stored and refreshed','A read-only table','A temporary table','B'
FROM skills WHERE skill_name = 'Database Design';

-- Difficulty 5
INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 5,
'What is the CAP theorem?',
'Consistency, Availability, Partition tolerance – only 2 guaranteed simultaneously','Cache, API, Protocol','Concurrency, Atomicity, Persistence','Consistency, Access, Parallelism','A'
FROM skills WHERE skill_name = 'Database Design';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 5,
'What distinguishes OLTP from OLAP workloads?',
'OLTP handles complex analytics; OLAP is transactional','OLTP is transactional with frequent small writes; OLAP is analytical with large reads','They are identical','OLAP uses row storage; OLTP uses columnar','B'
FROM skills WHERE skill_name = 'Database Design';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 5,
'Which technique partitions a large table into smaller physical pieces?',
'Indexing','Sharding','Table partitioning','Replication','C'
FROM skills WHERE skill_name = 'Database Design';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 5,
'What is eventual consistency in distributed databases?',
'All nodes always agree immediately','All nodes will converge to the same value given enough time','Data is never consistent','Requires a single master node','B'
FROM skills WHERE skill_name = 'Database Design';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 5,
'What is write-ahead logging (WAL)?',
'Committing after writing','Recording changes to a log before applying them to the database','Caching all writes','Compressing write buffers','B'
FROM skills WHERE skill_name = 'Database Design';

COMMIT;


-- =========================================================
-- MACHINE LEARNING  (skill_id = 6)  — full 25 questions
-- =========================================================

-- Difficulty 1
INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 1,
'What is supervised learning?',
'Learning without labels','Learning with labeled input-output pairs','Reinforcement from environment','Dimensionality reduction','B'
FROM skills WHERE skill_name = 'Machine Learning';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 1,
'Which task predicts a continuous numeric value?',
'Classification','Clustering','Regression','Dimensionality reduction','C'
FROM skills WHERE skill_name = 'Machine Learning';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 1,
'What does a training set represent?',
'Data used to evaluate a model','Data used to fit a model','Data reserved for final testing','Unlabeled data','B'
FROM skills WHERE skill_name = 'Machine Learning';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 1,
'Which algorithm classifies by finding the nearest labeled examples?',
'Linear Regression','K-Nearest Neighbors','Decision Tree','Naive Bayes','B'
FROM skills WHERE skill_name = 'Machine Learning';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 1,
'What is a feature in machine learning?',
'The model output','An input variable used for prediction','A hyperparameter','A loss value','B'
FROM skills WHERE skill_name = 'Machine Learning';

-- Difficulty 2
INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 2,
'What is overfitting in a machine learning model?',
'Model performs poorly on all data','Model performs well on training but poorly on new data','Model has too few parameters','Model learns nothing','B'
FROM skills WHERE skill_name = 'Machine Learning';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 2,
'What does cross-validation help measure?',
'Training speed','Model generalization','Feature importance','Batch size','B'
FROM skills WHERE skill_name = 'Machine Learning';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 2,
'Which metric measures classification accuracy per class?',
'MSE','RMSE','F1 Score','R-squared','C'
FROM skills WHERE skill_name = 'Machine Learning';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 2,
'What is the purpose of a train-test split?',
'Increase model size','Evaluate model on unseen data','Reduce training time','Augment data','B'
FROM skills WHERE skill_name = 'Machine Learning';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 2,
'Which technique reduces overfitting by penalizing large coefficients?',
'Boosting','Regularization','Normalization','Bagging','B'
FROM skills WHERE skill_name = 'Machine Learning';

-- Difficulty 3
INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 3,
'What does the ROC curve plot?',
'Precision vs Recall','True Positive Rate vs False Positive Rate','Accuracy vs Loss','Training vs Validation loss','B'
FROM skills WHERE skill_name = 'Machine Learning';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 3,
'What is the bias-variance tradeoff?',
'Balancing underfitting and overfitting','Choosing between MSE and MAE','Setting learning rate vs epochs','Model size vs dataset size','A'
FROM skills WHERE skill_name = 'Machine Learning';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 3,
'In a Random Forest, how is diversity between trees achieved?',
'Same features every tree','Random subsets of features and samples','Pruning all trees identically','Single deep tree','B'
FROM skills WHERE skill_name = 'Machine Learning';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 3,
'What does PCA stand for?',
'Principal Component Analysis','Probabilistic Classification Algorithm','Predictive Clustering Approach','Polynomial Curve Approximation','A'
FROM skills WHERE skill_name = 'Machine Learning';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 3,
'Which activation function outputs values between 0 and 1?',
'ReLU','Tanh','Sigmoid','Softmax','C'
FROM skills WHERE skill_name = 'Machine Learning';

COMMIT;

-- Difficulty 4
INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 4,
'What is gradient descent?',
'A data preprocessing step','An iterative optimization algorithm minimizing loss','A feature selection method','A regularization technique','B'
FROM skills WHERE skill_name = 'Machine Learning';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 4,
'What is the vanishing gradient problem?',
'Gradients become too large','Gradients shrink toward zero in deep networks, halting learning','Model forgets earlier layers','Loss becomes negative','B'
FROM skills WHERE skill_name = 'Machine Learning';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 4,
'Which ensemble method trains models sequentially, weighting errors?',
'Bagging','Stacking','Boosting','Voting','C'
FROM skills WHERE skill_name = 'Machine Learning';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 4,
'What does AUC represent in classification evaluation?',
'Area Under the Curve of the ROC – overall model discrimination','Accuracy Under Conditions','Average Utility Coefficient','Absolute Uncertainty Correction','A'
FROM skills WHERE skill_name = 'Machine Learning';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 4,
'What is feature engineering?',
'Selecting a model architecture','Transforming raw data into meaningful inputs for a model','Splitting data into folds','Tuning hyperparameters','B'
FROM skills WHERE skill_name = 'Machine Learning';

-- Difficulty 5
INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 5,
'What is the attention mechanism in transformers?',
'A dropout technique','A way to weigh the importance of different input tokens for each output','A convolution filter','Batch normalization','B'
FROM skills WHERE skill_name = 'Machine Learning';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 5,
'What distinguishes a generative model from a discriminative model?',
'Generative models classify; discriminative models generate','Generative models learn data distribution; discriminative models learn decision boundaries','They are equivalent','Discriminative models are unsupervised','B'
FROM skills WHERE skill_name = 'Machine Learning';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 5,
'What is transfer learning?',
'Copying data between models','Using a pretrained model as a starting point for a new task','Retraining from scratch','Moving models between frameworks','B'
FROM skills WHERE skill_name = 'Machine Learning';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 5,
'What does SHAP explain in ML models?',
'Model architecture','Individual feature contributions to predictions','Dataset distribution','Gradient flow','B'
FROM skills WHERE skill_name = 'Machine Learning';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 5,
'What is a hyperparameter?',
'A learned model parameter','A configuration set before training that controls learning','A feature selected by the model','A loss function','B'
FROM skills WHERE skill_name = 'Machine Learning';

COMMIT;


-- =========================================================
-- CLOUD COMPUTING  (skill_id = 7)  — full 25 questions
-- =========================================================

-- Difficulty 1
INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 1,
'What is cloud computing?',
'Storing files on USB drives','Delivering computing services over the internet','Local server management','Database replication','B'
FROM skills WHERE skill_name = 'Cloud Computing';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 1,
'Which cloud service model provides virtual machines?',
'SaaS','PaaS','IaaS','FaaS','C'
FROM skills WHERE skill_name = 'Cloud Computing';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 1,
'What does AWS S3 primarily store?',
'Relational data','Object/blob files','Virtual machines','DNS records','B'
FROM skills WHERE skill_name = 'Cloud Computing';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 1,
'Which of the following is a public cloud provider?',
'On-premise server','AWS','Private data center','Intranet','B'
FROM skills WHERE skill_name = 'Cloud Computing';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 1,
'What is virtualization in cloud?',
'Physical server installation','Creating multiple virtual machines on one physical host','Network firewall setup','Data encryption','B'
FROM skills WHERE skill_name = 'Cloud Computing';

-- Difficulty 2
INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 2,
'What is auto-scaling in cloud computing?',
'Manual server provisioning','Automatically adjusting resource capacity based on demand','Encrypting traffic','Backing up databases','B'
FROM skills WHERE skill_name = 'Cloud Computing';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 2,
'What is a container in cloud infrastructure?',
'A physical box','A lightweight isolated runtime package for applications','A virtual machine','A storage bucket','B'
FROM skills WHERE skill_name = 'Cloud Computing';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 2,
'Which tool is used to manage containers?',
'Git','Jenkins','Docker','Ansible','C'
FROM skills WHERE skill_name = 'Cloud Computing';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 2,
'What is a load balancer?',
'A database replica','A device that distributes traffic across multiple servers','A caching layer','A CDN node','B'
FROM skills WHERE skill_name = 'Cloud Computing';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 2,
'What does CDN stand for?',
'Cloud Data Network','Content Delivery Network','Central Database Node','Compute Distribution Node','B'
FROM skills WHERE skill_name = 'Cloud Computing';

-- Difficulty 3
INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 3,
'What is Infrastructure as Code (IaC)?',
'Writing application code','Provisioning infrastructure through machine-readable config files','Manual server setup','Network packet inspection','B'
FROM skills WHERE skill_name = 'Cloud Computing';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 3,
'Which AWS service manages serverless functions?',
'EC2','RDS','Lambda','S3','C'
FROM skills WHERE skill_name = 'Cloud Computing';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 3,
'What is a VPC in AWS?',
'Virtual Private Cloud – isolated network section','Virtual Processing Core','Volume Provisioning Controller','Verified Port Configuration','A'
FROM skills WHERE skill_name = 'Cloud Computing';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 3,
'What does Kubernetes orchestrate?',
'CI/CD pipelines','Container clusters','Database migrations','Network security groups','B'
FROM skills WHERE skill_name = 'Cloud Computing';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 3,
'What is the difference between vertical and horizontal scaling?',
'Vertical adds more servers; horizontal upgrades one','Vertical upgrades one server; horizontal adds more servers','They are identical','Vertical is cloud-only','B'
FROM skills WHERE skill_name = 'Cloud Computing';

COMMIT;

-- Difficulty 4
INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 4,
'What is a multi-region cloud deployment used for?',
'Cost reduction only','High availability and disaster recovery','Faster builds','Simplified IAM','B'
FROM skills WHERE skill_name = 'Cloud Computing';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 4,
'What is the Shared Responsibility Model in cloud security?',
'Provider is responsible for everything','Customer manages physical hardware','Security responsibilities split between cloud provider and customer','No security needed on public cloud','C'
FROM skills WHERE skill_name = 'Cloud Computing';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 4,
'What does a service mesh provide in microservices?',
'Database replication','Traffic management, observability, and security between services','Frontend routing','Container image management','B'
FROM skills WHERE skill_name = 'Cloud Computing';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 4,
'What is cloud-native development?',
'Running apps on local machines','Designing apps to leverage cloud services like containers, microservices, and dynamic scaling','Using only one cloud provider','Migrating legacy apps unchanged','B'
FROM skills WHERE skill_name = 'Cloud Computing';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 4,
'Which pattern routes all microservice requests through a single entry point?',
'Circuit Breaker','Sidecar','API Gateway','Saga','C'
FROM skills WHERE skill_name = 'Cloud Computing';

-- Difficulty 5
INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 5,
'What is the purpose of an eBPF program in cloud networking?',
'Routing DNS queries','Running sandboxed code in the kernel for observability and networking','Managing S3 buckets','Compiling container images','B'
FROM skills WHERE skill_name = 'Cloud Computing';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 5,
'What distinguishes cold start latency in serverless functions?',
'Normal execution overhead','Delay caused by provisioning a new container when no warm instance exists','DNS resolution time','TLS handshake time','B'
FROM skills WHERE skill_name = 'Cloud Computing';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 5,
'Which Kubernetes controller maintains a desired number of pod replicas?',
'StatefulSet','DaemonSet','ReplicaSet','Job','C'
FROM skills WHERE skill_name = 'Cloud Computing';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 5,
'What is GitOps?',
'Using Git as the source of truth for infrastructure and deployment state','A Git branching strategy','A container registry','A CI/CD tool','A'
FROM skills WHERE skill_name = 'Cloud Computing';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 5,
'What problem does the circuit breaker pattern solve in microservices?',
'Slow database queries','Cascading failures when a downstream service is unavailable','Memory leaks','Container restarts','B'
FROM skills WHERE skill_name = 'Cloud Computing';

COMMIT;


-- =========================================================
-- SYSTEM DESIGN  (skill_id = 8)  — full 25 questions
-- =========================================================

-- Difficulty 1
INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 1,
'What is scalability in system design?',
'System security','The ability to handle growing load by adding resources','Faster CPU clocks','Reducing code complexity','B'
FROM skills WHERE skill_name = 'System Design';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 1,
'What is latency?',
'Data throughput','Time delay between a request and its response','Packet loss','Memory usage','B'
FROM skills WHERE skill_name = 'System Design';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 1,
'What does API stand for?',
'Application Programming Interface','Applied Protocol Integration','Automated Process Interaction','Advanced Program Index','A'
FROM skills WHERE skill_name = 'System Design';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 1,
'What is a database in a system architecture?',
'A network switch','Persistent structured storage of application data','A CPU core','A reverse proxy','B'
FROM skills WHERE skill_name = 'System Design';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 1,
'What does high availability mean?',
'Maximum CPU usage','System remains operational with minimal downtime','Highest network speed','Most expensive configuration','B'
FROM skills WHERE skill_name = 'System Design';

-- Difficulty 2
INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 2,
'What is caching used for in system design?',
'Writing data to disk','Reducing repeated expensive computations or database queries','Encrypting traffic','Compressing files','B'
FROM skills WHERE skill_name = 'System Design';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 2,
'What is a monolith architecture?',
'System split into services','Single unified deployable application containing all functionality','Stateless API design','Container-first approach','B'
FROM skills WHERE skill_name = 'System Design';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 2,
'What is the role of a message queue?',
'Render HTML','Asynchronously decouple producers from consumers','Store SQL data','Route HTTP requests','B'
FROM skills WHERE skill_name = 'System Design';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 2,
'What does throughput measure?',
'Request latency','Number of requests processed per unit time','Memory consumption','Disk IOPS only','B'
FROM skills WHERE skill_name = 'System Design';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 2,
'What is a reverse proxy?',
'A client-side cache','A server that forwards client requests to backend servers','A DNS resolver','A rate limiter only','B'
FROM skills WHERE skill_name = 'System Design';

-- Difficulty 3
INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 3,
'What is microservices architecture?',
'A single large application','Decomposing an application into small independent services each with its own responsibility','A serverless pattern','A three-tier model','B'
FROM skills WHERE skill_name = 'System Design';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 3,
'What is database replication used for?',
'Schema migration','Creating copies of data across nodes for redundancy and read scaling','Compressing query results','Partitioning tables','B'
FROM skills WHERE skill_name = 'System Design';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 3,
'What is rate limiting?',
'Capping server CPU','Controlling how many requests a client can make in a time window','Encrypting API calls','Load balancing algorithm','B'
FROM skills WHERE skill_name = 'System Design';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 3,
'What is sharding in databases?',
'Adding read replicas','Horizontally partitioning data across multiple database instances','Encrypting rows','Merging tables','B'
FROM skills WHERE skill_name = 'System Design';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 3,
'Which cache eviction policy removes the least recently accessed item?',
'FIFO','LFU','LRU','Random','C'
FROM skills WHERE skill_name = 'System Design';

COMMIT;

-- Difficulty 4
INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 4,
'What is the difference between SQL and NoSQL databases in system design?',
'SQL is faster always','SQL is relational with ACID; NoSQL is flexible schema, often trading consistency for scale','NoSQL is better for all use cases','They are identical','B'
FROM skills WHERE skill_name = 'System Design';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 4,
'What is consistent hashing used for?',
'Encrypting data','Distributing requests across servers minimizing remapping when nodes change','Password hashing','SQL query optimization','B'
FROM skills WHERE skill_name = 'System Design';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 4,
'What is the two-phase commit protocol?',
'A caching strategy','A distributed transaction protocol ensuring all nodes commit or rollback together','A leader election algorithm','A consensus algorithm','B'
FROM skills WHERE skill_name = 'System Design';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 4,
'What does idempotency mean in API design?',
'API requires authentication','Calling the same operation multiple times produces the same result','API returns JSON only','API has no state','B'
FROM skills WHERE skill_name = 'System Design';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 4,
'What is a bloom filter used for?',
'Full-text search','Probabilistic membership test to reduce expensive lookups','Sorting large datasets','Encrypting cache keys','B'
FROM skills WHERE skill_name = 'System Design';

-- Difficulty 5
INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 5,
'How does the Saga pattern handle distributed transactions?',
'Global two-phase commit','A sequence of local transactions with compensating transactions for rollback','Locking all services simultaneously','Eventual consistency without rollback','B'
FROM skills WHERE skill_name = 'System Design';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 5,
'What is the Raft consensus algorithm used for?',
'Load balancing','Electing a leader and replicating logs in a distributed cluster','Encrypting data at rest','CDN routing','B'
FROM skills WHERE skill_name = 'System Design';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 5,
'What is back-pressure in reactive systems?',
'CPU throttling','A mechanism for consumers to signal producers to slow down','Network congestion handling','Memory paging','B'
FROM skills WHERE skill_name = 'System Design';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 5,
'What is event sourcing?',
'Logging errors to a file','Persisting state changes as a sequence of immutable events','Publishing to a message queue','Writing to a relational database','B'
FROM skills WHERE skill_name = 'System Design';

INSERT INTO questions (question_id, skill_id, difficulty_level, question_text, option_a, option_b, option_c, option_d, correct_option)
SELECT seq_questions.NEXTVAL, skill_id, 5,
'What is CQRS stands for and why is it used?',
'Command Queue Request System – for caching','Command Query Responsibility Segregation – separates read and write models for scalability','Consistent Queue Replication Strategy','None of the above','B'
FROM skills WHERE skill_name = 'System Design';

COMMIT;

-- =========================================================
-- END OF SEED FILE
-- Sum: 15 (Java) + 15 (Python) + 15 (Data Structures)
--    + 25 (Web Dev) + 25 (DB Design) + 25 (ML)
--    + 25 (Cloud) + 25 (System Design) = 170 new rows
-- =========================================================
