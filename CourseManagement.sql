-- =============================================
-- COURSE MANAGEMENT SYSTEM DATABASE DESIGN
-- Microsoft SQL Server - ORGANIZED FOR SINGLE EXECUTION
-- =============================================

-- Create database
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'CourseManagementSystem')
BEGIN
    CREATE DATABASE CourseManagementSystem;
END
GO

USE CourseManagementSystem;
GO

-- =============================================
-- PART 1: CREATE BASIC TABLES (NO DEPENDENCIES)
-- =============================================

-- 1. ROLES TABLE (User roles)
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Roles' AND xtype='U')
BEGIN
    CREATE TABLE Roles (
        role_id INT PRIMARY KEY IDENTITY(1,1),
        role_name VARCHAR(20) NOT NULL UNIQUE,
        description NVARCHAR(255),
        created_at DATETIME2 DEFAULT GETDATE()
    );
END
GO

-- 2. CATEGORIES TABLE (Course categories)
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Categories' AND xtype='U')
BEGIN
    CREATE TABLE Categories (
        category_id INT PRIMARY KEY IDENTITY(1,1),
        category_name NVARCHAR(100) NOT NULL UNIQUE,
        description NVARCHAR(500),
        is_active BIT DEFAULT 1,
        created_at DATETIME2 DEFAULT GETDATE()
    );
END
GO

-- 3. SYSTEM_SETTINGS TABLE (System configuration)
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='SystemSettings' AND xtype='U')
BEGIN
    CREATE TABLE SystemSettings (
        setting_id INT PRIMARY KEY IDENTITY(1,1),
        setting_key VARCHAR(100) NOT NULL UNIQUE,
        setting_value NVARCHAR(MAX),
        description NVARCHAR(255),
        data_type VARCHAR(20) DEFAULT 'STRING', -- STRING, INT, BOOLEAN, JSON
        is_public BIT DEFAULT 0, -- Can be accessed from frontend
        created_at DATETIME2 DEFAULT GETDATE(),
        updated_at DATETIME2 DEFAULT GETDATE()
    );
END
GO

-- =============================================
-- PART 2: CREATE TABLES WITH SINGLE DEPENDENCIES
-- =============================================

-- 4. USERS TABLE (System users) - Depends on Roles
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Users' AND xtype='U')
BEGIN
    CREATE TABLE Users (
        user_id INT PRIMARY KEY IDENTITY(1,1),
        username VARCHAR(50) NOT NULL UNIQUE,
        email VARCHAR(100) NOT NULL UNIQUE,
        password_hash VARCHAR(255) NOT NULL, -- Encrypted password
        first_name NVARCHAR(50) NOT NULL,
        last_name NVARCHAR(50) NOT NULL,
        phone VARCHAR(20),
        date_of_birth DATE,
        role_id INT NOT NULL DEFAULT 2, -- Default is USER
        avatar_url VARCHAR(255) DEFAULT NULL, -- Reference to current image
        current_avatar_id INT, -- Will add FK constraint later
        is_active BIT DEFAULT 1,
        email_verified BIT DEFAULT 0,
        last_login DATETIME2,
        created_at DATETIME2 DEFAULT GETDATE(),
        updated_at DATETIME2 DEFAULT GETDATE(),
        
        CONSTRAINT FK_Users_Roles FOREIGN KEY (role_id) REFERENCES Roles(role_id),
        CONSTRAINT CK_Users_Email CHECK (email LIKE '%@%.%'),
        CONSTRAINT CK_Users_Phone CHECK (phone IS NULL OR LEN(phone) >= 10)
    );
END
GO

-- 5. USER_IMAGES TABLE (User image management) - Depends on Users
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='UserImages' AND xtype='U')
BEGIN
    CREATE TABLE UserImages (
        image_id INT PRIMARY KEY IDENTITY(1,1),
        user_id INT NOT NULL,
        image_name NVARCHAR(255) NOT NULL,
        image_path VARCHAR(500) NOT NULL,
        image_size BIGINT, -- File size in bytes
        image_type VARCHAR(20), -- jpg, jpeg, png, gif
        is_default BIT DEFAULT 0, -- User's default image
        upload_date DATETIME2 DEFAULT GETDATE(),
        
        CONSTRAINT FK_UserImages_Users FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
        CONSTRAINT CK_UserImages_Size CHECK (image_size IS NULL OR image_size > 0),
        CONSTRAINT CK_UserImages_Type CHECK (image_type IN ('jpg', 'jpeg', 'png', 'gif', 'webp'))
    );
END
GO

