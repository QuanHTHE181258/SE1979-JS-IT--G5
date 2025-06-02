-- pass: Anhquoc@123
INSERT INTO Users (username,
                   email,
                   password_hash,
                   first_name,
                   last_name,
                   phone,
                   date_of_birth,
                   role_id,
                   avatar_url,
                   is_active,
                   email_verified,
                   last_login)
VALUES ('johndoe123',
        'johndoe@example.com',
        '$2a$10$CuuAENEH6t.IGBYHyyiyNO8EXT6KpcsI0eEzKLR9NURTSPSUs2PJO',
        'John',
        'Doe',
        '0123456789',
        '1995-08-15',
        3,
        'https://example.com/avatars/1.jpg',
        1,
        1,
        GETDATE());
INSERT INTO Courses (course_code, title, description, short_description, teacher_id, category_id,
                     price, duration_hours, level, is_published, is_active, max_students,
                     enrollment_start_date, enrollment_end_date, start_date, end_date)
VALUES ('CS101', 'Intro to Programming', 'Learn the basics of programming using Python.',
        'Basic Python course for beginners.', 1, 1, 49.99, 30, 'Beginner', 1, 1, 100, '2025-06-01', '2025-06-15',
        '2025-06-20', '2025-08-20'),
       ('WD201', 'Web Development with HTML/CSS', 'Master front-end web development skills.',
        'Learn HTML & CSS from scratch.', 1, 2, 59.99, 40, 'Beginner', 1, 1, 50, '2025-06-05', '2025-06-25',
        '2025-07-01', '2025-08-30'),
       ('JS301', 'JavaScript Essentials', 'A complete guide to modern JavaScript.', 'Intermediate JavaScript concepts.',
        1, 2, 79.99, 35, 'Intermediate', 1, 1, 75, '2025-07-01', '2025-07-10', '2025-07-15', '2025-09-15'),
       ('DB401', 'SQL & Databases', 'In-depth course on SQL and relational databases.',
        'Master SQL for data manipulation.', 1, 3, 99.99, 45, 'Advanced', 1, 1, 40, '2025-06-10', '2025-06-20',
        '2025-06-25', '2025-08-25'),
       ('ML101', 'Intro to Machine Learning', 'Get started with ML concepts and tools.',
        'Machine Learning for beginners.', 1, 4, 120.00, 50, 'Beginner', 0, 1, 0, '2025-08-01', '2025-08-15',
        '2025-08-20', '2025-10-20'),
       ('PY201', 'Python for Data Analysis', 'Data analysis using Python libraries.',
        'Learn pandas, NumPy, matplotlib.', 1, 4, 89.50, 40, 'Intermediate', 1, 1, 30, '2025-06-15', '2025-07-01',
        '2025-07-05', '2025-09-05'),
       ('AI501', 'Advanced AI Concepts', 'Deep dive into neural networks and AI.', 'Advanced AI and deep learning.', 1,
        4, 199.99, 60, 'Advanced', 1, 1, 25, '2025-09-01', '2025-09-10', '2025-09-15', '2025-11-15'),
       ('UX101', 'UX/UI Design Basics', 'Learn design thinking and user experience.', 'UX fundamentals and tools.', 1,
        5, 69.99, 30, 'Beginner', 1, 1, 60, '2025-07-10', '2025-07-25', '2025-08-01', '2025-09-30'),
       ('CS202', 'Data Structures', 'Understand core data structures in programming.',
        'In-depth coding with structures.', 1, 1, 79.99, 35, 'Intermediate', 0, 1, 40, '2025-07-15', '2025-07-30',
        '2025-08-05', '2025-10-05'),
       ('PM101', 'Project Management Fundamentals', 'Learn how to lead and manage projects.',
        'PM basics including Agile.', 1, 5, 59.00, 25, 'Beginner', 1, 1, 80, '2025-06-01', '2025-06-15', '2025-06-20',
        '2025-08-01');
-- CS101
INSERT INTO Lessons (course_id, title, content, video_url, duration_minutes, order_number, is_published, is_free)
VALUES (1, 'Introduction to Programming', 'Overview of programming concepts and tools.', 'videos/cs101_intro.mp4', 15,
        1, 1, 1),
       (1, 'Variables and Data Types', 'Learn about variables, types, and syntax in Python.',
        'videos/cs101_variables.mp4', 20, 2, 1, 0);

