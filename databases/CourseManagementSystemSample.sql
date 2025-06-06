USE [master]
GO
/****** Object:  Database [CourseManagementSystem]    Script Date: 5/26/2025 1:47:53 AM ******/
CREATE DATABASE [CourseManagementSystemSp]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CourseManagementSystem', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\CourseManagementSystem.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'CourseManagementSystem_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\CourseManagementSystem_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [CourseManagementSystem] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CourseManagementSystem].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CourseManagementSystem] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CourseManagementSystem] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CourseManagementSystem] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CourseManagementSystem] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CourseManagementSystem] SET ARITHABORT OFF 
GO
ALTER DATABASE [CourseManagementSystem] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [CourseManagementSystem] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CourseManagementSystem] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CourseManagementSystem] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CourseManagementSystem] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CourseManagementSystem] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CourseManagementSystem] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CourseManagementSystem] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CourseManagementSystem] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CourseManagementSystem] SET  ENABLE_BROKER 
GO
ALTER DATABASE [CourseManagementSystem] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CourseManagementSystem] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CourseManagementSystem] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CourseManagementSystem] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CourseManagementSystem] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CourseManagementSystem] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CourseManagementSystem] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CourseManagementSystem] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [CourseManagementSystem] SET  MULTI_USER 
GO
ALTER DATABASE [CourseManagementSystem] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CourseManagementSystem] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CourseManagementSystem] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CourseManagementSystem] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [CourseManagementSystem] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [CourseManagementSystem] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [CourseManagementSystem] SET QUERY_STORE = ON
GO
ALTER DATABASE [CourseManagementSystem] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [CourseManagementSystem]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 5/26/2025 1:47:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[category_id] [int] IDENTITY(1,1) NOT NULL,
	[category_name] [nvarchar](100) NOT NULL,
	[description] [nvarchar](500) NULL,
	[is_active] [bit] NULL,
	[created_at] [datetime2](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[category_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[category_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CourseReviews]    Script Date: 5/26/2025 1:47:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CourseReviews](
	[review_id] [int] IDENTITY(1,1) NOT NULL,
	[course_id] [int] NOT NULL,
	[student_id] [int] NOT NULL,
	[rating] [int] NOT NULL,
	[comment] [nvarchar](max) NULL,
	[is_anonymous] [bit] NULL,
	[created_at] [datetime2](7) NULL,
	[updated_at] [datetime2](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[review_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UK_CourseReviews_Course_Student] UNIQUE NONCLUSTERED 
(
	[course_id] ASC,
	[student_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 5/26/2025 1:47:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[user_id] [int] IDENTITY(1,1) NOT NULL,
	[username] [varchar](50) NOT NULL,
	[email] [varchar](100) NOT NULL,
	[password_hash] [varchar](255) NOT NULL,
	[first_name] [nvarchar](50) NOT NULL,
	[last_name] [nvarchar](50) NOT NULL,
	[phone] [varchar](20) NULL,
	[date_of_birth] [date] NULL,
	[role_id] [int] NOT NULL,
	[avatar_url] [varchar](255) NULL,
	[current_avatar_id] [int] NULL,
	[is_active] [bit] NULL,
	[email_verified] [bit] NULL,
	[last_login] [datetime2](7) NULL,
	[created_at] [datetime2](7) NULL,
	[updated_at] [datetime2](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Courses]    Script Date: 5/26/2025 1:47:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Courses](
	[course_id] [int] IDENTITY(1,1) NOT NULL,
	[course_code] [varchar](20) NOT NULL,
	[title] [nvarchar](255) NOT NULL,
	[description] [nvarchar](max) NULL,
	[short_description] [nvarchar](500) NULL,
	[teacher_id] [int] NOT NULL,
	[category_id] [int] NOT NULL,
	[image_url] [varchar](255) NULL,
	[price] [decimal](10, 2) NULL,
	[duration_hours] [int] NULL,
	[level] [varchar](20) NULL,
	[is_published] [bit] NULL,
	[is_active] [bit] NULL,
	[max_students] [int] NULL,
	[enrollment_start_date] [datetime2](7) NULL,
	[enrollment_end_date] [datetime2](7) NULL,
	[start_date] [datetime2](7) NULL,
	[end_date] [datetime2](7) NULL,
	[created_at] [datetime2](7) NULL,
	[updated_at] [datetime2](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[course_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[course_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Enrollments]    Script Date: 5/26/2025 1:47:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Enrollments](
	[enrollment_id] [int] IDENTITY(1,1) NOT NULL,
	[student_id] [int] NOT NULL,
	[course_id] [int] NOT NULL,
	[enrollment_date] [datetime2](7) NULL,
	[completion_date] [datetime2](7) NULL,
	[progress_percentage] [decimal](5, 2) NULL,
	[status] [varchar](20) NULL,
	[grade] [decimal](5, 2) NULL,
	[certificate_issued] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[enrollment_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UK_Enrollments_Student_Course] UNIQUE NONCLUSTERED 
(
	[student_id] ASC,
	[course_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VW_CourseDetails]    Script Date: 5/26/2025 1:47:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

    CREATE VIEW [dbo].[VW_CourseDetails] AS
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
        u.first_name + ' ' + u.last_name as teacher_name,
        u.email as teacher_email,
        cat.category_name,
        (SELECT COUNT(*) FROM Enrollments e WHERE e.course_id = c.course_id AND e.status = 'ACTIVE') as enrolled_count,
        (SELECT AVG(CAST(rating as FLOAT)) FROM CourseReviews cr WHERE cr.course_id = c.course_id) as average_rating,
        (SELECT COUNT(*) FROM CourseReviews cr WHERE cr.course_id = c.course_id) as review_count
    FROM Courses c
    INNER JOIN Users u ON c.teacher_id = u.user_id
    INNER JOIN Categories cat ON c.category_id = cat.category_id
    
GO
/****** Object:  View [dbo].[VW_StudentEnrollments]    Script Date: 5/26/2025 1:47:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

    CREATE VIEW [dbo].[VW_StudentEnrollments] AS
    SELECT 
        e.enrollment_id,
        e.student_id,
        e.course_id,
        e.enrollment_date,
        e.progress_percentage,
        e.status,
        e.grade,
        u.first_name + ' ' + u.last_name as student_name,
        u.email as student_email,
        c.title as course_title,
        c.course_code
    FROM Enrollments e
    INNER JOIN Users u ON e.student_id = u.user_id
    INNER JOIN Courses c ON e.course_id = c.course_id
    
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 5/26/2025 1:47:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[role_id] [int] IDENTITY(1,1) NOT NULL,
	[role_name] [varchar](20) NOT NULL,
	[description] [nvarchar](255) NULL,
	[created_at] [datetime2](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[role_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[role_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SystemSettings]    Script Date: 5/26/2025 1:47:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SystemSettings](
	[setting_id] [int] IDENTITY(1,1) NOT NULL,
	[setting_key] [varchar](100) NOT NULL,
	[setting_value] [nvarchar](max) NULL,
	[description] [nvarchar](255) NULL,
	[data_type] [varchar](20) NULL,
	[is_public] [bit] NULL,
	[created_at] [datetime2](7) NULL,
	[updated_at] [datetime2](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[setting_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[setting_key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserImages]    Script Date: 5/26/2025 1:47:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserImages](
	[image_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[image_name] [nvarchar](255) NOT NULL,
	[image_path] [varchar](500) NOT NULL,
	[image_size] [bigint] NULL,
	[image_type] [varchar](20) NULL,
	[is_default] [bit] NULL,
	[upload_date] [datetime2](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[image_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VW_UserProfiles]    Script Date: 5/26/2025 1:47:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

    CREATE VIEW [dbo].[VW_UserProfiles] AS
    SELECT 
        u.user_id,
        u.username,
        u.email,
        u.first_name,
        u.last_name,
        u.first_name + ' ' + u.last_name as full_name,
        u.phone,
        u.date_of_birth,
        u.is_active,
        u.email_verified,
        u.last_login,
        u.created_at,
        r.role_name,
        CASE 
            WHEN u.current_avatar_id IS NOT NULL THEN ui.image_path
            ELSE (SELECT setting_value FROM SystemSettings WHERE setting_key = 'DEFAULT_AVATAR_IMAGE')
        END as avatar_url,
        ui.image_id as current_avatar_image_id
    FROM Users u
    INNER JOIN Roles r ON u.role_id = r.role_id
    LEFT JOIN UserImages ui ON u.current_avatar_id = ui.image_id
    
GO
/****** Object:  Table [dbo].[Assignments]    Script Date: 5/26/2025 1:47:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Assignments](
	[assignment_id] [int] IDENTITY(1,1) NOT NULL,
	[course_id] [int] NOT NULL,
	[lesson_id] [int] NULL,
	[title] [nvarchar](255) NOT NULL,
	[description] [nvarchar](max) NULL,
	[instructions] [nvarchar](max) NULL,
	[max_score] [decimal](5, 2) NULL,
	[weight] [decimal](5, 2) NULL,
	[due_date] [datetime2](7) NULL,
	[allow_late_submission] [bit] NULL,
	[late_penalty_percent] [decimal](5, 2) NULL,
	[max_attempts] [int] NULL,
	[is_published] [bit] NULL,
	[created_at] [datetime2](7) NULL,
	[updated_at] [datetime2](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[assignment_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ForumReplies]    Script Date: 5/26/2025 1:47:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ForumReplies](
	[reply_id] [int] IDENTITY(1,1) NOT NULL,
	[topic_id] [int] NOT NULL,
	[user_id] [int] NOT NULL,
	[content] [nvarchar](max) NOT NULL,
	[parent_reply_id] [int] NULL,
	[is_deleted] [bit] NULL,
	[created_at] [datetime2](7) NULL,
	[updated_at] [datetime2](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[reply_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ForumTopics]    Script Date: 5/26/2025 1:47:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ForumTopics](
	[topic_id] [int] IDENTITY(1,1) NOT NULL,
	[course_id] [int] NOT NULL,
	[created_by] [int] NOT NULL,
	[title] [nvarchar](255) NOT NULL,
	[content] [nvarchar](max) NULL,
	[is_pinned] [bit] NULL,
	[is_locked] [bit] NULL,
	[view_count] [int] NULL,
	[reply_count] [int] NULL,
	[created_at] [datetime2](7) NULL,
	[updated_at] [datetime2](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[topic_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LessonProgress]    Script Date: 5/26/2025 1:47:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LessonProgress](
	[progress_id] [int] IDENTITY(1,1) NOT NULL,
	[lesson_id] [int] NOT NULL,
	[student_id] [int] NOT NULL,
	[is_completed] [bit] NULL,
	[completion_date] [datetime2](7) NULL,
	[watch_time_minutes] [int] NULL,
	[last_watched_position] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[progress_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UK_LessonProgress_Lesson_Student] UNIQUE NONCLUSTERED 
(
	[lesson_id] ASC,
	[student_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Lessons]    Script Date: 5/26/2025 1:47:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Lessons](
	[lesson_id] [int] IDENTITY(1,1) NOT NULL,
	[course_id] [int] NOT NULL,
	[title] [nvarchar](255) NOT NULL,
	[content] [nvarchar](max) NULL,
	[video_url] [varchar](255) NULL,
	[duration_minutes] [int] NULL,
	[order_number] [int] NOT NULL,
	[is_published] [bit] NULL,
	[is_free] [bit] NULL,
	[created_at] [datetime2](7) NULL,
	[updated_at] [datetime2](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[lesson_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UK_Lessons_Course_Order] UNIQUE NONCLUSTERED 
(
	[course_id] ASC,
	[order_number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Materials]    Script Date: 5/26/2025 1:47:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Materials](
	[material_id] [int] IDENTITY(1,1) NOT NULL,
	[lesson_id] [int] NOT NULL,
	[title] [nvarchar](255) NOT NULL,
	[description] [nvarchar](500) NULL,
	[file_name] [nvarchar](255) NOT NULL,
	[file_path] [varchar](500) NOT NULL,
	[file_size] [bigint] NULL,
	[file_type] [varchar](50) NULL,
	[download_count] [int] NULL,
	[is_downloadable] [bit] NULL,
	[upload_date] [datetime2](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[material_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Notifications]    Script Date: 5/26/2025 1:47:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notifications](
	[notification_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[title] [nvarchar](255) NOT NULL,
	[message] [nvarchar](max) NOT NULL,
	[type] [varchar](50) NULL,
	[related_id] [int] NULL,
	[related_type] [varchar](50) NULL,
	[is_read] [bit] NULL,
	[created_at] [datetime2](7) NULL,
	[read_at] [datetime2](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[notification_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Submissions]    Script Date: 5/26/2025 1:47:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Submissions](
	[submission_id] [int] IDENTITY(1,1) NOT NULL,
	[assignment_id] [int] NOT NULL,
	[student_id] [int] NOT NULL,
	[attempt_number] [int] NULL,
	[content] [nvarchar](max) NULL,
	[file_name] [nvarchar](255) NULL,
	[file_path] [varchar](500) NULL,
	[submission_date] [datetime2](7) NULL,
	[is_late] [bit] NULL,
	[score] [decimal](5, 2) NULL,
	[max_score] [decimal](5, 2) NULL,
	[feedback] [nvarchar](max) NULL,
	[graded_by] [int] NULL,
	[graded_date] [datetime2](7) NULL,
	[status] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[submission_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Index [IX_Assignments_Course]    Script Date: 5/26/2025 1:47:53 AM ******/
CREATE NONCLUSTERED INDEX [IX_Assignments_Course] ON [dbo].[Assignments]
(
	[course_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Assignments_DueDate]    Script Date: 5/26/2025 1:47:53 AM ******/
CREATE NONCLUSTERED INDEX [IX_Assignments_DueDate] ON [dbo].[Assignments]
(
	[due_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Courses_Active]    Script Date: 5/26/2025 1:47:53 AM ******/
CREATE NONCLUSTERED INDEX [IX_Courses_Active] ON [dbo].[Courses]
(
	[is_active] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Courses_Category]    Script Date: 5/26/2025 1:47:53 AM ******/
CREATE NONCLUSTERED INDEX [IX_Courses_Category] ON [dbo].[Courses]
(
	[category_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Courses_Published]    Script Date: 5/26/2025 1:47:53 AM ******/
CREATE NONCLUSTERED INDEX [IX_Courses_Published] ON [dbo].[Courses]
(
	[is_published] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Courses_Teacher]    Script Date: 5/26/2025 1:47:53 AM ******/
CREATE NONCLUSTERED INDEX [IX_Courses_Teacher] ON [dbo].[Courses]
(
	[teacher_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Enrollments_Course]    Script Date: 5/26/2025 1:47:53 AM ******/
CREATE NONCLUSTERED INDEX [IX_Enrollments_Course] ON [dbo].[Enrollments]
(
	[course_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Enrollments_Status]    Script Date: 5/26/2025 1:47:53 AM ******/
CREATE NONCLUSTERED INDEX [IX_Enrollments_Status] ON [dbo].[Enrollments]
(
	[status] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Enrollments_Student]    Script Date: 5/26/2025 1:47:53 AM ******/
CREATE NONCLUSTERED INDEX [IX_Enrollments_Student] ON [dbo].[Enrollments]
(
	[student_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Lessons_Course]    Script Date: 5/26/2025 1:47:53 AM ******/
CREATE NONCLUSTERED INDEX [IX_Lessons_Course] ON [dbo].[Lessons]
(
	[course_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Lessons_Order]    Script Date: 5/26/2025 1:47:53 AM ******/
CREATE NONCLUSTERED INDEX [IX_Lessons_Order] ON [dbo].[Lessons]
(
	[course_id] ASC,
	[order_number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Notifications_Created]    Script Date: 5/26/2025 1:47:53 AM ******/
CREATE NONCLUSTERED INDEX [IX_Notifications_Created] ON [dbo].[Notifications]
(
	[created_at] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Notifications_Read]    Script Date: 5/26/2025 1:47:53 AM ******/
CREATE NONCLUSTERED INDEX [IX_Notifications_Read] ON [dbo].[Notifications]
(
	[is_read] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Notifications_User]    Script Date: 5/26/2025 1:47:53 AM ******/
CREATE NONCLUSTERED INDEX [IX_Notifications_User] ON [dbo].[Notifications]
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Submissions_Assignment]    Script Date: 5/26/2025 1:47:53 AM ******/
CREATE NONCLUSTERED INDEX [IX_Submissions_Assignment] ON [dbo].[Submissions]
(
	[assignment_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Submissions_Status]    Script Date: 5/26/2025 1:47:53 AM ******/
CREATE NONCLUSTERED INDEX [IX_Submissions_Status] ON [dbo].[Submissions]
(
	[status] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Submissions_Student]    Script Date: 5/26/2025 1:47:53 AM ******/
CREATE NONCLUSTERED INDEX [IX_Submissions_Student] ON [dbo].[Submissions]
(
	[student_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_UserImages_Default]    Script Date: 5/26/2025 1:47:53 AM ******/
CREATE NONCLUSTERED INDEX [IX_UserImages_Default] ON [dbo].[UserImages]
(
	[user_id] ASC,
	[is_default] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_UserImages_User]    Script Date: 5/26/2025 1:47:53 AM ******/
CREATE NONCLUSTERED INDEX [IX_UserImages_User] ON [dbo].[UserImages]
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Users_Active]    Script Date: 5/26/2025 1:47:53 AM ******/
CREATE NONCLUSTERED INDEX [IX_Users_Active] ON [dbo].[Users]
(
	[is_active] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Users_Email]    Script Date: 5/26/2025 1:47:53 AM ******/
CREATE NONCLUSTERED INDEX [IX_Users_Email] ON [dbo].[Users]
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Users_Role]    Script Date: 5/26/2025 1:47:53 AM ******/
CREATE NONCLUSTERED INDEX [IX_Users_Role] ON [dbo].[Users]
(
	[role_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Users_Username]    Script Date: 5/26/2025 1:47:53 AM ******/
CREATE NONCLUSTERED INDEX [IX_Users_Username] ON [dbo].[Users]
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Assignments] ADD  DEFAULT ((100)) FOR [max_score]
GO
ALTER TABLE [dbo].[Assignments] ADD  DEFAULT ((1)) FOR [weight]
GO
ALTER TABLE [dbo].[Assignments] ADD  DEFAULT ((0)) FOR [allow_late_submission]
GO
ALTER TABLE [dbo].[Assignments] ADD  DEFAULT ((0)) FOR [late_penalty_percent]
GO
ALTER TABLE [dbo].[Assignments] ADD  DEFAULT ((1)) FOR [max_attempts]
GO
ALTER TABLE [dbo].[Assignments] ADD  DEFAULT ((0)) FOR [is_published]
GO
ALTER TABLE [dbo].[Assignments] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[Assignments] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[Categories] ADD  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [dbo].[Categories] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[CourseReviews] ADD  DEFAULT ((0)) FOR [is_anonymous]
GO
ALTER TABLE [dbo].[CourseReviews] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[CourseReviews] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[Courses] ADD  DEFAULT ('assets/images/default-course.jpg') FOR [image_url]
GO
ALTER TABLE [dbo].[Courses] ADD  DEFAULT ((0)) FOR [price]
GO
ALTER TABLE [dbo].[Courses] ADD  DEFAULT ((0)) FOR [duration_hours]
GO
ALTER TABLE [dbo].[Courses] ADD  DEFAULT ('Beginner') FOR [level]
GO
ALTER TABLE [dbo].[Courses] ADD  DEFAULT ((0)) FOR [is_published]
GO
ALTER TABLE [dbo].[Courses] ADD  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [dbo].[Courses] ADD  DEFAULT ((0)) FOR [max_students]
GO
ALTER TABLE [dbo].[Courses] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[Courses] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[Enrollments] ADD  DEFAULT (getdate()) FOR [enrollment_date]
GO
ALTER TABLE [dbo].[Enrollments] ADD  DEFAULT ((0)) FOR [progress_percentage]
GO
ALTER TABLE [dbo].[Enrollments] ADD  DEFAULT ('ACTIVE') FOR [status]
GO
ALTER TABLE [dbo].[Enrollments] ADD  DEFAULT ((0)) FOR [certificate_issued]
GO
ALTER TABLE [dbo].[ForumReplies] ADD  DEFAULT ((0)) FOR [is_deleted]
GO
ALTER TABLE [dbo].[ForumReplies] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[ForumReplies] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[ForumTopics] ADD  DEFAULT ((0)) FOR [is_pinned]
GO
ALTER TABLE [dbo].[ForumTopics] ADD  DEFAULT ((0)) FOR [is_locked]
GO
ALTER TABLE [dbo].[ForumTopics] ADD  DEFAULT ((0)) FOR [view_count]
GO
ALTER TABLE [dbo].[ForumTopics] ADD  DEFAULT ((0)) FOR [reply_count]
GO
ALTER TABLE [dbo].[ForumTopics] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[ForumTopics] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[LessonProgress] ADD  DEFAULT ((0)) FOR [is_completed]
GO
ALTER TABLE [dbo].[LessonProgress] ADD  DEFAULT ((0)) FOR [watch_time_minutes]
GO
ALTER TABLE [dbo].[LessonProgress] ADD  DEFAULT ((0)) FOR [last_watched_position]
GO
ALTER TABLE [dbo].[Lessons] ADD  DEFAULT ((0)) FOR [duration_minutes]
GO
ALTER TABLE [dbo].[Lessons] ADD  DEFAULT ((0)) FOR [is_published]
GO
ALTER TABLE [dbo].[Lessons] ADD  DEFAULT ((0)) FOR [is_free]
GO
ALTER TABLE [dbo].[Lessons] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[Lessons] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[Materials] ADD  DEFAULT ((0)) FOR [download_count]
GO
ALTER TABLE [dbo].[Materials] ADD  DEFAULT ((1)) FOR [is_downloadable]
GO
ALTER TABLE [dbo].[Materials] ADD  DEFAULT (getdate()) FOR [upload_date]
GO
ALTER TABLE [dbo].[Notifications] ADD  DEFAULT ('INFO') FOR [type]
GO
ALTER TABLE [dbo].[Notifications] ADD  DEFAULT ((0)) FOR [is_read]
GO
ALTER TABLE [dbo].[Notifications] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[Roles] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[Submissions] ADD  DEFAULT ((1)) FOR [attempt_number]
GO
ALTER TABLE [dbo].[Submissions] ADD  DEFAULT (getdate()) FOR [submission_date]
GO
ALTER TABLE [dbo].[Submissions] ADD  DEFAULT ((0)) FOR [is_late]
GO
ALTER TABLE [dbo].[Submissions] ADD  DEFAULT ('SUBMITTED') FOR [status]
GO
ALTER TABLE [dbo].[SystemSettings] ADD  DEFAULT ('STRING') FOR [data_type]
GO
ALTER TABLE [dbo].[SystemSettings] ADD  DEFAULT ((0)) FOR [is_public]
GO
ALTER TABLE [dbo].[SystemSettings] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[SystemSettings] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[UserImages] ADD  DEFAULT ((0)) FOR [is_default]
GO
ALTER TABLE [dbo].[UserImages] ADD  DEFAULT (getdate()) FOR [upload_date]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT ((2)) FOR [role_id]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT (NULL) FOR [avatar_url]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT ((0)) FOR [email_verified]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[Assignments]  WITH CHECK ADD  CONSTRAINT [FK_Assignments_Courses] FOREIGN KEY([course_id])
REFERENCES [dbo].[Courses] ([course_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Assignments] CHECK CONSTRAINT [FK_Assignments_Courses]
GO
ALTER TABLE [dbo].[Assignments]  WITH CHECK ADD  CONSTRAINT [FK_Assignments_Lessons] FOREIGN KEY([lesson_id])
REFERENCES [dbo].[Lessons] ([lesson_id])
GO
ALTER TABLE [dbo].[Assignments] CHECK CONSTRAINT [FK_Assignments_Lessons]
GO
ALTER TABLE [dbo].[CourseReviews]  WITH CHECK ADD  CONSTRAINT [FK_CourseReviews_Courses] FOREIGN KEY([course_id])
REFERENCES [dbo].[Courses] ([course_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CourseReviews] CHECK CONSTRAINT [FK_CourseReviews_Courses]
GO
ALTER TABLE [dbo].[CourseReviews]  WITH CHECK ADD  CONSTRAINT [FK_CourseReviews_Students] FOREIGN KEY([student_id])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[CourseReviews] CHECK CONSTRAINT [FK_CourseReviews_Students]
GO
ALTER TABLE [dbo].[Courses]  WITH CHECK ADD  CONSTRAINT [FK_Courses_Categories] FOREIGN KEY([category_id])
REFERENCES [dbo].[Categories] ([category_id])
GO
ALTER TABLE [dbo].[Courses] CHECK CONSTRAINT [FK_Courses_Categories]
GO
ALTER TABLE [dbo].[Courses]  WITH CHECK ADD  CONSTRAINT [FK_Courses_Teachers] FOREIGN KEY([teacher_id])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[Courses] CHECK CONSTRAINT [FK_Courses_Teachers]
GO
ALTER TABLE [dbo].[Enrollments]  WITH CHECK ADD  CONSTRAINT [FK_Enrollments_Courses] FOREIGN KEY([course_id])
REFERENCES [dbo].[Courses] ([course_id])
GO
ALTER TABLE [dbo].[Enrollments] CHECK CONSTRAINT [FK_Enrollments_Courses]
GO
ALTER TABLE [dbo].[Enrollments]  WITH CHECK ADD  CONSTRAINT [FK_Enrollments_Students] FOREIGN KEY([student_id])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[Enrollments] CHECK CONSTRAINT [FK_Enrollments_Students]
GO
ALTER TABLE [dbo].[ForumReplies]  WITH CHECK ADD  CONSTRAINT [FK_ForumReplies_Parent] FOREIGN KEY([parent_reply_id])
REFERENCES [dbo].[ForumReplies] ([reply_id])
GO
ALTER TABLE [dbo].[ForumReplies] CHECK CONSTRAINT [FK_ForumReplies_Parent]
GO
ALTER TABLE [dbo].[ForumReplies]  WITH CHECK ADD  CONSTRAINT [FK_ForumReplies_Topics] FOREIGN KEY([topic_id])
REFERENCES [dbo].[ForumTopics] ([topic_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ForumReplies] CHECK CONSTRAINT [FK_ForumReplies_Topics]
GO
ALTER TABLE [dbo].[ForumReplies]  WITH CHECK ADD  CONSTRAINT [FK_ForumReplies_Users] FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[ForumReplies] CHECK CONSTRAINT [FK_ForumReplies_Users]
GO
ALTER TABLE [dbo].[ForumTopics]  WITH CHECK ADD  CONSTRAINT [FK_ForumTopics_Courses] FOREIGN KEY([course_id])
REFERENCES [dbo].[Courses] ([course_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ForumTopics] CHECK CONSTRAINT [FK_ForumTopics_Courses]
GO
ALTER TABLE [dbo].[ForumTopics]  WITH CHECK ADD  CONSTRAINT [FK_ForumTopics_Users] FOREIGN KEY([created_by])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[ForumTopics] CHECK CONSTRAINT [FK_ForumTopics_Users]
GO
ALTER TABLE [dbo].[LessonProgress]  WITH CHECK ADD  CONSTRAINT [FK_LessonProgress_Lessons] FOREIGN KEY([lesson_id])
REFERENCES [dbo].[Lessons] ([lesson_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[LessonProgress] CHECK CONSTRAINT [FK_LessonProgress_Lessons]
GO
ALTER TABLE [dbo].[LessonProgress]  WITH CHECK ADD  CONSTRAINT [FK_LessonProgress_Students] FOREIGN KEY([student_id])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[LessonProgress] CHECK CONSTRAINT [FK_LessonProgress_Students]
GO
ALTER TABLE [dbo].[Lessons]  WITH CHECK ADD  CONSTRAINT [FK_Lessons_Courses] FOREIGN KEY([course_id])
REFERENCES [dbo].[Courses] ([course_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Lessons] CHECK CONSTRAINT [FK_Lessons_Courses]
GO
ALTER TABLE [dbo].[Materials]  WITH CHECK ADD  CONSTRAINT [FK_Materials_Lessons] FOREIGN KEY([lesson_id])
REFERENCES [dbo].[Lessons] ([lesson_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Materials] CHECK CONSTRAINT [FK_Materials_Lessons]
GO
ALTER TABLE [dbo].[Notifications]  WITH CHECK ADD  CONSTRAINT [FK_Notifications_Users] FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[Notifications] CHECK CONSTRAINT [FK_Notifications_Users]
GO
ALTER TABLE [dbo].[Submissions]  WITH CHECK ADD  CONSTRAINT [FK_Submissions_Assignments] FOREIGN KEY([assignment_id])
REFERENCES [dbo].[Assignments] ([assignment_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Submissions] CHECK CONSTRAINT [FK_Submissions_Assignments]
GO
ALTER TABLE [dbo].[Submissions]  WITH CHECK ADD  CONSTRAINT [FK_Submissions_Graders] FOREIGN KEY([graded_by])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[Submissions] CHECK CONSTRAINT [FK_Submissions_Graders]
GO
ALTER TABLE [dbo].[Submissions]  WITH CHECK ADD  CONSTRAINT [FK_Submissions_Students] FOREIGN KEY([student_id])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[Submissions] CHECK CONSTRAINT [FK_Submissions_Students]
GO
ALTER TABLE [dbo].[UserImages]  WITH CHECK ADD  CONSTRAINT [FK_UserImages_Users] FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([user_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserImages] CHECK CONSTRAINT [FK_UserImages_Users]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_CurrentAvatar] FOREIGN KEY([current_avatar_id])
REFERENCES [dbo].[UserImages] ([image_id])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_CurrentAvatar]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Roles] FOREIGN KEY([role_id])
REFERENCES [dbo].[Roles] ([role_id])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Roles]
GO
ALTER TABLE [dbo].[Assignments]  WITH CHECK ADD  CONSTRAINT [CK_Assignments_LatePenalty] CHECK  (([late_penalty_percent]>=(0) AND [late_penalty_percent]<=(100)))
GO
ALTER TABLE [dbo].[Assignments] CHECK CONSTRAINT [CK_Assignments_LatePenalty]
GO
ALTER TABLE [dbo].[Assignments]  WITH CHECK ADD  CONSTRAINT [CK_Assignments_MaxAttempts] CHECK  (([max_attempts]>(0)))
GO
ALTER TABLE [dbo].[Assignments] CHECK CONSTRAINT [CK_Assignments_MaxAttempts]
GO
ALTER TABLE [dbo].[Assignments]  WITH CHECK ADD  CONSTRAINT [CK_Assignments_MaxScore] CHECK  (([max_score]>(0)))
GO
ALTER TABLE [dbo].[Assignments] CHECK CONSTRAINT [CK_Assignments_MaxScore]
GO
ALTER TABLE [dbo].[Assignments]  WITH CHECK ADD  CONSTRAINT [CK_Assignments_Weight] CHECK  (([weight]>=(0)))
GO
ALTER TABLE [dbo].[Assignments] CHECK CONSTRAINT [CK_Assignments_Weight]
GO
ALTER TABLE [dbo].[CourseReviews]  WITH CHECK ADD  CONSTRAINT [CK_CourseReviews_Rating] CHECK  (([rating]>=(1) AND [rating]<=(5)))
GO
ALTER TABLE [dbo].[CourseReviews] CHECK CONSTRAINT [CK_CourseReviews_Rating]
GO
ALTER TABLE [dbo].[Courses]  WITH CHECK ADD  CONSTRAINT [CK_Courses_Duration] CHECK  (([duration_hours]>=(0)))
GO
ALTER TABLE [dbo].[Courses] CHECK CONSTRAINT [CK_Courses_Duration]
GO
ALTER TABLE [dbo].[Courses]  WITH CHECK ADD  CONSTRAINT [CK_Courses_Level] CHECK  (([level]='Advanced' OR [level]='Intermediate' OR [level]='Beginner'))
GO
ALTER TABLE [dbo].[Courses] CHECK CONSTRAINT [CK_Courses_Level]
GO
ALTER TABLE [dbo].[Courses]  WITH CHECK ADD  CONSTRAINT [CK_Courses_Price] CHECK  (([price]>=(0)))
GO
ALTER TABLE [dbo].[Courses] CHECK CONSTRAINT [CK_Courses_Price]
GO
ALTER TABLE [dbo].[Enrollments]  WITH CHECK ADD  CONSTRAINT [CK_Enrollments_Grade] CHECK  (([grade] IS NULL OR [grade]>=(0) AND [grade]<=(10)))
GO
ALTER TABLE [dbo].[Enrollments] CHECK CONSTRAINT [CK_Enrollments_Grade]
GO
ALTER TABLE [dbo].[Enrollments]  WITH CHECK ADD  CONSTRAINT [CK_Enrollments_Progress] CHECK  (([progress_percentage]>=(0) AND [progress_percentage]<=(100)))
GO
ALTER TABLE [dbo].[Enrollments] CHECK CONSTRAINT [CK_Enrollments_Progress]
GO
ALTER TABLE [dbo].[Enrollments]  WITH CHECK ADD  CONSTRAINT [CK_Enrollments_Status] CHECK  (([status]='SUSPENDED' OR [status]='DROPPED' OR [status]='COMPLETED' OR [status]='ACTIVE'))
GO
ALTER TABLE [dbo].[Enrollments] CHECK CONSTRAINT [CK_Enrollments_Status]
GO
ALTER TABLE [dbo].[LessonProgress]  WITH CHECK ADD  CONSTRAINT [CK_LessonProgress_Position] CHECK  (([last_watched_position]>=(0)))
GO
ALTER TABLE [dbo].[LessonProgress] CHECK CONSTRAINT [CK_LessonProgress_Position]
GO
ALTER TABLE [dbo].[LessonProgress]  WITH CHECK ADD  CONSTRAINT [CK_LessonProgress_WatchTime] CHECK  (([watch_time_minutes]>=(0)))
GO
ALTER TABLE [dbo].[LessonProgress] CHECK CONSTRAINT [CK_LessonProgress_WatchTime]
GO
ALTER TABLE [dbo].[Lessons]  WITH CHECK ADD  CONSTRAINT [CK_Lessons_Duration] CHECK  (([duration_minutes]>=(0)))
GO
ALTER TABLE [dbo].[Lessons] CHECK CONSTRAINT [CK_Lessons_Duration]
GO
ALTER TABLE [dbo].[Lessons]  WITH CHECK ADD  CONSTRAINT [CK_Lessons_Order] CHECK  (([order_number]>(0)))
GO
ALTER TABLE [dbo].[Lessons] CHECK CONSTRAINT [CK_Lessons_Order]
GO
ALTER TABLE [dbo].[Materials]  WITH CHECK ADD  CONSTRAINT [CK_Materials_FileSize] CHECK  (([file_size] IS NULL OR [file_size]>(0)))
GO
ALTER TABLE [dbo].[Materials] CHECK CONSTRAINT [CK_Materials_FileSize]
GO
ALTER TABLE [dbo].[Notifications]  WITH CHECK ADD  CONSTRAINT [CK_Notifications_Type] CHECK  (([type]='ERROR' OR [type]='SUCCESS' OR [type]='WARNING' OR [type]='INFO'))
GO
ALTER TABLE [dbo].[Notifications] CHECK CONSTRAINT [CK_Notifications_Type]
GO
ALTER TABLE [dbo].[Submissions]  WITH CHECK ADD  CONSTRAINT [CK_Submissions_Attempt] CHECK  (([attempt_number]>(0)))
GO
ALTER TABLE [dbo].[Submissions] CHECK CONSTRAINT [CK_Submissions_Attempt]
GO
ALTER TABLE [dbo].[Submissions]  WITH CHECK ADD  CONSTRAINT [CK_Submissions_MaxScore] CHECK  (([max_score] IS NULL OR [max_score]>(0)))
GO
ALTER TABLE [dbo].[Submissions] CHECK CONSTRAINT [CK_Submissions_MaxScore]
GO
ALTER TABLE [dbo].[Submissions]  WITH CHECK ADD  CONSTRAINT [CK_Submissions_Score] CHECK  (([score] IS NULL OR [score]>=(0)))
GO
ALTER TABLE [dbo].[Submissions] CHECK CONSTRAINT [CK_Submissions_Score]
GO
ALTER TABLE [dbo].[Submissions]  WITH CHECK ADD  CONSTRAINT [CK_Submissions_Status] CHECK  (([status]='RETURNED' OR [status]='GRADED' OR [status]='SUBMITTED'))
GO
ALTER TABLE [dbo].[Submissions] CHECK CONSTRAINT [CK_Submissions_Status]
GO
ALTER TABLE [dbo].[UserImages]  WITH CHECK ADD  CONSTRAINT [CK_UserImages_Size] CHECK  (([image_size] IS NULL OR [image_size]>(0)))
GO
ALTER TABLE [dbo].[UserImages] CHECK CONSTRAINT [CK_UserImages_Size]
GO
ALTER TABLE [dbo].[UserImages]  WITH CHECK ADD  CONSTRAINT [CK_UserImages_Type] CHECK  (([image_type]='webp' OR [image_type]='gif' OR [image_type]='png' OR [image_type]='jpeg' OR [image_type]='jpg'))
GO
ALTER TABLE [dbo].[UserImages] CHECK CONSTRAINT [CK_UserImages_Type]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [CK_Users_Email] CHECK  (([email] like '%@%.%'))
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [CK_Users_Email]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [CK_Users_Phone] CHECK  (([phone] IS NULL OR len([phone])>=(10)))
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [CK_Users_Phone]
GO
/****** Object:  StoredProcedure [dbo].[SP_CalculateCourseProgress]    Script Date: 5/26/2025 1:47:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

    CREATE PROCEDURE [dbo].[SP_CalculateCourseProgress]
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
    
GO
/****** Object:  StoredProcedure [dbo].[SP_CreateNotification]    Script Date: 5/26/2025 1:47:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

    CREATE PROCEDURE [dbo].[SP_CreateNotification]
        @user_id INT,
        @title NVARCHAR(255),
        @message NVARCHAR(MAX),
        @type VARCHAR(50) = 'INFO',
        @related_id INT = NULL,
        @related_type VARCHAR(50) = NULL
    AS
    BEGIN
        INSERT INTO Notifications (user_id, title, message, type, related_id, related_type)
        VALUES (@user_id, @title, @message, @type, @related_id, @related_type);
    END
    
GO
/****** Object:  StoredProcedure [dbo].[SP_ResetToDefaultAvatar]    Script Date: 5/26/2025 1:47:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

    CREATE PROCEDURE [dbo].[SP_ResetToDefaultAvatar]
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
        
        SELECT 'SUCCESS' as result;
    END
    
GO
/****** Object:  StoredProcedure [dbo].[SP_SetDefaultUserImage]    Script Date: 5/26/2025 1:47:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

    CREATE PROCEDURE [dbo].[SP_SetDefaultUserImage]
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
            
            SELECT 'SUCCESS' as result;
        END
        ELSE
        BEGIN
            SELECT 'ERROR: Image not found or not belongs to user' as result;
        END
    END
    
GO
/****** Object:  StoredProcedure [dbo].[SP_UploadUserImage]    Script Date: 5/26/2025 1:47:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

    CREATE PROCEDURE [dbo].[SP_UploadUserImage]
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
    
GO
USE [master]
GO
ALTER DATABASE [CourseManagementSystem] SET  READ_WRITE 
GO