-- 6. COURSES TABLE (Course information) - Depends on Users and Categories
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Courses' AND xtype='U')
BEGIN
    CREATE TABLE Courses (
        course_id INT PRIMARY KEY IDENTITY(1,1),
        course_code VARCHAR(20) NOT NULL UNIQUE,
        title NVARCHAR(255) NOT NULL,
        description NVARCHAR(MAX),
        short_description NVARCHAR(500),
        teacher_id INT NOT NULL,
        category_id INT NOT NULL,
        image_url VARCHAR(255) DEFAULT 'assets/images/default-course.jpg', -- Default image
        price DECIMAL(10,2) DEFAULT 0,
        duration_hours INT DEFAULT 0,
        level VARCHAR(20) DEFAULT 'Beginner', -- Beginner, Intermediate, Advanced
        is_published BIT DEFAULT 0,
        is_active BIT DEFAULT 1,
        max_students INT DEFAULT 0, -- 0 = unlimited
        enrollment_start_date DATETIME2,
        enrollment_end_date DATETIME2,
        start_date DATETIME2,
        end_date DATETIME2,
        created_at DATETIME2 DEFAULT GETDATE(),
        updated_at DATETIME2 DEFAULT GETDATE(),
        
        CONSTRAINT FK_Courses_Teachers FOREIGN KEY (teacher_id) REFERENCES Users(user_id),
        CONSTRAINT FK_Courses_Categories FOREIGN KEY (category_id) REFERENCES Categories(category_id),
        CONSTRAINT CK_Courses_Level CHECK (level IN ('Beginner', 'Intermediate', 'Advanced')),
        CONSTRAINT CK_Courses_Price CHECK (price >= 0),
        CONSTRAINT CK_Courses_Duration CHECK (duration_hours >= 0)
    );
END
GO

-- =============================================
-- PART 3: CREATE TABLES WITH MULTIPLE DEPENDENCIES
-- =============================================

-- 7. ENROLLMENTS TABLE (Course enrollments) - Depends on Users and Courses
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Enrollments' AND xtype='U')
BEGIN
    CREATE TABLE Enrollments (
        enrollment_id INT PRIMARY KEY IDENTITY(1,1),
        student_id INT NOT NULL,
        course_id INT NOT NULL,
        enrollment_date DATETIME2 DEFAULT GETDATE(),
        completion_date DATETIME2,
        progress_percentage DECIMAL(5,2) DEFAULT 0,
        status VARCHAR(20) DEFAULT 'ACTIVE', -- ACTIVE, COMPLETED, DROPPED, SUSPENDED
        grade DECIMAL(5,2), -- Overall course grade
        certificate_issued BIT DEFAULT 0,
        
        CONSTRAINT FK_Enrollments_Students FOREIGN KEY (student_id) REFERENCES Users(user_id),
        CONSTRAINT FK_Enrollments_Courses FOREIGN KEY (course_id) REFERENCES Courses(course_id),
        CONSTRAINT UK_Enrollments_Student_Course UNIQUE (student_id, course_id),
        CONSTRAINT CK_Enrollments_Progress CHECK (progress_percentage >= 0 AND progress_percentage <= 100),
        CONSTRAINT CK_Enrollments_Status CHECK (status IN ('ACTIVE', 'COMPLETED', 'DROPPED', 'SUSPENDED')),
        CONSTRAINT CK_Enrollments_Grade CHECK (grade IS NULL OR (grade >= 0 AND grade <= 10))
    );
END
GO

-- 8. LESSONS TABLE (Course lessons) - Depends on Courses
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Lessons' AND xtype='U')
BEGIN
    CREATE TABLE Lessons (
        lesson_id INT PRIMARY KEY IDENTITY(1,1),
        course_id INT NOT NULL,
        title NVARCHAR(255) NOT NULL,
        content NVARCHAR(MAX),
        video_url VARCHAR(255),
        duration_minutes INT DEFAULT 0,
        order_number INT NOT NULL,
        is_published BIT DEFAULT 0,
        is_free BIT DEFAULT 0, -- Free lessons can be previewed
        created_at DATETIME2 DEFAULT GETDATE(),
        updated_at DATETIME2 DEFAULT GETDATE(),
        
        CONSTRAINT FK_Lessons_Courses FOREIGN KEY (course_id) REFERENCES Courses(course_id) ON DELETE CASCADE,
        CONSTRAINT UK_Lessons_Course_Order UNIQUE (course_id, order_number),
        CONSTRAINT CK_Lessons_Duration CHECK (duration_minutes >= 0),
        CONSTRAINT CK_Lessons_Order CHECK (order_number > 0)
    );
END
GO

-- 9. MATERIALS TABLE (Learning materials) - Depends on Lessons
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Materials' AND xtype='U')
BEGIN
    CREATE TABLE Materials (
        material_id INT PRIMARY KEY IDENTITY(1,1),
        lesson_id INT NOT NULL,
        title NVARCHAR(255) NOT NULL,
        description NVARCHAR(500),
        file_name NVARCHAR(255) NOT NULL,
        file_path VARCHAR(500) NOT NULL,
        file_size BIGINT, -- File size in bytes
        file_type VARCHAR(50), -- pdf, doc, ppt, etc.
        download_count INT DEFAULT 0,
        is_downloadable BIT DEFAULT 1,
        upload_date DATETIME2 DEFAULT GETDATE(),
        
        CONSTRAINT FK_Materials_Lessons FOREIGN KEY (lesson_id) REFERENCES Lessons(lesson_id) ON DELETE CASCADE,
        CONSTRAINT CK_Materials_FileSize CHECK (file_size IS NULL OR file_size > 0)
    );
