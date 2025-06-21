-- TẠO DATABASE
IF DB_ID('CourseManagementSystem') IS NULL
    CREATE DATABASE CourseManagementSystem;
GO

USE CourseManagementSystem;
GO

-- USERS
CREATE TABLE users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    Username NVARCHAR(50) NOT NULL UNIQUE,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(255) NOT NULL,
    FirstName NVARCHAR(20),
    LastName NVARCHAR(20)
    AvatarURL NVARCHAR(255),
    PhoneNumber NVARCHAR(20),
    DateOfBirth DATE,
    LastLogin DATETIME,
    CreatedAt DATETIME DEFAULT GETDATE()
);

-- USER AVATARS
CREATE TABLE user_avatars (
    AvatarID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL,
    ImageURL NVARCHAR(255),
    IsDefault BIT DEFAULT 0,
    UploadedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES users(UserID) ON DELETE CASCADE
);

-- ROLES
CREATE TABLE roles (
    RoleID INT IDENTITY(1,1) PRIMARY KEY,
    RoleName NVARCHAR(50) NOT NULL UNIQUE -- Guest, User, Teacher, Admin, etc.
);

-- USER ROLES 
CREATE TABLE user_roles (
    UserID INT NOT NULL,
    RoleID INT NOT NULL,
    PRIMARY KEY (UserID, RoleID),
    FOREIGN KEY (UserID) REFERENCES users(UserID) ON DELETE CASCADE,
    FOREIGN KEY (RoleID) REFERENCES roles(RoleID) ON DELETE CASCADE
);

-- COURSES
CREATE TABLE courses (
    CourseID INT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(255) NOT NULL,
    Description NVARCHAR(MAX),
    Price DECIMAL(10,2),
    Rating FLOAT DEFAULT 0,
    CreatedAt DATETIME DEFAULT GETDATE(),
    ImageURL NVARCHAR(255),
    InstructorID INT,
    FOREIGN KEY (InstructorID) REFERENCES users(UserID)
);

-- LESSONS
CREATE TABLE lessons (
    LessonID INT IDENTITY(1,1) PRIMARY KEY,
    CourseID INT NOT NULL,
    Title NVARCHAR(255),
    Content NVARCHAR(MAX),
    Status NVARCHAR(20),
    IsFreePreview BIT DEFAULT 0,
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (CourseID) REFERENCES courses(CourseID) ON DELETE CASCADE
);

-- MATERIALS
CREATE TABLE materials (
    MaterialID INT IDENTITY(1,1) PRIMARY KEY,
    LessonID INT NOT NULL,
    Title NVARCHAR(255),
    FileURL NVARCHAR(255),
    FOREIGN KEY (LessonID) REFERENCES lessons(LessonID) ON DELETE CASCADE
);

-- QUIZZES
CREATE TABLE quizzes (
    QuizID INT IDENTITY(1,1) PRIMARY KEY,
    LessonID INT NOT NULL,
    Title NVARCHAR(255),
    FOREIGN KEY (LessonID) REFERENCES lessons(LessonID) ON DELETE CASCADE
);

-- QUESTIONS
CREATE TABLE questions (
    QuestionID INT IDENTITY(1,1) PRIMARY KEY,
    QuizID INT NOT NULL,
    QuestionText NVARCHAR(MAX),
    FOREIGN KEY (QuizID) REFERENCES quizzes(QuizID) ON DELETE CASCADE
);

-- ANSWERS
CREATE TABLE answers (
    AnswerID INT IDENTITY(1,1) PRIMARY KEY,
    QuestionID INT NOT NULL,
    AnswerText NVARCHAR(MAX),
    IsCorrect BIT DEFAULT 0,
    FOREIGN KEY (QuestionID) REFERENCES questions(QuestionID) ON DELETE CASCADE
);

-- CART
CREATE TABLE cart (
    CartID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL,
    Status NVARCHAR(20) CHECK (Status IN ('active', 'completed')) DEFAULT 'active',
    TotalPrice DECIMAL(10,2) DEFAULT 0,
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES users(UserID)
);

-- CART ITEMS
CREATE TABLE cartitem (
    CartItemID INT IDENTITY(1,1) PRIMARY KEY,
    CartID INT NOT NULL,
    CourseID INT NOT NULL,
    Price DECIMAL(10,2),
    FOREIGN KEY (CartID) REFERENCES cart(CartID) ON DELETE CASCADE,
    FOREIGN KEY (CourseID) REFERENCES courses(CourseID)
);

-- ORDERS
CREATE TABLE orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL,
    Status NVARCHAR(20) CHECK (Status IN ('pending', 'paid', 'cancelled')) DEFAULT 'pending',
    PaymentMethod NVARCHAR(50), -- chỉ dùng VNPAY hiện tại
    TotalAmount DECIMAL(10,2),
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES users(UserID)
);

-- ORDER DETAILS
CREATE TABLE orderdetails (
    OrderDetailID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT NOT NULL,
    CourseID INT NOT NULL,
    Price DECIMAL(10,2),
    FOREIGN KEY (OrderID) REFERENCES orders(OrderID) ON DELETE CASCADE,
    FOREIGN KEY (CourseID) REFERENCES courses(CourseID)
);

-- FEEDBACK
CREATE TABLE feedback (
    FeedbackID INT IDENTITY(1,1) PRIMARY KEY,
    CourseID INT NOT NULL,
    UserID INT NOT NULL,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Comment NVARCHAR(MAX),
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (CourseID) REFERENCES courses(CourseID),
    FOREIGN KEY (UserID) REFERENCES users(UserID),
    CONSTRAINT UQ_Feedback_User_Course UNIQUE (UserID, CourseID)
);

-- QUIZ ATTEMPTS
CREATE TABLE quiz_attempts (
    AttemptID INT IDENTITY(1,1) PRIMARY KEY,
    QuizID INT NOT NULL,
    UserID INT NOT NULL,
    StartTime DATETIME DEFAULT GETDATE(),
    EndTime DATETIME,
    Score FLOAT DEFAULT 0,
    FOREIGN KEY (QuizID) REFERENCES quizzes(QuizID) ON DELETE CASCADE,
    FOREIGN KEY (UserID) REFERENCES users(UserID) ON DELETE CASCADE
);

-- QUESTION ATTEMPTS
CREATE TABLE question_attempts (
    AttemptID INT NOT NULL,
    QuestionID INT NOT NULL,
    SelectedAnswerID INT,
    IsCorrect BIT,
    PRIMARY KEY (AttemptID, QuestionID),
    FOREIGN KEY (AttemptID) REFERENCES quiz_attempts(AttemptID) ON DELETE CASCADE,
    FOREIGN KEY (QuestionID) REFERENCES questions(QuestionID),
    FOREIGN KEY (SelectedAnswerID) REFERENCES answers(AnswerID)
);

-- COURSE PROGRESS
CREATE TABLE course_progress (
    UserID INT NOT NULL,
    CourseID INT NOT NULL,
    CompletedLessons INT DEFAULT 0,
    TotalLessons INT DEFAULT 0,
    ProgressPercent FLOAT DEFAULT 0,
    LastAccessed DATETIME DEFAULT GETDATE(),
    PRIMARY KEY (UserID, CourseID),
    FOREIGN KEY (UserID) REFERENCES users(UserID) ON DELETE CASCADE,
    FOREIGN KEY (CourseID) REFERENCES courses(CourseID) ON DELETE CASCADE
);