-- WD201
INSERT INTO Lessons (course_id, title, content, video_url, duration_minutes, order_number, is_published, is_free)
VALUES (2, 'HTML Basics', 'Learn the structure of web pages using HTML.', 'videos/wd201_html.mp4', 18, 1, 1, 1),
       (2, 'CSS Styling', 'Style your HTML content with CSS.', 'videos/wd201_css.mp4', 25, 2, 1, 0);

-- JS301
INSERT INTO Lessons (course_id, title, content, video_url, duration_minutes, order_number, is_published, is_free)
VALUES (3, 'JavaScript Syntax & Variables', 'Introduction to JS syntax and variables.', 'videos/js301_syntax.mp4', 22,
        1, 1, 1),
       (3, 'Control Structures', 'Learn about if-else and loops.', 'videos/js301_control.mp4', 27, 2, 1, 0);

-- DB401
INSERT INTO Lessons (course_id, title, content, video_url, duration_minutes, order_number, is_published, is_free)
VALUES (4, 'Introduction to Databases', 'Understand what a database is and types of databases.',
        'videos/db401_intro.mp4', 20, 1, 1, 1),
       (4, 'Basic SQL Queries', 'Learn SELECT, INSERT, UPDATE, DELETE.', 'videos/db401_sql.mp4', 30, 2, 1, 0);

-- ML101
INSERT INTO Lessons (course_id, title, content, video_url, duration_minutes, order_number, is_published, is_free)
VALUES (5, 'What is Machine Learning?', 'Intro to ML and its applications.', 'videos/ml101_intro.mp4', 15, 1, 0, 1),
       (5, 'Supervised vs Unsupervised Learning', 'Key differences and examples.', 'videos/ml101_types.mp4', 25, 2, 0,
        0);

-- PY201
INSERT INTO Lessons (course_id, title, content, video_url, duration_minutes, order_number, is_published, is_free)
VALUES (6, 'Introduction to Pandas', 'DataFrames, Series, and basic data ops.', 'videos/py201_pandas.mp4', 30, 1, 1, 1),
       (6, 'Data Visualization with Matplotlib', 'Create plots and graphs in Python.', 'videos/py201_plot.mp4', 28, 2,
        1, 0);

-- AI501
INSERT INTO Lessons (course_id, title, content, video_url, duration_minutes, order_number, is_published, is_free)
VALUES (7, 'Neural Networks Overview', 'Understanding layers and activation functions.', 'videos/ai501_nn.mp4', 35, 1,
        1, 0),
       (7, 'Backpropagation Algorithm', 'How models learn by minimizing error.', 'videos/ai501_backprop.mp4', 40, 2, 1,
        0);

-- UX101
INSERT INTO Lessons (course_id, title, content, video_url, duration_minutes, order_number, is_published, is_free)
VALUES (8, 'What is UX Design?', 'Understanding user experience and usability.', 'videos/ux101_intro.mp4', 18, 1, 1, 1),
       (8, 'Design Tools Overview', 'Explore tools like Figma, Adobe XD.', 'videos/ux101_tools.mp4', 22, 2, 1, 0);

-- CS202
INSERT INTO Lessons (course_id, title, content, video_url, duration_minutes, order_number, is_published, is_free)
VALUES (9, 'Arrays and Linked Lists', 'Basic structure and usage in memory.', 'videos/cs202_array.mp4', 25, 1, 0, 1),
       (9, 'Stacks and Queues', 'LIFO and FIFO explained.', 'videos/cs202_stack.mp4', 28, 2, 0, 0);

-- PM101
INSERT INTO Lessons (course_id, title, content, video_url, duration_minutes, order_number, is_published, is_free)
VALUES (10, 'Project Life Cycle', 'Phases from initiation to closure.', 'videos/pm101_lifecycle.mp4', 20, 1, 1, 1),
       (10, 'Agile Methodologies', 'Learn about Scrum, Kanban, and sprints.', 'videos/pm101_agile.mp4', 30, 2, 1, 0);