END
GO

-- 10. LESSON_PROGRESS TABLE (Learning progress tracking) - Depends on Lessons and Users
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='LessonProgress' AND xtype='U')
BEGIN
    CREATE TABLE LessonProgress (
        progress_id INT PRIMARY KEY IDENTITY(1,1),
        lesson_id INT NOT NULL,
        student_id INT NOT NULL,
        is_completed BIT DEFAULT 0,
        completion_date DATETIME2,
        watch_time_minutes INT DEFAULT 0, -- Time watched
        last_watched_position INT DEFAULT 0, -- Last position in seconds
        
        CONSTRAINT FK_LessonProgress_Lessons FOREIGN KEY (lesson_id) REFERENCES Lessons(lesson_id) ON DELETE CASCADE,
        CONSTRAINT FK_LessonProgress_Students FOREIGN KEY (student_id) REFERENCES Users(user_id),
        CONSTRAINT UK_LessonProgress_Lesson_Student UNIQUE (lesson_id, student_id),
        CONSTRAINT CK_LessonProgress_WatchTime CHECK (watch_time_minutes >= 0),
        CONSTRAINT CK_LessonProgress_Position CHECK (last_watched_position >= 0)
    );
END
GO

-- 11. ASSIGNMENTS TABLE (Course assignments) - Depends on Courses and Lessons
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Assignments' AND xtype='U')
BEGIN
    CREATE TABLE Assignments (
        assignment_id INT PRIMARY KEY IDENTITY(1,1),
        course_id INT NOT NULL,
        lesson_id INT, -- Can belong to a specific lesson or not
        title NVARCHAR(255) NOT NULL,
        description NVARCHAR(MAX),
        instructions NVARCHAR(MAX),
        max_score DECIMAL(5,2) DEFAULT 100,
        weight DECIMAL(5,2) DEFAULT 1, -- Weight in overall course grade
        due_date DATETIME2,
        allow_late_submission BIT DEFAULT 0,
        late_penalty_percent DECIMAL(5,2) DEFAULT 0,
        max_attempts INT DEFAULT 1,
        is_published BIT DEFAULT 0,
        created_at DATETIME2 DEFAULT GETDATE(),
        updated_at DATETIME2 DEFAULT GETDATE(),
        
        CONSTRAINT FK_Assignments_Courses FOREIGN KEY (course_id) REFERENCES Courses(course_id) ON DELETE CASCADE,
        CONSTRAINT FK_Assignments_Lessons FOREIGN KEY (lesson_id) REFERENCES Lessons(lesson_id),
        CONSTRAINT CK_Assignments_MaxScore CHECK (max_score > 0),
        CONSTRAINT CK_Assignments_Weight CHECK (weight >= 0),
        CONSTRAINT CK_Assignments_LatePenalty CHECK (late_penalty_percent >= 0 AND late_penalty_percent <= 100),
        CONSTRAINT CK_Assignments_MaxAttempts CHECK (max_attempts > 0)
    );
END
GO

-- 12. SUBMISSIONS TABLE (Assignment submissions) - Depends on Assignments and Users
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Submissions' AND xtype='U')
BEGIN
    CREATE TABLE Submissions (
        submission_id INT PRIMARY KEY IDENTITY(1,1),
        assignment_id INT NOT NULL,
        student_id INT NOT NULL,
        attempt_number INT DEFAULT 1,
        content NVARCHAR(MAX), -- Text content of submission
        file_name NVARCHAR(255),
        file_path VARCHAR(500),
        submission_date DATETIME2 DEFAULT GETDATE(),
        is_late BIT DEFAULT 0,
        score DECIMAL(5,2),
        max_score DECIMAL(5,2),
        feedback NVARCHAR(MAX),
        graded_by INT, -- ID of the grader
        graded_date DATETIME2,
        status VARCHAR(20) DEFAULT 'SUBMITTED', -- SUBMITTED, GRADED, RETURNED
        
        CONSTRAINT FK_Submissions_Assignments FOREIGN KEY (assignment_id) REFERENCES Assignments(assignment_id) ON DELETE CASCADE,
        CONSTRAINT FK_Submissions_Students FOREIGN KEY (student_id) REFERENCES Users(user_id),
        CONSTRAINT FK_Submissions_Graders FOREIGN KEY (graded_by) REFERENCES Users(user_id),
        CONSTRAINT CK_Submissions_Score CHECK (score IS NULL OR score >= 0),
        CONSTRAINT CK_Submissions_MaxScore CHECK (max_score IS NULL OR max_score > 0),
        CONSTRAINT CK_Submissions_Attempt CHECK (attempt_number > 0),
        CONSTRAINT CK_Submissions_Status CHECK (status IN ('SUBMITTED', 'GRADED', 'RETURNED'))
    );
END
GO

-- 13. FORUM_TOPICS TABLE (Discussion topics) - Depends on Courses and Users
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='ForumTopics' AND xtype='U')
BEGIN
    CREATE TABLE ForumTopics (
        topic_id INT PRIMARY KEY IDENTITY(1,1),
        course_id INT NOT NULL,
        created_by INT NOT NULL,
        title NVARCHAR(255) NOT NULL,
        content NVARCHAR(MAX),
        is_pinned BIT DEFAULT 0,
        is_locked BIT DEFAULT 0,
        view_count INT DEFAULT 0,
        reply_count INT DEFAULT 0,
        created_at DATETIME2 DEFAULT GETDATE(),
        updated_at DATETIME2 DEFAULT GETDATE(),
        
        CONSTRAINT FK_ForumTopics_Courses FOREIGN KEY (course_id) REFERENCES Courses(course_id) ON DELETE CASCADE,
        CONSTRAINT FK_ForumTopics_Users FOREIGN KEY (created_by) REFERENCES Users(user_id)
    );
END
GO

-- 14. FORUM_REPLIES TABLE (Discussion replies) - Depends on ForumTopics and Users
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='ForumReplies' AND xtype='U')
BEGIN
    CREATE TABLE ForumReplies (
        reply_id INT PRIMARY KEY IDENTITY(1,1),
        topic_id INT NOT NULL,
        user_id INT NOT NULL,
        content NVARCHAR(MAX) NOT NULL,
        parent_reply_id INT, -- For nested replies
        is_deleted BIT DEFAULT 0,
        created_at DATETIME2 DEFAULT GETDATE(),
        updated_at DATETIME2 DEFAULT GETDATE(),
        
        CONSTRAINT FK_ForumReplies_Topics FOREIGN KEY (topic_id) REFERENCES ForumTopics(topic_id) ON DELETE CASCADE,
        CONSTRAINT FK_ForumReplies_Users FOREIGN KEY (user_id) REFERENCES Users(user_id),
        CONSTRAINT FK_ForumReplies_Parent FOREIGN KEY (parent_reply_id) REFERENCES ForumReplies(reply_id)
    );
END
GO

-- 15. NOTIFICATIONS TABLE (System notifications) - Depends on Users
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Notifications' AND xtype='U')
BEGIN
    CREATE TABLE Notifications (
        notification_id INT PRIMARY KEY IDENTITY(1,1),
        user_id INT NOT NULL,
        title NVARCHAR(255) NOT NULL,
        message NVARCHAR(MAX) NOT NULL,
        type VARCHAR(50) DEFAULT 'INFO', -- INFO, WARNING, SUCCESS, ERROR
        related_id INT, -- Related entity ID (course_id, assignment_id, etc.)
        related_type VARCHAR(50), -- COURSE, ASSIGNMENT, LESSON, etc.
        is_read BIT DEFAULT 0,
        created_at DATETIME2 DEFAULT GETDATE(),
        read_at DATETIME2,
        
        CONSTRAINT FK_Notifications_Users FOREIGN KEY (user_id) REFERENCES Users(user_id),
        CONSTRAINT CK_Notifications_Type CHECK (type IN ('INFO', 'WARNING', 'SUCCESS', 'ERROR'))
    );
END
GO

-- 16. COURSE_REVIEWS TABLE (Course ratings and reviews) - Depends on Courses and Users
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='CourseReviews' AND xtype='U')
BEGIN
    CREATE TABLE CourseReviews (
        review_id INT PRIMARY KEY IDENTITY(1,1),
        course_id INT NOT NULL,
        student_id INT NOT NULL,
        rating INT NOT NULL,
        comment NVARCHAR(MAX),
        is_anonymous BIT DEFAULT 0,
        created_at DATETIME2 DEFAULT GETDATE(),
        updated_at DATETIME2 DEFAULT GETDATE(),
        
        CONSTRAINT FK_CourseReviews_Courses FOREIGN KEY (course_id) REFERENCES Courses(course_id) ON DELETE CASCADE,
        CONSTRAINT FK_CourseReviews_Students FOREIGN KEY (student_id) REFERENCES Users(user_id),
        CONSTRAINT UK_CourseReviews_Course_Student UNIQUE (course_id, student_id),
        CONSTRAINT CK_CourseReviews_Rating CHECK (rating >= 1 AND rating <= 5)
    );
END
GO

-- =============================================
-- PART 4: ADD REMAINING FOREIGN KEY CONSTRAINTS
-- =============================================

-- Add FK constraint for Users.current_avatar_id after UserImages table exists
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK_Users_CurrentAvatar')
BEGIN
    ALTER TABLE Users ADD CONSTRAINT FK_Users_CurrentAvatar 
        FOREIGN KEY (current_avatar_id) REFERENCES UserImages(image_id);
END
GO

-- =============================================
-- PART 5: CREATE INDEXES FOR PERFORMANCE
-- =============================================

-- Users indexes
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Users_Email')
    CREATE INDEX IX_Users_Email ON Users(email);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Users_Username')
    CREATE INDEX IX_Users_Username ON Users(username);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Users_Role')
    CREATE INDEX IX_Users_Role ON Users(role_id);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Users_Active')
    CREATE INDEX IX_Users_Active ON Users(is_active);

-- UserImages indexes
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_UserImages_User')
    CREATE INDEX IX_UserImages_User ON UserImages(user_id);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_UserImages_Default')
    CREATE INDEX IX_UserImages_Default ON UserImages(user_id, is_default);

-- Courses indexes
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Courses_Teacher')
    CREATE INDEX IX_Courses_Teacher ON Courses(teacher_id);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Courses_Category')
    CREATE INDEX IX_Courses_Category ON Courses(category_id);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Courses_Published')
    CREATE INDEX IX_Courses_Published ON Courses(is_published);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Courses_Active')
    CREATE INDEX IX_Courses_Active ON Courses(is_active);

-- Enrollments indexes
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Enrollments_Student')
    CREATE INDEX IX_Enrollments_Student ON Enrollments(student_id);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Enrollments_Course')
    CREATE INDEX IX_Enrollments_Course ON Enrollments(course_id);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Enrollments_Status')
    CREATE INDEX IX_Enrollments_Status ON Enrollments(status);

-- Lessons indexes
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Lessons_Course')
    CREATE INDEX IX_Lessons_Course ON Lessons(course_id);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Lessons_Order')
    CREATE INDEX IX_Lessons_Order ON Lessons(course_id, order_number);

-- Assignments indexes
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Assignments_Course')
    CREATE INDEX IX_Assignments_Course ON Assignments(course_id);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Assignments_DueDate')
    CREATE INDEX IX_Assignments_DueDate ON Assignments(due_date);

-- Submissions indexes
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Submissions_Assignment')
    CREATE INDEX IX_Submissions_Assignment ON Submissions(assignment_id);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Submissions_Student')
    CREATE INDEX IX_Submissions_Student ON Submissions(student_id);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Submissions_Status')
    CREATE INDEX IX_Submissions_Status ON Submissions(status);

-- Notifications indexes
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Notifications_User')
    CREATE INDEX IX_Notifications_User ON Notifications(user_id);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Notifications_Read')
    CREATE INDEX IX_Notifications_Read ON Notifications(is_read);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Notifications_Created')
    CREATE INDEX IX_Notifications_Created ON Notifications(created_at);

GO

-- =============================================
-- PART 6: INSERT DEFAULT DATA
-- =============================================

-- Insert roles if not exist
IF NOT EXISTS (SELECT * FROM Roles WHERE role_name = 'GUEST')
    INSERT INTO Roles (role_name, description) VALUES ('GUEST', 'Guest users who can only view public information');

IF NOT EXISTS (SELECT * FROM Roles WHERE role_name = 'USER')
    INSERT INTO Roles (role_name, description) VALUES ('USER', 'Basic users who can enroll in courses');

IF NOT EXISTS (SELECT * FROM Roles WHERE role_name = 'TEACHER')
    INSERT INTO Roles (role_name, description) VALUES ('TEACHER', 'Teachers who can create and manage courses');

IF NOT EXISTS (SELECT * FROM Roles WHERE role_name = 'ADMIN')
    INSERT INTO Roles (role_name, description) VALUES ('ADMIN', 'System administrators');

-- Insert categories if not exist
IF NOT EXISTS (SELECT * FROM Categories WHERE category_name = 'Programming')
    INSERT INTO Categories (category_name, description) VALUES ('Programming', 'Courses about programming and software development');

IF NOT EXISTS (SELECT * FROM Categories WHERE category_name = 'Design')
    INSERT INTO Categories (category_name, description) VALUES ('Design', 'Courses about graphic design and UI/UX');

IF NOT EXISTS (SELECT * FROM Categories WHERE category_name = 'Business')
    INSERT INTO Categories (category_name, description) VALUES ('Business', 'Courses about business management and marketing');

IF NOT EXISTS (SELECT * FROM Categories WHERE category_name = 'Language')
    INSERT INTO Categories (category_name, description) VALUES ('Language', 'Foreign language courses');

IF NOT EXISTS (SELECT * FROM Categories WHERE category_name = 'Other')
    INSERT INTO Categories (category_name, description) VALUES ('Other', 'Other miscellaneous courses');

-- Insert system settings if not exist
IF NOT EXISTS (SELECT * FROM SystemSettings WHERE setting_key = 'DEFAULT_COURSE_IMAGE')
    INSERT INTO SystemSettings (setting_key, setting_value, description, data_type, is_public) 
    VALUES ('DEFAULT_COURSE_IMAGE', 'assets/images/default-course.jpg', 'Default image for courses', 'STRING', 1);

IF NOT EXISTS (SELECT * FROM SystemSettings WHERE setting_key = 'DEFAULT_AVATAR_IMAGE')
    INSERT INTO SystemSettings (setting_key, setting_value, description, data_type, is_public) 
    VALUES ('DEFAULT_AVATAR_IMAGE', 'assets/images/avatars/default-avatar.jpg', 'Default avatar image', 'STRING', 1);

IF NOT EXISTS (SELECT * FROM SystemSettings WHERE setting_key = 'MAX_FILE_SIZE_MB')
    INSERT INTO SystemSettings (setting_key, setting_value, description, data_type, is_public) 
    VALUES ('MAX_FILE_SIZE_MB', '50', 'Maximum file upload size in MB', 'INT', 0);

IF NOT EXISTS (SELECT * FROM SystemSettings WHERE setting_key = 'ALLOWED_FILE_TYPES')
    INSERT INTO SystemSettings (setting_key, setting_value, description, data_type, is_public) 
    VALUES ('ALLOWED_FILE_TYPES', 'pdf,doc,docx,ppt,pptx,xls,xlsx,jpg,jpeg,png,gif,mp4,avi', 'Allowed file types for upload', 'STRING', 0);

IF NOT EXISTS (SELECT * FROM SystemSettings WHERE setting_key = 'SYSTEM_EMAIL')
    INSERT INTO SystemSettings (setting_key, setting_value, description, data_type, is_public) 
    VALUES ('SYSTEM_EMAIL', 'admin@coursemanagement.com', 'System email address', 'STRING', 0);

IF NOT EXISTS (SELECT * FROM SystemSettings WHERE setting_key = 'ENABLE_EMAIL_NOTIFICATIONS')
    INSERT INTO SystemSettings (setting_key, setting_value, description, data_type, is_public) 
    VALUES ('ENABLE_EMAIL_NOTIFICATIONS', 'true', 'Enable email notifications', 'BOOLEAN', 0);

IF NOT EXISTS (SELECT * FROM SystemSettings WHERE setting_key = 'AVATAR_UPLOAD_PATH')
    INSERT INTO SystemSettings (setting_key, setting_value, description, data_type, is_public) 
    VALUES ('AVATAR_UPLOAD_PATH', 'assets/images/avatars/', 'Directory for avatar uploads', 'STRING', 0);

IF NOT EXISTS (SELECT * FROM SystemSettings WHERE setting_key = 'COURSE_IMAGE_UPLOAD_PATH')
    INSERT INTO SystemSettings (setting_key, setting_value, description, data_type, is_public) 
    VALUES ('COURSE_IMAGE_UPLOAD_PATH', 'assets/images/courses/', 'Directory for course image uploads', 'STRING', 0);

IF NOT EXISTS (SELECT * FROM SystemSettings WHERE setting_key = 'MAX_AVATAR_SIZE_MB')
    INSERT INTO SystemSettings (setting_key, setting_value, description, data_type, is_public) 
    VALUES ('MAX_AVATAR_SIZE_MB', '5', 'Maximum avatar image size in MB', 'INT', 0);

IF NOT EXISTS (SELECT * FROM SystemSettings WHERE setting_key = 'ALLOWED_IMAGE_TYPES')
    INSERT INTO SystemSettings (setting_key, setting_value, description, data_type, is_public) 
    VALUES ('ALLOWED_IMAGE_TYPES', 'jpg,jpeg,png,gif,webp', 'Allowed image file types', 'STRING', 0);

GO

-- =============================================
-- PART 7: CREATE TRIGGERS
-- =============================================

-- Trigger to update updated_at for Users
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE name = 'TR_Users_UpdatedAt')
BEGIN
    EXEC('
    CREATE TRIGGER TR_Users_UpdatedAt ON Users
    AFTER UPDATE AS
    BEGIN
        UPDATE Users 
        SET updated_at = GETDATE()
        WHERE user_id IN (SELECT user_id FROM inserted);
    END
    ');
END
GO

-- Trigger to update updated_at for Courses
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE name = 'TR_Courses_UpdatedAt')
BEGIN
    EXEC('
    CREATE TRIGGER TR_Courses_UpdatedAt ON Courses
    AFTER UPDATE AS
    BEGIN
        UPDATE Courses 
        SET updated_at = GETDATE()
        WHERE course_id IN (SELECT course_id FROM inserted);
    END
    ');
END
GO

-- Trigger to ensure only one default image per user
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE name = 'TR_UserImages_DefaultUnique')
BEGIN
    EXEC('
    CREATE TRIGGER TR_UserImages_DefaultUnique ON UserImages
    AFTER INSERT, UPDATE AS
    BEGIN
        -- When setting an image as default, remove default from other images
        IF EXISTS(SELECT * FROM inserted WHERE is_default = 1)
        BEGIN
            UPDATE UserImages 
            SET is_default = 0
            WHERE user_id IN (SELECT user_id FROM inserted WHERE is_default = 1)
                AND image_id NOT IN (SELECT image_id FROM inserted WHERE is_default = 1)
                AND is_default = 1;
        END
    END
    ');
END
GO

-- Trigger to update reply count in ForumTopics
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE name = 'TR_ForumReplies_UpdateCount')
BEGIN
    EXEC('
    CREATE TRIGGER TR_ForumReplies_UpdateCount ON ForumReplies
    AFTER INSERT, DELETE AS
    BEGIN
        -- Update reply_count when adding reply
        IF EXISTS(SELECT * FROM inserted)
        BEGIN
            UPDATE ForumTopics 
            SET reply_count = reply_count + 1,
                updated_at = GETDATE()
            WHERE topic_id IN (SELECT DISTINCT topic_id FROM inserted);
        END
        
        -- Update reply_count when deleting reply
        IF EXISTS(SELECT * FROM deleted)
        BEGIN
            UPDATE ForumTopics 
            SET reply_count = reply_count - 1,
                updated_at = GETDATE()
            WHERE topic_id IN (SELECT DISTINCT topic_id FROM deleted);
        END
    END
    ');
END
GO

-- =============================================
-- PART 8: CREATE STORED PROCEDURES
-- =============================================

-- Procedure to calculate course progress for a student
IF NOT EXISTS (SELECT * FROM sys.procedures WHERE name = 'SP_CalculateCourseProgress')
BEGIN
    EXEC('
    CREATE PROCEDURE SP_CalculateCourseProgress
        @student_id INT,
        @course_id INT
    AS
    BEGIN
        DECLARE @total_lessons INT;
        DECLARE @completed_lessons INT;
        DECLARE @progress DECIMAL(5,2);
        
        SELECT @total_lessons = COUNT(*) 
        FROM Lessons 
        WHERE course_id = @course_id AND is_published = 1;
        
        SELECT @completed_lessons = COUNT(*) 
        FROM LessonProgress lp
        INNER JOIN Lessons l ON lp.lesson_id = l.lesson_id
        WHERE lp.student_id = @student_id 
            AND l.course_id = @course_id 
            AND lp.is_completed = 1
            AND l.is_published = 1;
        
        IF @total_lessons > 0
            SET @progress = (@completed_lessons * 100.0) / @total_lessons;
        ELSE
            SET @progress = 0;
        
        UPDATE Enrollments 
        SET progress_percentage = @progress
        WHERE student_id = @student_id AND course_id = @course_id;
        
        SELECT @progress as progress_percentage;
    END
    ');
END
GO

-- Procedure to create notification
IF NOT EXISTS (SELECT * FROM sys.procedures WHERE name = 'SP_CreateNotification')
BEGIN
    EXEC('
    CREATE PROCEDURE SP_CreateNotification
        @user_id INT,
        @title NVARCHAR(255),
        @message NVARCHAR(MAX),
        @type VARCHAR(50) = ''INFO'',
        @related_id INT = NULL,
        @related_type VARCHAR(50) = NULL
    AS
    BEGIN
        INSERT INTO Notifications (user_id, title, message, type, related_id, related_type)
        VALUES (@user_id, @title, @message, @type, @related_id, @related_type);
    END
    ');
END
GO

-- Procedure to upload new user image
IF NOT EXISTS (SELECT * FROM sys.procedures WHERE name = 'SP_UploadUserImage')
BEGIN
    EXEC('
    CREATE PROCEDURE SP_UploadUserImage
        @user_id INT,
        @image_name NVARCHAR(255),
        @image_path VARCHAR(500),
        @image_size BIGINT,
        @image_type VARCHAR(20),
        @set_as_default BIT = 0
    AS
    BEGIN
        DECLARE @new_image_id INT;
        
        -- Add new image
        INSERT INTO UserImages (user_id, image_name, image_path, image_size, image_type, is_default)
        VALUES (@user_id, @image_name, @image_path, @image_size, @image_type, @set_as_default);
        
        SET @new_image_id = SCOPE_IDENTITY();
        
        -- If set as default, update current_avatar_id
        IF @set_as_default = 1
        BEGIN
            UPDATE Users 
            SET current_avatar_id = @new_image_id
            WHERE user_id = @user_id;
        END
        
        SELECT @new_image_id as image_id;
    END
    ');
END
GO

-- Procedure to set default user image
IF NOT EXISTS (SELECT * FROM sys.procedures WHERE name = 'SP_SetDefaultUserImage')
BEGIN
    EXEC('
    CREATE PROCEDURE SP_SetDefaultUserImage
        @user_id INT,
        @image_id INT
    AS
    BEGIN
        -- Check if image belongs to user
        IF EXISTS(SELECT 1 FROM UserImages WHERE image_id = @image_id AND user_id = @user_id)
        BEGIN
            -- Remove default from all user images
            UPDATE UserImages 
            SET is_default = 0 
            WHERE user_id = @user_id;
            
            -- Set selected image as default
            UPDATE UserImages 
            SET is_default = 1 
            WHERE image_id = @image_id;
            
            -- Update current_avatar_id
            UPDATE Users 
            SET current_avatar_id = @image_id
            WHERE user_id = @user_id;
            
            SELECT ''SUCCESS'' as result;
        END
        ELSE
        BEGIN
            SELECT ''ERROR: Image not found or not belongs to user'' as result;
        END
    END
    ');
END
GO

-- Procedure to reset to default system avatar
IF NOT EXISTS (SELECT * FROM sys.procedures WHERE name = 'SP_ResetToDefaultAvatar')
BEGIN
    EXEC('
    CREATE PROCEDURE SP_ResetToDefaultAvatar
        @user_id INT
    AS
    BEGIN
        -- Remove default from all user images
        UPDATE UserImages 
        SET is_default = 0 
        WHERE user_id = @user_id;
        
        -- Set current_avatar_id to NULL (will use system default image)
        UPDATE Users 
        SET current_avatar_id = NULL
        WHERE user_id = @user_id;
        
        SELECT ''SUCCESS'' as result;
    END
    ');
END
GO

-- =============================================
-- PART 9: CREATE VIEWS
-- =============================================

-- View for course details with teacher information
IF NOT EXISTS (SELECT * FROM sys.views WHERE name = 'VW_CourseDetails')
BEGIN
    EXEC('
    CREATE VIEW VW_CourseDetails AS
    SELECT 
        c.course_id,
        c.course_code,
        c.title,
        c.description,
        c.short_description,
        c.image_url,
        c.price,
        c.duration_hours,
        c.level,
        c.is_published,
        c.is_active,
        c.max_students,
        c.start_date,
        c.end_date,
        c.created_at,
        u.first_name + '' '' + u.last_name as teacher_name,
        u.email as teacher_email,
        cat.category_name,
        (SELECT COUNT(*) FROM Enrollments e WHERE e.course_id = c.course_id AND e.status = ''ACTIVE'') as enrolled_count,
        (SELECT AVG(CAST(rating as FLOAT)) FROM CourseReviews cr WHERE cr.course_id = c.course_id) as average_rating,
        (SELECT COUNT(*) FROM CourseReviews cr WHERE cr.course_id = c.course_id) as review_count
    FROM Courses c
    INNER JOIN Users u ON c.teacher_id = u.user_id
    INNER JOIN Categories cat ON c.category_id = cat.category_id
    ');
END
GO

-- View for student enrollment information
IF NOT EXISTS (SELECT * FROM sys.views WHERE name = 'VW_StudentEnrollments')
BEGIN
    EXEC('
    CREATE VIEW VW_StudentEnrollments AS
    SELECT 
        e.enrollment_id,
        e.student_id,
        e.course_id,
        e.enrollment_date,
        e.progress_percentage,
        e.status,
        e.grade,
        u.first_name + '' '' + u.last_name as student_name,
        u.email as student_email,
        c.title as course_title,
        c.course_code
    FROM Enrollments e
    INNER JOIN Users u ON e.student_id = u.user_id
    INNER JOIN Courses c ON e.course_id = c.course_id
    ');
END
GO

-- View for user profiles with avatar information
IF NOT EXISTS (SELECT * FROM sys.views WHERE name = 'VW_UserProfiles')
BEGIN
    EXEC('
    CREATE VIEW VW_UserProfiles AS
    SELECT 
        u.user_id,
        u.username,
        u.email,
        u.first_name,
        u.last_name,
        u.first_name + '' '' + u.last_name as full_name,
        u.phone,
        u.date_of_birth,
        u.is_active,
        u.email_verified,
        u.last_login,
        u.created_at,
        r.role_name,
        CASE 
            WHEN u.current_avatar_id IS NOT NULL THEN ui.image_path
            ELSE (SELECT setting_value FROM SystemSettings WHERE setting_key = ''DEFAULT_AVATAR_IMAGE'')
        END as avatar_url,
        ui.image_id as current_avatar_image_id
    FROM Users u
    INNER JOIN Roles r ON u.role_id = r.role_id
    LEFT JOIN UserImages ui ON u.current_avatar_id = ui.image_id
    ');
END
GO

-- =============================================
-- FINAL SUCCESS MESSAGE
-- =============================================

PRINT 'Database CourseManagementSystem created successfully!';
