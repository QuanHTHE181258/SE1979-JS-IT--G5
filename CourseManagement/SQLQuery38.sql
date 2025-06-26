USE [master]
GO
/****** Object:  Database [CourseManagementSystem]    Script Date: 6/22/2025 4:09:53 PM ******/
CREATE DATABASE [CourseManagementSystem]
GO
ALTER DATABASE [CourseManagementSystem] SET COMPATIBILITY_LEVEL = 150
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
ALTER DATABASE [CourseManagementSystem] SET QUERY_STORE = OFF
GO
USE [CourseManagementSystem]
GO
/****** Object:  User [admin]    Script Date: 6/22/2025 4:09:53 PM ******/
-- CREATE USER [sa] FOR LOGIN [sa] WITH DEFAULT_SCHEMA=[dbo]
-- GO
/****** Object:  Table [dbo].[answers]    Script Date: 6/22/2025 4:09:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[answers](
                                [AnswerID] [int] IDENTITY(1,1) NOT NULL,
                                [QuestionID] [int] NOT NULL,
                                [AnswerText] [nvarchar](max) NULL,
                                [IsCorrect] [bit] NULL,
                                PRIMARY KEY CLUSTERED
                                    (
                                     [AnswerID] ASC
                                        )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cart]    Script Date: 6/22/2025 4:09:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cart](
                             [CartID] [int] IDENTITY(1,1) NOT NULL,
                             [UserID] [int] NOT NULL,
                             [Status] [nvarchar](20) NULL,
                             [TotalPrice] [decimal](10, 2) NULL,
                             [CreatedAt] [datetime] NULL,
                             PRIMARY KEY CLUSTERED
                                 (
                                  [CartID] ASC
                                     )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cartitem]    Script Date: 6/22/2025 4:09:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cartitem](
                                 [CartItemID] [int] IDENTITY(1,1) NOT NULL,
                                 [CartID] [int] NOT NULL,
                                 [CourseID] [int] NOT NULL,
                                 [Price] [decimal](10, 2) NULL,
                                 PRIMARY KEY CLUSTERED
                                     (
                                      [CartItemID] ASC
                                         )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[categories]    Script Date: 6/22/2025 4:09:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[categories](
                                   [CategoryID] [int] IDENTITY(1,1) NOT NULL,
                                   [Name] [nvarchar](100) NOT NULL,
                                   [Description] [nvarchar](max) NULL,
                                   [CreatedAt] [datetime] NULL,
                                   PRIMARY KEY CLUSTERED
                                       (
                                        [CategoryID] ASC
                                           )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[course_progress]    Script Date: 6/22/2025 4:09:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[course_progress](
                                        [UserID] [int] NOT NULL,
                                        [CourseID] [int] NOT NULL,
                                        [CompletedLessons] [int] NULL,
                                        [TotalLessons] [int] NULL,
                                        [ProgressPercent] [float] NULL,
                                        [LastAccessed] [datetime] NULL,
                                        PRIMARY KEY CLUSTERED
                                            (
                                             [UserID] ASC,
                                             [CourseID] ASC
                                                )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[courses]    Script Date: 6/22/2025 4:09:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[courses](
                                [CourseID] [int] IDENTITY(1,1) NOT NULL,
                                [Title] [nvarchar](255) NOT NULL,
                                [Description] [nvarchar](max) NULL,
                                [Price] [decimal](10, 2) NULL,
                                [Rating] [float] NULL,
                                [CreatedAt] [datetime] NULL,
                                [ImageURL] [nvarchar](255) NULL,
                                [InstructorID] [int] NULL,
                                [CategoryID] [int] NULL,
                                [Status] [nvarchar](20) NULL,
                                PRIMARY KEY CLUSTERED
                                    (
                                     [CourseID] ASC
                                        )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[enrollments]    Script Date: 6/22/2025 4:09:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[enrollments](
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
                                            )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[feedback]    Script Date: 6/22/2025 4:09:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[feedback](
                                 [FeedbackID] [int] IDENTITY(1,1) NOT NULL,
                                 [CourseID] [int] NOT NULL,
                                 [UserID] [int] NOT NULL,
                                 [Rating] [int] NULL,
                                 [Comment] [nvarchar](max) NULL,
                                 [CreatedAt] [datetime] NULL,
                                 PRIMARY KEY CLUSTERED
                                     (
                                      [FeedbackID] ASC
                                         )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lessons]    Script Date: 6/22/2025 4:09:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lessons](
                                [LessonID] [int] IDENTITY(1,1) NOT NULL,
                                [CourseID] [int] NOT NULL,
                                [Title] [nvarchar](255) NULL,
                                [Content] [nvarchar](max) NULL,
                                [Status] [nvarchar](20) NULL,
                                [IsFreePreview] [bit] NULL,
                                [CreatedAt] [datetime] NULL,
                                PRIMARY KEY CLUSTERED
                                    (
                                     [LessonID] ASC
                                        )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[materials]    Script Date: 6/22/2025 4:09:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[materials](
                                  [MaterialID] [int] IDENTITY(1,1) NOT NULL,
                                  [LessonID] [int] NOT NULL,
                                  [Title] [nvarchar](255) NULL,
                                  [FileURL] [nvarchar](255) NULL,
                                  PRIMARY KEY CLUSTERED
                                      (
                                       [MaterialID] ASC
                                          )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[orderdetails]    Script Date: 6/22/2025 4:09:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orderdetails](
                                     [OrderDetailID] [int] IDENTITY(1,1) NOT NULL,
                                     [OrderID] [int] NOT NULL,
                                     [CourseID] [int] NOT NULL,
                                     [Price] [decimal](10, 2) NULL,
                                     PRIMARY KEY CLUSTERED
                                         (
                                          [OrderDetailID] ASC
                                             )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[orders]    Script Date: 6/22/2025 4:09:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orders](
                               [OrderID] [int] IDENTITY(1,1) NOT NULL,
                               [UserID] [int] NOT NULL,
                               [Status] [nvarchar](20) NULL,
                               [PaymentMethod] [nvarchar](50) NULL,
                               [TotalAmount] [decimal](10, 2) NULL,
                               [CreatedAt] [datetime] NULL,
                               PRIMARY KEY CLUSTERED
                                   (
                                    [OrderID] ASC
                                       )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[question_attempts]    Script Date: 6/22/2025 4:09:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[question_attempts](
                                          [AttemptID] [int] NOT NULL,
                                          [QuestionID] [int] NOT NULL,
                                          [OptionID] [int] NULL,
                                          [IsCorrect] [bit] NULL,
                                          PRIMARY KEY CLUSTERED
                                              (
                                               [AttemptID], [QuestionID]
                                                  )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[questions]    Script Date: 6/22/2025 4:09:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[questions](
                                  [QuestionID] [int] IDENTITY(1,1) NOT NULL,
                                  [QuizID] [int] NOT NULL,
                                  [QuestionText] [nvarchar](max) NULL,
                                  PRIMARY KEY CLUSTERED
                                      (
                                       [QuestionID] ASC
                                          )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[quiz_attempts]    Script Date: 6/22/2025 4:09:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[quiz_attempts](
                                      [AttemptID] [int] IDENTITY(1,1) NOT NULL,
                                      [UserID] [int] NOT NULL,
                                      [QuizID] [int] NOT NULL,
                                      [AttemptDate] [datetime] NULL,
                                      [Score] [float] NULL,
                                      [completion_time_minutes] [int] NULL,
                                      PRIMARY KEY CLUSTERED
                                          (
                                           [AttemptID] ASC
                                              )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[quizzes]    Script Date: 6/22/2025 4:09:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[quizzes](
                                [QuizID] [int] IDENTITY(1,1) NOT NULL,
                                [LessonID] [int] NOT NULL,
                                [Title] [nvarchar](255) NULL,
                                [duration_minutes] [int] NOT NULL,
                                PRIMARY KEY CLUSTERED
                                    (
                                     [QuizID] ASC
                                        )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[roles]    Script Date: 6/22/2025 4:09:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[roles](
                              [RoleID] [int] IDENTITY(1,1) NOT NULL,
                              [RoleName] [nvarchar](50) NOT NULL,
                              PRIMARY KEY CLUSTERED
                                  (
                                   [RoleID] ASC
                                      )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[user_avatars]    Script Date: 6/22/2025 4:09:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user_avatars](
                                     [AvatarID] [int] IDENTITY(1,1) NOT NULL,
                                     [UserID] [int] NOT NULL,
                                     [ImageURL] [nvarchar](255) NULL,
                                     [IsDefault] [bit] NULL,
                                     [UploadedAt] [datetime] NULL,
                                     PRIMARY KEY CLUSTERED
                                         (
                                          [AvatarID] ASC
                                             )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[user_roles]    Script Date: 6/22/2025 4:09:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user_roles](
                                   [UserID] [int] NOT NULL,
                                   [RoleID] [int] NOT NULL,
                                   PRIMARY KEY CLUSTERED
                                       (
                                        [UserID] ASC,
                                        [RoleID] ASC
                                           )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users]    Script Date: 6/22/2025 4:09:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
                              [UserID] [int] IDENTITY(1,1) NOT NULL,
                              [Username] [nvarchar](50) NOT NULL,
                              [Email] [nvarchar](100) NOT NULL,
                              [PasswordHash] [nvarchar](255) NOT NULL,
                              [FirstName] [nvarchar](20) NULL,
                              [LastName] [nvarchar](20) NULL,
                              [AvatarURL] [nvarchar](255) NULL,
                              [PhoneNumber] [nvarchar](20) NULL,
                              [DateOfBirth] [date] NULL,
                              [LastLogin] [datetime] NULL,
                              [CreatedAt] [datetime] NULL,
                              PRIMARY KEY CLUSTERED
                                  (
                                   [UserID] ASC
                                      )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[answers] ON
GO
INSERT [dbo].[answers] ([AnswerID], [QuestionID], [AnswerText], [IsCorrect]) VALUES (1, 1, N'Ngôn ngữ đánh dấu', 0)
GO
INSERT [dbo].[answers] ([AnswerID], [QuestionID], [AnswerText], [IsCorrect]) VALUES (2, 1, N'Ngôn ngữ lập trình hướng đối tượng', 1)
GO
INSERT [dbo].[answers] ([AnswerID], [QuestionID], [AnswerText], [IsCorrect]) VALUES (3, 2, N'float', 0)
GO
INSERT [dbo].[answers] ([AnswerID], [QuestionID], [AnswerText], [IsCorrect]) VALUES (4, 2, N'int', 1)
GO
INSERT [dbo].[answers] ([AnswerID], [QuestionID], [AnswerText], [IsCorrect]) VALUES (5, 3, N'int', 0)
GO
INSERT [dbo].[answers] ([AnswerID], [QuestionID], [AnswerText], [IsCorrect]) VALUES (6, 3, N'double', 1)
GO
INSERT [dbo].[answers] ([AnswerID], [QuestionID], [AnswerText], [IsCorrect]) VALUES (7, 3, N'boolean', 0)
GO
INSERT [dbo].[answers] ([AnswerID], [QuestionID], [AnswerText], [IsCorrect]) VALUES (8, 3, N'String', 0)
GO
INSERT [dbo].[answers] ([AnswerID], [QuestionID], [AnswerText], [IsCorrect]) VALUES (9, 4, N'int a = 5;', 1)
GO
INSERT [dbo].[answers] ([AnswerID], [QuestionID], [AnswerText], [IsCorrect]) VALUES (10, 4, N'a int = 5;', 0)
GO
INSERT [dbo].[answers] ([AnswerID], [QuestionID], [AnswerText], [IsCorrect]) VALUES (11, 4, N'int = 5 a;', 0)
GO
INSERT [dbo].[answers] ([AnswerID], [QuestionID], [AnswerText], [IsCorrect]) VALUES (12, 4, N'def int a = 5', 0)
GO
INSERT [dbo].[answers] ([AnswerID], [QuestionID], [AnswerText], [IsCorrect]) VALUES (13, 5, N'false', 1)
GO
INSERT [dbo].[answers] ([AnswerID], [QuestionID], [AnswerText], [IsCorrect]) VALUES (14, 5, N'null', 0)
GO
INSERT [dbo].[answers] ([AnswerID], [QuestionID], [AnswerText], [IsCorrect]) VALUES (15, 5, N'0', 0)
GO
INSERT [dbo].[answers] ([AnswerID], [QuestionID], [AnswerText], [IsCorrect]) VALUES (16, 5, N'true', 0)
GO
INSERT [dbo].[answers] ([AnswerID], [QuestionID], [AnswerText], [IsCorrect]) VALUES (17, 6, N'.className', 1)
GO
INSERT [dbo].[answers] ([AnswerID], [QuestionID], [AnswerText], [IsCorrect]) VALUES (18, 6, N'#className', 0)
GO
INSERT [dbo].[answers] ([AnswerID], [QuestionID], [AnswerText], [IsCorrect]) VALUES (19, 6, N'class', 0)
GO
INSERT [dbo].[answers] ([AnswerID], [QuestionID], [AnswerText], [IsCorrect]) VALUES (20, 6, N'<className>', 0)
GO
INSERT [dbo].[answers] ([AnswerID], [QuestionID], [AnswerText], [IsCorrect]) VALUES (21, 7, N'<style>', 1)
GO
INSERT [dbo].[answers] ([AnswerID], [QuestionID], [AnswerText], [IsCorrect]) VALUES (22, 7, N'<css>', 0)
GO
INSERT [dbo].[answers] ([AnswerID], [QuestionID], [AnswerText], [IsCorrect]) VALUES (23, 7, N'<link>', 0)
GO
INSERT [dbo].[answers] ([AnswerID], [QuestionID], [AnswerText], [IsCorrect]) VALUES (24, 7, N'<script>', 0)
GO
INSERT [dbo].[answers] ([AnswerID], [QuestionID], [AnswerText], [IsCorrect]) VALUES (25, 8, N'font-size', 1)
GO
INSERT [dbo].[answers] ([AnswerID], [QuestionID], [AnswerText], [IsCorrect]) VALUES (26, 8, N'text-size', 0)
GO
INSERT [dbo].[answers] ([AnswerID], [QuestionID], [AnswerText], [IsCorrect]) VALUES (27, 8, N'size-font', 0)
GO
INSERT [dbo].[answers] ([AnswerID], [QuestionID], [AnswerText], [IsCorrect]) VALUES (28, 8, N'text-font', 0)
GO
INSERT [dbo].[answers] ([AnswerID], [QuestionID], [AnswerText], [IsCorrect]) VALUES (41, 12, N'Kết hợp tất cả các hàng từ cả hai bảng', 0)
GO
INSERT [dbo].[answers] ([AnswerID], [QuestionID], [AnswerText], [IsCorrect]) VALUES (42, 12, N'Lấy các hàng trùng khớp ở cả hai bảng', 1)
GO
INSERT [dbo].[answers] ([AnswerID], [QuestionID], [AnswerText], [IsCorrect]) VALUES (43, 12, N'Lấy tất cả các hàng từ bảng bên trái', 0)
GO
INSERT [dbo].[answers] ([AnswerID], [QuestionID], [AnswerText], [IsCorrect]) VALUES (44, 12, N'Lấy các hàng không khớp', 0)
GO
INSERT [dbo].[answers] ([AnswerID], [QuestionID], [AnswerText], [IsCorrect]) VALUES (45, 13, N'LEFT JOIN', 1)
GO
INSERT [dbo].[answers] ([AnswerID], [QuestionID], [AnswerText], [IsCorrect]) VALUES (46, 13, N'RIGHT JOIN', 0)
GO
INSERT [dbo].[answers] ([AnswerID], [QuestionID], [AnswerText], [IsCorrect]) VALUES (47, 13, N'INNER JOIN', 0)
GO
INSERT [dbo].[answers] ([AnswerID], [QuestionID], [AnswerText], [IsCorrect]) VALUES (48, 13, N'CROSS JOIN', 0)
GO
INSERT [dbo].[answers] ([AnswerID], [QuestionID], [AnswerText], [IsCorrect]) VALUES (49, 14, N'Chỉ các hàng khớp', 0)
GO
INSERT [dbo].[answers] ([AnswerID], [QuestionID], [AnswerText], [IsCorrect]) VALUES (50, 14, N'Tất cả các hàng từ cả hai bảng, kể cả không khớp', 1)
GO
INSERT [dbo].[answers] ([AnswerID], [QuestionID], [AnswerText], [IsCorrect]) VALUES (51, 14, N'Tất cả các hàng từ bảng phải', 0)
GO
INSERT [dbo].[answers] ([AnswerID], [QuestionID], [AnswerText], [IsCorrect]) VALUES (52, 14, N'Không có hàng nào', 0)
GO
SET IDENTITY_INSERT [dbo].[answers] OFF
GO
SET IDENTITY_INSERT [dbo].[cart] ON
GO
INSERT [dbo].[cart] ([CartID], [UserID], [Status], [TotalPrice], [CreatedAt]) VALUES (1, 1, N'active', CAST(399000.00 AS Decimal(10, 2)), CAST(N'2025-06-22T15:11:56.810' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[cart] OFF
GO
SET IDENTITY_INSERT [dbo].[cartitem] ON
GO
INSERT [dbo].[cartitem] ([CartItemID], [CartID], [CourseID], [Price]) VALUES (1, 1, 2, CAST(399000.00 AS Decimal(10, 2)))
GO
SET IDENTITY_INSERT [dbo].[cartitem] OFF
GO
SET IDENTITY_INSERT [dbo].[categories] ON
GO
INSERT [dbo].[categories] ([CategoryID], [Name], [Description], [CreatedAt]) VALUES (1, N'Lập trình', N'Các khóa học lập trình từ cơ bản đến nâng cao', CAST(N'2025-06-22T15:07:18.657' AS DateTime))
GO
INSERT [dbo].[categories] ([CategoryID], [Name], [Description], [CreatedAt]) VALUES (2, N'Thiết kế web', N'Khóa học về HTML, CSS, JavaScript và UX/UI', CAST(N'2025-06-22T15:07:18.657' AS DateTime))
GO
INSERT [dbo].[categories] ([CategoryID], [Name], [Description], [CreatedAt]) VALUES (3, N'Cơ sở dữ liệu', N'Khóa học về thiết kế, tối ưu và sử dụng CSDL', CAST(N'2025-06-22T15:07:18.657' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[categories] OFF
GO
INSERT [dbo].[course_progress] ([UserID], [CourseID], [CompletedLessons], [TotalLessons], [ProgressPercent], [LastAccessed]) VALUES (1, 1, 2, 2, 100, CAST(N'2025-06-22T15:12:08.317' AS DateTime))
GO
INSERT [dbo].[course_progress] ([UserID], [CourseID], [CompletedLessons], [TotalLessons], [ProgressPercent], [LastAccessed]) VALUES (1, 2, 1, 2, 50, CAST(N'2025-06-22T15:12:08.317' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[courses] ON
GO
INSERT [dbo].[courses] ([CourseID], [Title], [Description], [Price], [Rating], [CreatedAt], [ImageURL], [InstructorID], [CategoryID], [Status]) VALUES (1, N'L?p trình Java co b?n', N'Khóa học nhập môn Java cho người mới bắt đầu.', CAST(499000.00 AS Decimal(10, 2)), 4.5, CAST(N'2025-06-22T15:07:29.763' AS DateTime), NULL, 2, 1, N'active')
GO
INSERT [dbo].[courses] ([CourseID], [Title], [Description], [Price], [Rating], [CreatedAt], [ImageURL], [InstructorID], [CategoryID], [Status]) VALUES (2, N'Thi?t k? Web v?i HTML/CSS', N'Học HTML/CSS từ cơ bản đến nâng cao.', CAST(399000.00 AS Decimal(10, 2)), 4.2, CAST(N'2025-06-22T15:07:29.763' AS DateTime), NULL, 2, 2, N'active')
GO
INSERT [dbo].[courses] ([CourseID], [Title], [Description], [Price], [Rating], [CreatedAt], [ImageURL], [InstructorID], [CategoryID], [Status]) VALUES (3, N'SQL Server chuyên sâu', N'Thiết kế và tối ưu cơ sở dữ liệu trên SQL Server.', CAST(599000.00 AS Decimal(10, 2)), 4.8, CAST(N'2025-06-22T15:07:29.763' AS DateTime), NULL, 2, 3, N'draft')
GO
INSERT [dbo].[courses] ([CourseID], [Title], [Description], [Price], [Rating], [CreatedAt], [ImageURL], [InstructorID], [CategoryID], [Status]) VALUES (4, N'Python cho người mới bắt đầu', N'Khóa học Python cho người mới bắt đầu dành cho người học từ cơ bản đến nâng cao.', CAST(599000.00 AS Decimal(10, 2)), 4.6, CAST(N'2025-06-22T15:07:29.000' AS DateTime), NULL, 2, 1, N'draft')
GO
INSERT [dbo].[courses] ([CourseID], [Title], [Description], [Price], [Rating], [CreatedAt], [ImageURL], [InstructorID], [CategoryID], [Status]) VALUES (5, N'JavaScript nâng cao', N'Khóa học JavaScript nâng cao dành cho người học từ cơ bản đến nâng cao.', CAST(599000.00 AS Decimal(10, 2)), 4, CAST(N'2025-06-22T15:07:29.000' AS DateTime), NULL, 2, 2, N'inactive')
GO
INSERT [dbo].[courses] ([CourseID], [Title], [Description], [Price], [Rating], [CreatedAt], [ImageURL], [InstructorID], [CategoryID], [Status]) VALUES (6, N'ReactJS thực chiến', N'Khóa học ReactJS thực chiến dành cho người học từ cơ bản đến nâng cao.', CAST(499000.00 AS Decimal(10, 2)), 3.9, CAST(N'2025-06-22T15:07:29.000' AS DateTime), NULL, 2, 2, N'draft')
GO
INSERT [dbo].[courses] ([CourseID], [Title], [Description], [Price], [Rating], [CreatedAt], [ImageURL], [InstructorID], [CategoryID], [Status]) VALUES (7, N'Node.js và Express', N'Khóa học Node.js và Express dành cho người học từ cơ bản đến nâng cao.', CAST(599000.00 AS Decimal(10, 2)), 3.9, CAST(N'2025-06-22T15:07:29.000' AS DateTime), NULL, 2, 2, N'inactive')
GO
INSERT [dbo].[courses] ([CourseID], [Title], [Description], [Price], [Rating], [CreatedAt], [ImageURL], [InstructorID], [CategoryID], [Status]) VALUES (8, N'C# và .NET cơ bản', N'Khóa học C# và .NET cơ bản dành cho người học từ cơ bản đến nâng cao.', CAST(399000.00 AS Decimal(10, 2)), 4.7, CAST(N'2025-06-22T15:07:29.000' AS DateTime), NULL, 2, 1, N'draft')
GO
INSERT [dbo].[courses] ([CourseID], [Title], [Description], [Price], [Rating], [CreatedAt], [ImageURL], [InstructorID], [CategoryID], [Status]) VALUES (9, N'Lập trình Kotlin', N'Khóa học Lập trình Kotlin dành cho người học từ cơ bản đến nâng cao.', CAST(299000.00 AS Decimal(10, 2)), 3.9, CAST(N'2025-06-22T15:07:29.000' AS DateTime), NULL, 2, 1, N'inactive')
GO
INSERT [dbo].[courses] ([CourseID], [Title], [Description], [Price], [Rating], [CreatedAt], [ImageURL], [InstructorID], [CategoryID], [Status]) VALUES (10, N'Swift cho iOS', N'Khóa học Swift cho iOS dành cho người học từ cơ bản đến nâng cao.', CAST(299000.00 AS Decimal(10, 2)), 3.5, CAST(N'2025-06-22T15:07:29.000' AS DateTime), NULL, 2, 1, N'active')
GO
INSERT [dbo].[courses] ([CourseID], [Title], [Description], [Price], [Rating], [CreatedAt], [ImageURL], [InstructorID], [CategoryID], [Status]) VALUES (11, N'PHP & MySQL', N'Khóa học PHP & MySQL dành cho người học từ cơ bản đến nâng cao.', CAST(499000.00 AS Decimal(10, 2)), 4.2, CAST(N'2025-06-22T15:07:29.000' AS DateTime), NULL, 2, 1, N'inactive')
GO
INSERT [dbo].[courses] ([CourseID], [Title], [Description], [Price], [Rating], [CreatedAt], [ImageURL], [InstructorID], [CategoryID], [Status]) VALUES (12, N'Docker và Kubernetes', N'Khóa học Docker và Kubernetes dành cho người học từ cơ bản đến nâng cao.', CAST(499000.00 AS Decimal(10, 2)), 3.9, CAST(N'2025-06-22T15:07:29.000' AS DateTime), NULL, 2, 1, N'inactive')
GO
INSERT [dbo].[courses] ([CourseID], [Title], [Description], [Price], [Rating], [CreatedAt], [ImageURL], [InstructorID], [CategoryID], [Status]) VALUES (13, N'Machine Learning cơ bản', N'Khóa học Machine Learning cơ bản dành cho người học từ cơ bản đến nâng cao.', CAST(599000.00 AS Decimal(10, 2)), 4.1, CAST(N'2025-06-22T15:07:29.000' AS DateTime), NULL, 2, 3, N'inactive')
GO
INSERT [dbo].[courses] ([CourseID], [Title], [Description], [Price], [Rating], [CreatedAt], [ImageURL], [InstructorID], [CategoryID], [Status]) VALUES (14, N'Trí tuệ nhân tạo', N'Khóa học Trí tuệ nhân tạo dành cho người học từ cơ bản đến nâng cao.', CAST(599000.00 AS Decimal(10, 2)), 4.5, CAST(N'2025-06-22T15:07:29.000' AS DateTime), NULL, 2, 3, N'draft')
GO
INSERT [dbo].[courses] ([CourseID], [Title], [Description], [Price], [Rating], [CreatedAt], [ImageURL], [InstructorID], [CategoryID], [Status]) VALUES (15, N'Phân tích dữ liệu với Python', N'Khóa học Phân tích dữ liệu với Python dành cho người học từ cơ bản đến nâng cao.', CAST(599000.00 AS Decimal(10, 2)), 4.6, CAST(N'2025-06-22T15:07:29.000' AS DateTime), NULL, 2, 3, N'active')
GO
INSERT [dbo].[courses] ([CourseID], [Title], [Description], [Price], [Rating], [CreatedAt], [ImageURL], [InstructorID], [CategoryID], [Status]) VALUES (16, N'Tư duy thuật toán', N'Khóa học Tư duy thuật toán dành cho người học từ cơ bản đến nâng cao.', CAST(399000.00 AS Decimal(10, 2)), 4.4, CAST(N'2025-06-22T15:07:29.000' AS DateTime), NULL, 2, 1, N'active')
GO
INSERT [dbo].[courses] ([CourseID], [Title], [Description], [Price], [Rating], [CreatedAt], [ImageURL], [InstructorID], [CategoryID], [Status]) VALUES (17, N'Lập trình Android', N'Khóa học Lập trình Android dành cho người học từ cơ bản đến nâng cao.', CAST(499000.00 AS Decimal(10, 2)), 4, CAST(N'2025-06-22T15:07:29.000' AS DateTime), NULL, 2, 1, N'draft')
GO
INSERT [dbo].[courses] ([CourseID], [Title], [Description], [Price], [Rating], [CreatedAt], [ImageURL], [InstructorID], [CategoryID], [Status]) VALUES (18, N'DevOps Fundamentals', N'Khóa học DevOps Fundamentals dành cho người học từ cơ bản đến nâng cao.', CAST(499000.00 AS Decimal(10, 2)), 4.3, CAST(N'2025-06-22T15:07:29.000' AS DateTime), NULL, 2, 1, N'inactive')
GO
INSERT [dbo].[courses] ([CourseID], [Title], [Description], [Price], [Rating], [CreatedAt], [ImageURL], [InstructorID], [CategoryID], [Status]) VALUES (19, N'AWS Cloud Essentials', N'Khóa học AWS Cloud Essentials dành cho người học từ cơ bản đến nâng cao.', CAST(699000.00 AS Decimal(10, 2)), 4.7, CAST(N'2025-06-22T15:07:29.000' AS DateTime), NULL, 2, 1, N'active')
GO
INSERT [dbo].[courses] ([CourseID], [Title], [Description], [Price], [Rating], [CreatedAt], [ImageURL], [InstructorID], [CategoryID], [Status]) VALUES (20, N'UI/UX Design', N'Khóa học UI/UX Design dành cho người học từ cơ bản đến nâng cao.', CAST(399000.00 AS Decimal(10, 2)), 3.9, CAST(N'2025-06-22T15:07:29.000' AS DateTime), NULL, 2, 2, N'active')
GO
INSERT [dbo].[courses] ([CourseID], [Title], [Description], [Price], [Rating], [CreatedAt], [ImageURL], [InstructorID], [CategoryID], [Status]) VALUES (21, N'Lập trình game Unity', N'Khóa học Lập trình game Unity dành cho người học từ cơ bản đến nâng cao.', CAST(499000.00 AS Decimal(10, 2)), 4.4, CAST(N'2025-06-22T15:07:29.000' AS DateTime), NULL, 2, 1, N'draft')
GO
INSERT [dbo].[courses] ([CourseID], [Title], [Description], [Price], [Rating], [CreatedAt], [ImageURL], [InstructorID], [CategoryID], [Status]) VALUES (22, N'Cybersecurity 101', N'Khóa học Cybersecurity 101 dành cho người học từ cơ bản đến nâng cao.', CAST(599000.00 AS Decimal(10, 2)), 4.2, CAST(N'2025-06-22T15:07:29.000' AS DateTime), NULL, 2, 3, N'inactive')
GO
INSERT [dbo].[courses] ([CourseID], [Title], [Description], [Price], [Rating], [CreatedAt], [ImageURL], [InstructorID], [CategoryID], [Status]) VALUES (23, N'Blockchain cơ bản', N'Khóa học Blockchain cơ bản dành cho người học từ cơ bản đến nâng cao.', CAST(599000.00 AS Decimal(10, 2)), 4.3, CAST(N'2025-06-22T15:07:29.000' AS DateTime), NULL, 2, 3, N'active')
GO
SET IDENTITY_INSERT [dbo].[courses] OFF
GO
SET IDENTITY_INSERT [dbo].[enrollments] ON
GO
INSERT [dbo].[enrollments] ([enrollment_id], [student_id], [course_id], [enrollment_date], [completion_date], [progress_percentage], [status], [grade], [certificate_issued]) VALUES (1, 1, 1, CAST(N'2025-06-22T15:11:45.9600000' AS DateTime2), NULL, CAST(80.00 AS Decimal(5, 2)), N'COMPLETED', CAST(9.50 AS Decimal(5, 2)), 1)
GO
INSERT [dbo].[enrollments] ([enrollment_id], [student_id], [course_id], [enrollment_date], [completion_date], [progress_percentage], [status], [grade], [certificate_issued]) VALUES (2, 1, 2, CAST(N'2025-06-22T15:11:45.9600000' AS DateTime2), NULL, CAST(40.00 AS Decimal(5, 2)), N'ACTIVE', NULL, 0)
GO
SET IDENTITY_INSERT [dbo].[enrollments] OFF
GO
SET IDENTITY_INSERT [dbo].[feedback] ON
GO
INSERT [dbo].[feedback] ([FeedbackID], [CourseID], [UserID], [Rating], [Comment], [CreatedAt]) VALUES (1, 1, 1, 5, N'Khóa học rất hữu ích và dễ hiểu', CAST(N'2025-06-22T15:11:51.657' AS DateTime))
GO
INSERT [dbo].[feedback] ([FeedbackID], [CourseID], [UserID], [Rating], [Comment], [CreatedAt]) VALUES (2, 2, 1, 4, N'Nội dung ổn, nên thêm ví dụ thực tế', CAST(N'2025-06-22T15:11:51.657' AS DateTime))
GO
INSERT [dbo].[feedback] ([FeedbackID], [CourseID], [UserID], [Rating], [Comment], [CreatedAt]) VALUES (3, 3, 1, 5, N'Rất chi tiết, phù hợp với người mới bắt đầu học SQL Server.', CAST(N'2025-06-22T15:39:35.717' AS DateTime))
GO
INSERT [dbo].[feedback] ([FeedbackID], [CourseID], [UserID], [Rating], [Comment], [CreatedAt]) VALUES (4, 4, 1, 5, N'Python dễ hiểu, bài giảng mạch lạc.', CAST(N'2025-06-22T15:39:35.717' AS DateTime))
GO
INSERT [dbo].[feedback] ([FeedbackID], [CourseID], [UserID], [Rating], [Comment], [CreatedAt]) VALUES (5, 5, 1, 4, N'Nên có thêm bài tập thực hành nâng cao.', CAST(N'2025-06-22T15:39:35.717' AS DateTime))
GO
INSERT [dbo].[feedback] ([FeedbackID], [CourseID], [UserID], [Rating], [Comment], [CreatedAt]) VALUES (6, 6, 1, 5, N'ReactJS được hướng dẫn rất rõ ràng, có ví dụ thực tế.', CAST(N'2025-06-22T15:39:35.717' AS DateTime))
GO
INSERT [dbo].[feedback] ([FeedbackID], [CourseID], [UserID], [Rating], [Comment], [CreatedAt]) VALUES (7, 7, 1, 4, N'Node.js và Express cần có thêm hướng dẫn triển khai.', CAST(N'2025-06-22T15:39:35.717' AS DateTime))
GO
INSERT [dbo].[feedback] ([FeedbackID], [CourseID], [UserID], [Rating], [Comment], [CreatedAt]) VALUES (8, 8, 1, 5, N'Tốt cho người mới học .NET và C#.', CAST(N'2025-06-22T15:39:35.717' AS DateTime))
GO
INSERT [dbo].[feedback] ([FeedbackID], [CourseID], [UserID], [Rating], [Comment], [CreatedAt]) VALUES (9, 9, 1, 3, N'Khóa học hơi nhanh, phù hợp với người có nền tảng.', CAST(N'2025-06-22T15:39:35.717' AS DateTime))
GO
INSERT [dbo].[feedback] ([FeedbackID], [CourseID], [UserID], [Rating], [Comment], [CreatedAt]) VALUES (10, 10, 1, 4, N'Swift được trình bày rõ ràng, dễ làm theo.', CAST(N'2025-06-22T15:39:35.717' AS DateTime))
GO
INSERT [dbo].[feedback] ([FeedbackID], [CourseID], [UserID], [Rating], [Comment], [CreatedAt]) VALUES (11, 11, 1, 4, N'Tổng quan tốt về PHP & MySQL, nên thêm phần nâng cao.', CAST(N'2025-06-22T15:39:35.717' AS DateTime))
GO
INSERT [dbo].[feedback] ([FeedbackID], [CourseID], [UserID], [Rating], [Comment], [CreatedAt]) VALUES (12, 12, 1, 5, N'Docker và Kubernetes giải thích dễ hiểu, phù hợp với dev.', CAST(N'2025-06-22T15:39:35.717' AS DateTime))
GO
INSERT [dbo].[feedback] ([FeedbackID], [CourseID], [UserID], [Rating], [Comment], [CreatedAt]) VALUES (13, 13, 1, 5, N'Khóa học giúp tôi hiểu rõ các khái niệm ML cơ bản.', CAST(N'2025-06-22T15:39:35.717' AS DateTime))
GO
INSERT [dbo].[feedback] ([FeedbackID], [CourseID], [UserID], [Rating], [Comment], [CreatedAt]) VALUES (14, 14, 1, 4, N'Khóa học bổ ích, nhưng phần ví dụ còn đơn giản.', CAST(N'2025-06-22T15:39:35.717' AS DateTime))
GO
INSERT [dbo].[feedback] ([FeedbackID], [CourseID], [UserID], [Rating], [Comment], [CreatedAt]) VALUES (15, 15, 1, 5, N'Trình bày chi tiết và có tính hệ thống cao.', CAST(N'2025-06-22T15:39:35.717' AS DateTime))
GO
INSERT [dbo].[feedback] ([FeedbackID], [CourseID], [UserID], [Rating], [Comment], [CreatedAt]) VALUES (16, 16, 1, 4, N'Hay nhưng tốc độ bài giảng hơi nhanh.', CAST(N'2025-06-22T15:39:35.717' AS DateTime))
GO
INSERT [dbo].[feedback] ([FeedbackID], [CourseID], [UserID], [Rating], [Comment], [CreatedAt]) VALUES (17, 17, 1, 5, N'Tốt cho người muốn học nhanh về Vue.', CAST(N'2025-06-22T15:39:35.717' AS DateTime))
GO
INSERT [dbo].[feedback] ([FeedbackID], [CourseID], [UserID], [Rating], [Comment], [CreatedAt]) VALUES (18, 18, 1, 3, N'Bài giảng được nhưng cần thêm tài liệu kèm theo.', CAST(N'2025-06-22T15:39:35.717' AS DateTime))
GO
INSERT [dbo].[feedback] ([FeedbackID], [CourseID], [UserID], [Rating], [Comment], [CreatedAt]) VALUES (19, 19, 1, 4, N'Nội dung phù hợp, có phần tương tác tốt.', CAST(N'2025-06-22T15:39:35.717' AS DateTime))
GO
INSERT [dbo].[feedback] ([FeedbackID], [CourseID], [UserID], [Rating], [Comment], [CreatedAt]) VALUES (20, 20, 1, 5, N'Cực kỳ hay và dễ áp dụng trong thực tế.', CAST(N'2025-06-22T15:39:35.717' AS DateTime))
GO
INSERT [dbo].[feedback] ([FeedbackID], [CourseID], [UserID], [Rating], [Comment], [CreatedAt]) VALUES (21, 21, 1, 4, N'Khóa học đáng tiền, nội dung đúng nhu cầu.', CAST(N'2025-06-22T15:39:35.717' AS DateTime))
GO
INSERT [dbo].[feedback] ([FeedbackID], [CourseID], [UserID], [Rating], [Comment], [CreatedAt]) VALUES (22, 22, 1, 5, N'Các kiến thức về frontend được tổng hợp logic.', CAST(N'2025-06-22T15:39:35.717' AS DateTime))
GO
INSERT [dbo].[feedback] ([FeedbackID], [CourseID], [UserID], [Rating], [Comment], [CreatedAt]) VALUES (23, 23, 1, 4, N'Nội dung đủ dùng, phù hợp với người tự học.', CAST(N'2025-06-22T15:39:35.717' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[feedback] OFF
GO
SET IDENTITY_INSERT [dbo].[lessons] ON
GO
INSERT [dbo].[lessons] ([LessonID], [CourseID], [Title], [Content], [Status], [IsFreePreview], [CreatedAt]) VALUES (1, 3, N'Câu lệnh SELECT trong SQL Server', N'
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>SQL Server - SELECT</title>
  <style>
    body { font-family: Arial, sans-serif; line-height: 1.6; padding: 20px; }
    h1, h2 { color: #2c3e50; }
    code, pre { background-color: #f4f4f4; padding: 10px; display: block; border-left: 4px solid #3498db; margin: 10px 0; }
    .note { background-color: #e7f3fe; padding: 10px; border-left: 4px solid #2196F3; margin: 15px 0; }
    table { border-collapse: collapse; width: 100%; margin-top: 20px; }
    th, td { border: 1px solid #ccc; padding: 8px; text-align: left; }
    th { background-color: #f9f9f9; }
  </style>
</head>
<body>

<h1>SQL SELECT</h1>
<p>Lệnh <strong>SELECT</strong> trong SQL Server được dùng để truy vấn dữ liệu từ một hoặc nhiều bảng trong cơ sở dữ liệu.</p>

<h2>Cú pháp:</h2>
<pre><code>SELECT column1, column2, ...
FROM table_name;</code></pre>

<p>Hoặc để lấy tất cả các cột:</p>
<pre><code>SELECT * FROM table_name;</code></pre>

<div class="note">
  <strong>Lưu ý:</strong> Dấu sao (*) sẽ lấy tất cả các cột nhưng nên tránh dùng trong hệ thống lớn vì có thể ảnh hưởng đến hiệu suất.
</div>

<h2>Ví dụ thực tế</h2>
<p>Giả sử bạn có bảng <code>Customers</code> như sau:</p>

<table>
  <thead>
    <tr><th>CustomerID</th><th>Name</th><th>City</th><th>Country</th></tr>
  </thead>
  <tbody>
    <tr><td>1</td><td>Nguyễn Văn A</td><td>Hà Nội</td><td>Việt Nam</td></tr>
    <tr><td>2</td><td>Trần Thị B</td><td>TP.HCM</td><td>Việt Nam</td></tr>
    <tr><td>3</td><td>John Doe</td><td>New York</td><td>USA</td></tr>
  </tbody>
</table>

<p>Lấy toàn bộ dữ liệu từ bảng:</p>
<pre><code>SELECT * FROM Customers;</code></pre>

<p>Lấy tên và thành phố:</p>
<pre><code>SELECT Name, City FROM Customers;</code></pre>

<h2>SELECT với WHERE</h2>
<p>Sử dụng mệnh đề <code>WHERE</code> để lọc dữ liệu:</p>
<pre><code>SELECT * FROM Customers
WHERE Country = N''Việt Nam'';</code></pre>

<h2>SELECT với ORDER BY</h2>
<p>Sắp xếp kết quả theo một hoặc nhiều cột:</p>
<pre><code>SELECT * FROM Customers
ORDER BY City ASC;</code></pre>

<h2>SELECT với TOP</h2>
<p>Lấy một số lượng dòng nhất định (ví dụ: top 5 khách hàng):</p>
<pre><code>SELECT TOP 5 * FROM Customers;</code></pre>

<h2>Thực hành</h2>
<p>Bạn có thể thực hành lệnh SELECT trên SQL Server Management Studio (SSMS) hoặc các công cụ học online.</p>

</body>
</html>
', N'published', 1, CAST(N'2025-06-22T15:10:18.717' AS DateTime))
GO
INSERT [dbo].[lessons] ([LessonID], [CourseID], [Title], [Content], [Status], [IsFreePreview], [CreatedAt]) VALUES (2, 1, N'Cài đặt và chạy chương trình Java đầu tiên', N'
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Java Hello World</title>
  <style>
    body { font-family: Arial; padding: 20px; }
    h1 { color: #e67e22; }
    code, pre {
      background-color: #f4f4f4; padding: 10px;
      display: block; border-left: 4px solid #e67e22;
      margin: 10px 0;
    }
    .tip { background: #fcf3cf; padding: 10px; border-left: 4px solid #f1c40f; }
  </style>
</head>
<body>

<h1>Chạy chương trình Java đầu tiên</h1>

<p>Đây là các bước cơ bản để bạn viết và chạy một chương trình Java đầu tiên trên máy tính cá nhân.</p>

<h2>Bước 1: Cài đặt JDK</h2>
<p>Tải và cài đặt <strong>Java Development Kit (JDK)</strong> từ trang chính thức: <a href="https://www.oracle.com/java/technologies/javase-downloads.html">Oracle Java</a></p>

<h2>Bước 2: Cài đặt trình soạn thảo</h2>
<p>Các trình soạn thảo phổ biến:</p>
<ul>
  <li>Visual Studio Code</li>
  <li>IntelliJ IDEA</li>
  <li>Eclipse</li>
</ul>

<h2>Bước 3: Viết chương trình HelloWorld</h2>
<pre><code>public class HelloWorld {
    public static void main(String[] args) {
        System.out.println("Xin chào, Java!");
    }
}</code></pre>

<h2>Bước 4: Biên dịch và chạy</h2>
<pre><code>// Biên dịch
javac HelloWorld.java

// Chạy chương trình
java HelloWorld</code></pre>

<div class="tip">
  <strong>Mẹo:</strong> Đảm bảo biến môi trường <code>JAVA_HOME</code> được thiết lập chính xác.
</div>

<h2>Kết quả</h2>
<pre><code>Xin chào, Java!</code></pre>

</body>
</html>
', N'published', 1, CAST(N'2025-06-22T15:10:49.757' AS DateTime))
GO
INSERT [dbo].[lessons] ([LessonID], [CourseID], [Title], [Content], [Status], [IsFreePreview], [CreatedAt]) VALUES (3, 2, N'Cấu trúc cơ bản của một trang HTML', N'
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>HTML Cơ bản</title>
  <style>
    body { font-family: "Segoe UI", sans-serif; padding: 20px; }
    h1 { color: #2e86de; }
    code, pre {
      background-color: #f1f1f1; padding: 10px;
      border-left: 4px solid #3498db; margin: 10px 0;
    }
    .note { background: #eaf2f8; padding: 10px; border-left: 4px solid #2980b9; }
  </style>
</head>
<body>

<h1>HTML Cơ bản</h1>

<p>HTML là ngôn ngữ đánh dấu được sử dụng để xây dựng cấu trúc của trang web.</p>

<h2>Cấu trúc cơ bản</h2>
<pre><code>&lt;!DOCTYPE html&gt;
&lt;html&gt;
  &lt;head&gt;
    &lt;meta charset="UTF-8"&gt;
    &lt;title&gt;Tiêu đề trang&lt;/title&gt;
  &lt;/head&gt;
  &lt;body&gt;
    &lt;h1&gt;Xin chào thế giới&lt;/h1&gt;
    &lt;p&gt;Đây là đoạn văn bản đầu tiên.&lt;/p&gt;
  &lt;/body&gt;
&lt;/html&gt;
</code></pre>

<h2>Giải thích</h2>
<ul>
  <li><code>&lt;!DOCTYPE html&gt;</code>: Khai báo phiên bản HTML5</li>
  <li><code>&lt;html&gt;</code>: Phần gốc của tài liệu</li>
  <li><code>&lt;head&gt;</code>: Meta, title, css,...</li>
  <li><code>&lt;body&gt;</code>: Nội dung hiển thị chính</li>
</ul>

<div class="note">
  <strong>Lưu ý:</strong> Mỗi trang HTML nên có 1 thẻ <code>title</code> và 1 thẻ <code>h1</code> chính.
</div>

<h2>Bạn có thể thực hành ở đâu?</h2>
<ul>
  <li>Trực tiếp trong VS Code</li>
  <li><a href="https://jsfiddle.net">JSFiddle</a>, <a href="https://codepen.io">Codepen</a></li>
</ul>

</body>
</html>
', N'published', 1, CAST(N'2025-06-22T15:11:02.073' AS DateTime))
GO
INSERT [dbo].[lessons] ([LessonID], [CourseID], [Title], [Content], [Status], [IsFreePreview], [CreatedAt]) VALUES (4, 1, N'Biến và Kiểu dữ liệu trong Java', N'<!DOCTYPE html><html lang="vi"><head><meta charset="UTF-8"><title>Java - Biến và Kiểu Dữ Liệu</title><style>body { font-family: Arial; padding: 20px; line-height: 1.6; } h1, h2 { color: #e67e22; } pre, code { background: #f8f8f8; padding: 10px; display: block; border-left: 4px solid #e67e22; margin: 10px 0; }</style></head><body><h1>Biến và Kiểu dữ liệu trong Java</h1><p>Biến là vùng nhớ được cấp phát để lưu trữ dữ liệu và mỗi biến phải có một kiểu dữ liệu xác định.</p><h2>1. Khai báo biến</h2><pre><code>int age = 25;\ndouble salary = 5000.5;\nchar grade = \''A\'';\nboolean isPassed = true;\nString name = "Nguyen Van A";</code></pre><h2>2. Các kiểu dữ liệu cơ bản</h2><ul><li><strong>int</strong> - số nguyên</li><li><strong>double</strong> - số thực</li><li><strong>boolean</strong> - true/false</li><li><strong>char</strong> - ký tự đơn</li><li><strong>String</strong> - chuỗi ký tự</li></ul><h2>3. Quy tắc đặt tên biến</h2><ul><li>Không bắt đầu bằng số</li><li>Không dùng từ khóa Java</li></ul><h2>4. Ví dụ</h2><pre><code>public class Main {\n  public static void main(String[] args) {\n    int a = 10;\n    double pi = 3.14;\n    boolean isJavaFun = true;\n    String message = "Xin chào Java!";\n    System.out.println(message);\n  }\n}</code></pre><h2>5. Kết luận</h2><p>Biến và kiểu dữ liệu là phần quan trọng trong Java.</p></body></html>', N'published', 1, CAST(N'2025-06-22T15:16:40.060' AS DateTime))
GO
INSERT [dbo].[lessons] ([LessonID], [CourseID], [Title], [Content], [Status], [IsFreePreview], [CreatedAt]) VALUES (5, 2, N'Giới thiệu về CSS', N'<!DOCTYPE html><html lang="vi"><head><meta charset="UTF-8"><title>Giới thiệu về CSS</title><style>body { font-family: sans-serif; padding: 20px; line-height: 1.6; } h1 { color: #2980b9; } pre, code { background: #f0f0f0; padding: 10px; display: block; border-left: 4px solid #3498db; margin: 10px 0; }</style></head><body><h1>Giới thiệu về CSS</h1><p>CSS (Cascading Style Sheets) được dùng để định dạng nội dung HTML.</p><h2>1. Ba cách nhúng CSS</h2><ul><li>Inline</li><li>Internal</li><li>External</li></ul><h2>2. Ví dụ</h2><pre><code>&lt;style&gt;\nh1 {\n  color: blue;\n  font-size: 28px;\n}\n&lt;/style&gt;</code></pre><h2>3. Selectors</h2><ul><li>tag, .class, #id</li></ul><h2>4. Thuộc tính phổ biến</h2><pre><code>p {\n  color: #333;\n  font-family: Arial;\n}</code></pre><h2>5. Kết luận</h2><p>CSS giúp trang web trở nên sinh động, dễ nhìn.</p></body></html>', N'published', 1, CAST(N'2025-06-22T15:16:46.123' AS DateTime))
GO
INSERT [dbo].[lessons] ([LessonID], [CourseID], [Title], [Content], [Status], [IsFreePreview], [CreatedAt]) VALUES (6, 3, N'Mệnh đề JOIN trong SQL Server', N'<!DOCTYPE html><html lang="vi"><head><meta charset="UTF-8"><title>SQL JOIN</title><style>body { font-family: sans-serif; padding: 20px; } pre, code { background: #f9f9f9; padding: 10px; display: block; border-left: 4px solid #2ecc71; margin: 10px 0; }</style></head><body><h1>SQL JOIN</h1><p>Kết hợp dữ liệu từ nhiều bảng.</p><h2>1. INNER JOIN</h2><pre><code>SELECT Orders.OrderID, Customers.Name\nFROM Orders\nINNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID;</code></pre><h2>2. LEFT JOIN</h2><pre><code>SELECT Customers.Name, Orders.OrderID\nFROM Customers\nLEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID;</code></pre><h2>3. RIGHT JOIN</h2><pre><code>SELECT Orders.OrderID, Customers.Name\nFROM Orders\nRIGHT JOIN Customers ON Orders.CustomerID = Customers.CustomerID;</code></pre><h2>4. FULL OUTER JOIN</h2><pre><code>SELECT Customers.Name, Orders.OrderID\nFROM Customers\nFULL OUTER JOIN Orders ON Customers.CustomerID = Orders.CustomerID;</code></pre><h2>5. Kết luận</h2><p>JOIN giúp khai thác dữ liệu liên bảng.</p></body></html>', N'published', 1, CAST(N'2025-06-22T15:16:56.270' AS DateTime))
GO
INSERT [dbo].[lessons] ([LessonID], [CourseID], [Title], [Content], [Status], [IsFreePreview], [CreatedAt]) VALUES (7, 4, N'Giới thiệu về lập trình Python', N'
<h1>Giới thiệu về Python</h1>
<p>Python là một ngôn ngữ lập trình bậc cao, dễ học và mạnh mẽ, được sử dụng rộng rãi trong nhiều lĩnh vực như phát triển web, khoa học dữ liệu, trí tuệ nhân tạo và nhiều lĩnh vực khác.</p>

<h2>Tại sao nên học Python?</h2>
<ul>
  <li>Dễ học với cú pháp gần gũi ngôn ngữ tự nhiên</li>
  <li>Cộng đồng lớn và thư viện phong phú</li>
  <li>Đa năng: Web, ML, Tự động hóa, Game,...</li>
</ul>

<h2>Chương trình Python đầu tiên</h2>
<pre><code class="language-python">
print("Chào mừng bạn đến với Python!")
</code></pre>

<h2>Cài đặt Python</h2>
<ol>
  <li>Truy cập <a href="https://www.python.org/downloads/">python.org</a></li>
  <li>Tải phiên bản mới nhất và cài đặt</li>
  <li>Kiểm tra bằng lệnh <code>python --version</code></li>
</ol>

<p><strong>Bài tập:</strong> Viết chương trình in ra tên của bạn và tuổi.</p>
', N'published', 0, CAST(N'2025-06-22T15:40:00.000' AS DateTime))
GO
INSERT [dbo].[lessons] ([LessonID], [CourseID], [Title], [Content], [Status], [IsFreePreview], [CreatedAt]) VALUES (8, 4, N'Cấu trúc điều kiện và vòng lặp', N'
<h1>Điều kiện và vòng lặp trong Python</h1>

<h2>1. Câu lệnh điều kiện <code>if</code></h2>
<pre><code class="language-python">
age = 18
if age >= 18:
    print("Bạn đã đủ tuổi trưởng thành")
</code></pre>

<h2>2. Cấu trúc if-else</h2>
<pre><code class="language-python">
x = 10
if x > 0:
    print("Số dương")
else:
    print("Số âm hoặc bằng 0")
</code></pre>

<h2>3. Vòng lặp <code>for</code></h2>
<pre><code class="language-python">
for i in range(5):
    print("Lần lặp thứ", i)
</code></pre>

<h2>4. Vòng lặp <code>while</code></h2>
<pre><code class="language-python">
i = 0
while i < 3:
    print("i =", i)
    i += 1
</code></pre>

<p><strong>Bài tập:</strong> Viết chương trình in ra các số từ 1 đến 100 chia hết cho 5.</p>
', N'published', 0, CAST(N'2025-06-22T15:42:00.000' AS DateTime))
GO
INSERT [dbo].[lessons] ([LessonID], [CourseID], [Title], [Content], [Status], [IsFreePreview], [CreatedAt]) VALUES (9, 4, N'Hàm và biến trong Python', N'
<h1>Làm việc với Hàm và Biến</h1>

<h2>1. Biến trong Python</h2>
<pre><code class="language-python">
name = "An"
age = 20
is_student = True
</code></pre>

<h2>2. Kiểu dữ liệu phổ biến</h2>
<ul>
  <li><code>int</code>: số nguyên</li>
  <li><code>float</code>: số thực</li>
  <li><code>str</code>: chuỗi</li>
  <li><code>bool</code>: đúng/sai</li>
</ul>

<h2>3. Hàm (Functions)</h2>
<pre><code class="language-python">
def greet(name):
    return f"Xin chào, {name}!"

print(greet("Minh"))
</code></pre>

<h2>4. Hàm có giá trị trả về</h2>
<pre><code class="language-python">
def add(a, b):
    return a + b

print(add(3, 5))  # Output: 8
</code></pre>

<p><strong>Bài tập:</strong> Viết hàm kiểm tra một số có phải là số nguyên tố không.</p>
', N'published', 1, CAST(N'2025-06-22T15:44:00.000' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[lessons] OFF
GO
SET IDENTITY_INSERT [dbo].[materials] ON
GO
INSERT [dbo].[materials] ([MaterialID], [LessonID], [Title], [FileURL]) VALUES (1, 1, N'Câu lệnh SELECT trong SQL Server', N'/materials/sql/select-statement.pdf')
GO
INSERT [dbo].[materials] ([MaterialID], [LessonID], [Title], [FileURL]) VALUES (2, 2, N'Cài đặt và chạy chương trình Java đầu tiên', N'/materials/java/setup-java.pdf')
GO
INSERT [dbo].[materials] ([MaterialID], [LessonID], [Title], [FileURL]) VALUES (3, 3, N'Cấu trúc cơ bản của một trang HTML', N'/materials/html/basic-structure.pdf')
GO
INSERT [dbo].[materials] ([MaterialID], [LessonID], [Title], [FileURL]) VALUES (4, 4, N'Biến và Kiểu dữ liệu trong Java', N'/materials/java/variables-types.pdf')
GO
INSERT [dbo].[materials] ([MaterialID], [LessonID], [Title], [FileURL]) VALUES (5, 5, N'Giới thiệu về CSS', N'/materials/css/intro-css.pdf')
GO
INSERT [dbo].[materials] ([MaterialID], [LessonID], [Title], [FileURL]) VALUES (6, 6, N'Mệnh đề JOIN trong SQL Server', N'/materials/sql/joins.pdf')
GO
INSERT [dbo].[materials] ([MaterialID], [LessonID], [Title], [FileURL]) VALUES (7, 7, N'Giới thiệu về lập trình Python', N'/materials/python/python-intro.pdf')
GO
INSERT [dbo].[materials] ([MaterialID], [LessonID], [Title], [FileURL]) VALUES (8, 8, N'Cấu trúc điều kiện và vòng lặp', N'/materials/python/conditions-loops.pdf')
GO
INSERT [dbo].[materials] ([MaterialID], [LessonID], [Title], [FileURL]) VALUES (9, 9, N'Hàm và biến trong Python', N'/materials/python/functions-variables.pdf')
GO
SET IDENTITY_INSERT [dbo].[materials] OFF
GO
SET IDENTITY_INSERT [dbo].[orderdetails] ON
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [CourseID], [Price]) VALUES (1, 1, 1, CAST(499000.00 AS Decimal(10, 2)))
GO
SET IDENTITY_INSERT [dbo].[orderdetails] OFF
GO
SET IDENTITY_INSERT [dbo].[orders] ON
GO
INSERT [dbo].[orders] ([OrderID], [UserID], [Status], [PaymentMethod], [TotalAmount], [CreatedAt]) VALUES (1, 1, N'paid', N'VNPAY', CAST(499000.00 AS Decimal(10, 2)), CAST(N'2025-06-22T15:12:02.757' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[orders] OFF
-- GO
-- SET IDENTITY_INSERT [dbo].[question_attempts] ON
GO
INSERT [dbo].[question_attempts] ([AttemptID], [QuestionID], [OptionID], [IsCorrect]) VALUES (1, 1, 2, 1)
GO
INSERT [dbo].[question_attempts] ([AttemptID], [QuestionID], [OptionID], [IsCorrect]) VALUES ( 1, 2, 4, 1)
GO
INSERT [dbo].[question_attempts] ([AttemptID], [QuestionID], [OptionID], [IsCorrect]) VALUES (1, 3, 6, 1)
GO
INSERT [dbo].[question_attempts] ([AttemptID], [QuestionID], [OptionID], [IsCorrect]) VALUES (1, 4, 9, 1)
GO
INSERT [dbo].[question_attempts] ([AttemptID], [QuestionID], [OptionID], [IsCorrect]) VALUES (2, 5, 13, 1)
GO
INSERT [dbo].[question_attempts] ([AttemptID], [QuestionID], [OptionID], [IsCorrect]) VALUES (3, 6, 17, 1)
GO
INSERT [dbo].[question_attempts] ([AttemptID], [QuestionID], [OptionID], [IsCorrect]) VALUES (3, 7, 21, 1)
GO
INSERT [dbo].[question_attempts] ([AttemptID], [QuestionID], [OptionID], [IsCorrect]) VALUES (3, 8, 25, 1)
GO
INSERT [dbo].[question_attempts] ([AttemptID], [QuestionID], [OptionID], [IsCorrect]) VALUES (4, 12, 42, 1)
GO
INSERT [dbo].[question_attempts] ([AttemptID], [QuestionID], [OptionID], [IsCorrect]) VALUES (4, 13, 45, 1)
GO
INSERT [dbo].[question_attempts] ([AttemptID], [QuestionID], [OptionID], [IsCorrect]) VALUES (4, 14, 50, 1)
-- GO
-- SET IDENTITY_INSERT [dbo].[question_attempts] OFF
GO
SET IDENTITY_INSERT [dbo].[questions] ON
GO
INSERT [dbo].[questions] ([QuestionID], [QuizID], [QuestionText]) VALUES (1, 1, N'Java là ngôn ngữ lập trình gì?')
GO
INSERT [dbo].[questions] ([QuestionID], [QuizID], [QuestionText]) VALUES (2, 1, N'Kiểu dữ liệu nào là số nguyên trong Java?')
GO
INSERT [dbo].[questions] ([QuestionID], [QuizID], [QuestionText]) VALUES (3, 2, N'Kiểu dữ liệu nào dùng để lưu số thực?')
GO
INSERT [dbo].[questions] ([QuestionID], [QuizID], [QuestionText]) VALUES (4, 2, N'Đâu là cú pháp đúng để khai báo biến trong Java?')
GO
INSERT [dbo].[questions] ([QuestionID], [QuizID], [QuestionText]) VALUES (5, 2, N'Giá trị mặc định của biến kiểu boolean trong Java là gì?')
GO
INSERT [dbo].[questions] ([QuestionID], [QuizID], [QuestionText]) VALUES (6, 3, N'Bộ chọn nào dùng để chọn phần tử theo class?')
GO
INSERT [dbo].[questions] ([QuestionID], [QuizID], [QuestionText]) VALUES (7, 3, N'Thẻ HTML nào chứa mã CSS nội bộ?')
GO
INSERT [dbo].[questions] ([QuestionID], [QuizID], [QuestionText]) VALUES (8, 3, N'Thuộc tính nào điều chỉnh kích thước chữ?')
GO
INSERT [dbo].[questions] ([QuestionID], [QuizID], [QuestionText]) VALUES (12, 4, N'INNER JOIN dùng để làm gì?')
GO
INSERT [dbo].[questions] ([QuestionID], [QuizID], [QuestionText]) VALUES (13, 4, N'Dạng JOIN nào lấy tất cả dữ liệu từ bảng bên trái?')
GO
INSERT [dbo].[questions] ([QuestionID], [QuizID], [QuestionText]) VALUES (14, 4, N'FULL OUTER JOIN trả kết quả như thế nào?')
GO
SET IDENTITY_INSERT [dbo].[questions] OFF
GO
SET IDENTITY_INSERT [dbo].[quiz_attempts] ON
GO
INSERT [dbo].[quiz_attempts] ([AttemptID], [UserID], [QuizID], [AttemptDate], [Score], [completion_time_minutes]) VALUES (1, 1, 1, CAST(N'2024-11-11T09:00:00.000' AS DateTime), CAST(92.00 AS Decimal(5, 2)), 25)
GO
INSERT [dbo].[quiz_attempts] ([AttemptID], [UserID], [QuizID], [AttemptDate], [Score], [completion_time_minutes]) VALUES (2, 2, 2, CAST(N'2024-11-12T10:00:00.000' AS DateTime), CAST(88.00 AS Decimal(5, 2)), 28)
GO
INSERT [dbo].[quiz_attempts] ([AttemptID], [UserID], [QuizID], [AttemptDate], [Score], [completion_time_minutes]) VALUES (3, 3, 3, CAST(N'2024-11-13T11:00:00.000' AS DateTime), CAST(95.00 AS Decimal(5, 2)), 20)
GO
INSERT [dbo].[quiz_attempts] ([AttemptID], [UserID], [QuizID], [AttemptDate], [Score], [completion_time_minutes]) VALUES (4, 4, 4, CAST(N'2024-11-14T12:00:00.000' AS DateTime), CAST(80.00 AS Decimal(5, 2)), 30)
GO
INSERT [dbo].[quiz_attempts] ([AttemptID], [UserID], [QuizID], [AttemptDate], [Score], [completion_time_minutes]) VALUES (5, 5, 1, CAST(N'2024-11-15T13:00:00.000' AS DateTime), CAST(90.00 AS Decimal(5, 2)), 27)
GO
INSERT [dbo].[quiz_attempts] ([AttemptID], [UserID], [QuizID], [AttemptDate], [Score], [completion_time_minutes]) VALUES (6, 6, 2, CAST(N'2024-11-16T14:00:00.000' AS DateTime), CAST(85.00 AS Decimal(5, 2)), 22)
GO
INSERT [dbo].[quiz_attempts] ([AttemptID], [UserID], [QuizID], [AttemptDate], [Score], [completion_time_minutes]) VALUES (7, 1, 3, CAST(N'2024-11-17T15:00:00.000' AS DateTime), CAST(78.00 AS Decimal(5, 2)), 29)
GO
INSERT [dbo].[quiz_attempts] ([AttemptID], [UserID], [QuizID], [AttemptDate], [Score], [completion_time_minutes]) VALUES (8, 2, 4, CAST(N'2024-11-18T16:00:00.000' AS DateTime), CAST(92.00 AS Decimal(5, 2)), 24)
GO
INSERT [dbo].[quiz_attempts] ([AttemptID], [UserID], [QuizID], [AttemptDate], [Score], [completion_time_minutes]) VALUES (9, 3, 1, CAST(N'2024-11-19T17:00:00.000' AS DateTime), CAST(88.00 AS Decimal(5, 2)), 26)
GO
INSERT [dbo].[quiz_attempts] ([AttemptID], [UserID], [QuizID], [AttemptDate], [Score], [completion_time_minutes]) VALUES (10, 4, 2, CAST(N'2024-11-20T18:00:00.000' AS DateTime), CAST(90.00 AS Decimal(5, 2)), 21)
GO
SET IDENTITY_INSERT [dbo].[quiz_attempts] OFF
GO
SET IDENTITY_INSERT [dbo].[quizzes] ON
GO
INSERT [dbo].[quizzes] ([QuizID], [LessonID], [Title], [duration_minutes]) VALUES (1, 1, N'Quiz Java cơ bản', 30)
GO
INSERT [dbo].[quizzes] ([QuizID], [LessonID], [Title], [duration_minutes]) VALUES (2, 1, N'Quiz: Biến và Kiểu dữ liệu trong Java', 30)
GO
INSERT [dbo].[quizzes] ([QuizID], [LessonID], [Title], [duration_minutes]) VALUES (3, 2, N'Quiz: Giới thiệu về CSS', 30)
GO
INSERT [dbo].[quizzes] ([QuizID], [LessonID], [Title], [duration_minutes]) VALUES (4, 3, N'Quiz: Mệnh đề JOIN trong SQL Server', 30)
GO
SET IDENTITY_INSERT [dbo].[quizzes] OFF
GO
SET IDENTITY_INSERT [dbo].[roles] ON
GO
INSERT [dbo].[roles] ([RoleID], [RoleName]) VALUES (5, N'Admin')
GO
INSERT [dbo].[roles] ([RoleID], [RoleName]) VALUES (3, N'CourseManager')
GO
INSERT [dbo].[roles] ([RoleID], [RoleName]) VALUES (0, N'Guest')
GO
INSERT [dbo].[roles] ([RoleID], [RoleName]) VALUES (1, N'Student')
GO
INSERT [dbo].[roles] ([RoleID], [RoleName]) VALUES (2, N'Teacher')
GO
INSERT [dbo].[roles] ([RoleID], [RoleName]) VALUES (4, N'UserManager')
GO
SET IDENTITY_INSERT [dbo].[roles] OFF
GO
INSERT [dbo].[user_roles] ([UserID], [RoleID]) VALUES (1, 1)
GO
INSERT [dbo].[user_roles] ([UserID], [RoleID]) VALUES (2, 2)
GO
INSERT [dbo].[user_roles] ([UserID], [RoleID]) VALUES (3, 4)
GO
INSERT [dbo].[user_roles] ([UserID], [RoleID]) VALUES (4, 5)
GO
INSERT [dbo].[user_roles] ([UserID], [RoleID]) VALUES (5, 0)
GO
INSERT [dbo].[user_roles] ([UserID], [RoleID]) VALUES (6, 3)
GO
SET IDENTITY_INSERT [dbo].[users] ON
GO
INSERT [dbo].[users] ([UserID], [Username], [Email], [PasswordHash], [FirstName], [LastName], [AvatarURL], [PhoneNumber], [DateOfBirth], [LastLogin], [CreatedAt]) VALUES (1, N'student1', N'student1@example.com', N'hashedpass1', N'Alice', N'Nguyen', NULL, N'0901234567', CAST(N'2000-01-01' AS Date), NULL, CAST(N'2025-06-22T15:05:45.337' AS DateTime))
GO
INSERT [dbo].[users] ([UserID], [Username], [Email], [PasswordHash], [FirstName], [LastName], [AvatarURL], [PhoneNumber], [DateOfBirth], [LastLogin], [CreatedAt]) VALUES (2, N'teacher1', N'teacher1@example.com', N'hashedpass2', N'Bob', N'Tran', NULL, N'0902345678', CAST(N'1985-05-05' AS Date), NULL, CAST(N'2025-06-22T15:05:45.337' AS DateTime))
GO
INSERT [dbo].[users] ([UserID], [Username], [Email], [PasswordHash], [FirstName], [LastName], [AvatarURL], [PhoneNumber], [DateOfBirth], [LastLogin], [CreatedAt]) VALUES (3, N'manager1', N'manager1@example.com', N'hashedpass3', N'Charlie', N'Le', NULL, N'0903456789', CAST(N'1990-03-03' AS Date), NULL, CAST(N'2025-06-22T15:05:45.337' AS DateTime))
GO
INSERT [dbo].[users] ([UserID], [Username], [Email], [PasswordHash], [FirstName], [LastName], [AvatarURL], [PhoneNumber], [DateOfBirth], [LastLogin], [CreatedAt]) VALUES (4, N'admin1', N'admin1@example.com', N'hashedpass4', N'Diana', N'Pham', NULL, N'0904567890', CAST(N'1988-08-08' AS Date), NULL, CAST(N'2025-06-22T15:05:45.337' AS DateTime))
GO
INSERT [dbo].[users] ([UserID], [Username], [Email], [PasswordHash], [FirstName], [LastName], [AvatarURL], [PhoneNumber], [DateOfBirth], [LastLogin], [CreatedAt]) VALUES (5, N'guest1', N'guest1@example.com', N'hashedpass5', N'Emily', N'Vo', NULL, N'0905678901', CAST(N'1995-09-09' AS Date), NULL, CAST(N'2025-06-22T15:30:00.000' AS DateTime))
GO
INSERT [dbo].[users] ([UserID], [Username], [Email], [PasswordHash], [FirstName], [LastName], [AvatarURL], [PhoneNumber], [DateOfBirth], [LastLogin], [CreatedAt]) VALUES (6, N'coursemanager1', N'coursemanager1@example.com', N'hashedpass6', N'Frank', N'Bui', NULL, N'0906789012', CAST(N'1982-07-07' AS Date), NULL, CAST(N'2025-06-22T15:30:00.000' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[users] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__categori__737584F66EBBB2FA]    Script Date: 6/22/2025 4:09:53 PM ******/
ALTER TABLE [dbo].[categories] ADD UNIQUE NONCLUSTERED
    (
     [Name] ASC
        )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UK_Enrollments_Student_Course]    Script Date: 6/22/2025 4:09:53 PM ******/
ALTER TABLE [dbo].[enrollments] ADD  CONSTRAINT [UK_Enrollments_Student_Course] UNIQUE NONCLUSTERED
    (
     [student_id] ASC,
     [course_id] ASC
        )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Feedback_User_Course]    Script Date: 6/22/2025 4:09:53 PM ******/
ALTER TABLE [dbo].[feedback] ADD  CONSTRAINT [UQ_Feedback_User_Course] UNIQUE NONCLUSTERED
    (
     [UserID] ASC,
     [CourseID] ASC
        )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__roles__8A2B61604CD8D74A]    Script Date: 6/22/2025 4:09:53 PM ******/
ALTER TABLE [dbo].[roles] ADD UNIQUE NONCLUSTERED
    (
     [RoleName] ASC
        )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__users__536C85E437B17989]    Script Date: 6/22/2025 4:09:53 PM ******/
ALTER TABLE [dbo].[users] ADD UNIQUE NONCLUSTERED
    (
     [Username] ASC
        )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__users__A9D1053437FED6E3]    Script Date: 6/22/2025 4:09:53 PM ******/
ALTER TABLE [dbo].[users] ADD UNIQUE NONCLUSTERED
    (
     [Email] ASC
        )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[answers] ADD  DEFAULT ((0)) FOR [IsCorrect]
GO
ALTER TABLE [dbo].[cart] ADD  DEFAULT ('active') FOR [Status]
GO
ALTER TABLE [dbo].[cart] ADD  DEFAULT ((0)) FOR [TotalPrice]
GO
ALTER TABLE [dbo].[cart] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[categories] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[course_progress] ADD  DEFAULT ((0)) FOR [CompletedLessons]
GO
ALTER TABLE [dbo].[course_progress] ADD  DEFAULT ((0)) FOR [TotalLessons]
GO
ALTER TABLE [dbo].[course_progress] ADD  DEFAULT ((0)) FOR [ProgressPercent]
GO
ALTER TABLE [dbo].[course_progress] ADD  DEFAULT (getdate()) FOR [LastAccessed]
GO
ALTER TABLE [dbo].[courses] ADD  DEFAULT ((0)) FOR [Rating]
GO
ALTER TABLE [dbo].[courses] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[courses] ADD  DEFAULT ('draft') FOR [Status]
GO
ALTER TABLE [dbo].[enrollments] ADD  DEFAULT (getdate()) FOR [enrollment_date]
GO
ALTER TABLE [dbo].[enrollments] ADD  DEFAULT ((0)) FOR [progress_percentage]
GO
ALTER TABLE [dbo].[enrollments] ADD  DEFAULT ('ACTIVE') FOR [status]
GO
ALTER TABLE [dbo].[enrollments] ADD  DEFAULT ((0)) FOR [certificate_issued]
GO
ALTER TABLE [dbo].[feedback] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[lessons] ADD  DEFAULT ((0)) FOR [IsFreePreview]
GO
ALTER TABLE [dbo].[lessons] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[orders] ADD  DEFAULT ('pending') FOR [Status]
GO
ALTER TABLE [dbo].[orders] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[quiz_attempts] ADD  DEFAULT (getdate()) FOR [AttemptDate]
GO
ALTER TABLE [dbo].[quiz_attempts] ADD  DEFAULT ((0)) FOR [Score]
GO
ALTER TABLE [dbo].[user_avatars] ADD  DEFAULT ((0)) FOR [IsDefault]
GO
ALTER TABLE [dbo].[user_avatars] ADD  DEFAULT (getdate()) FOR [UploadedAt]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[answers]  WITH CHECK ADD FOREIGN KEY([QuestionID])
    REFERENCES [dbo].[questions] ([QuestionID])
    ON DELETE CASCADE
GO
ALTER TABLE [dbo].[cart]  WITH CHECK ADD FOREIGN KEY([UserID])
    REFERENCES [dbo].[users] ([UserID])
GO
ALTER TABLE [dbo].[cartitem]  WITH CHECK ADD FOREIGN KEY([CartID])
    REFERENCES [dbo].[cart] ([CartID])
    ON DELETE CASCADE
GO
ALTER TABLE [dbo].[cartitem]  WITH CHECK ADD FOREIGN KEY([CourseID])
    REFERENCES [dbo].[courses] ([CourseID])
GO
ALTER TABLE [dbo].[course_progress]  WITH CHECK ADD FOREIGN KEY([CourseID])
    REFERENCES [dbo].[courses] ([CourseID])
    ON DELETE CASCADE
GO
ALTER TABLE [dbo].[course_progress]  WITH CHECK ADD FOREIGN KEY([UserID])
    REFERENCES [dbo].[users] ([UserID])
    ON DELETE CASCADE
GO
ALTER TABLE [dbo].[courses]  WITH CHECK ADD FOREIGN KEY([InstructorID])
    REFERENCES [dbo].[users] ([UserID])
GO
ALTER TABLE [dbo].[courses]  WITH CHECK ADD  CONSTRAINT [FK_Courses_Categories] FOREIGN KEY([CategoryID])
    REFERENCES [dbo].[categories] ([CategoryID])
GO
ALTER TABLE [dbo].[courses] CHECK CONSTRAINT [FK_Courses_Categories]
GO
ALTER TABLE [dbo].[enrollments]  WITH CHECK ADD  CONSTRAINT [FK_Enrollments_Courses] FOREIGN KEY([course_id])
    REFERENCES [dbo].[courses] ([CourseID])
GO
ALTER TABLE [dbo].[enrollments] CHECK CONSTRAINT [FK_Enrollments_Courses]
GO
ALTER TABLE [dbo].[enrollments]  WITH CHECK ADD  CONSTRAINT [FK_Enrollments_Students] FOREIGN KEY([student_id])
    REFERENCES [dbo].[users] ([UserID])
GO
ALTER TABLE [dbo].[enrollments] CHECK CONSTRAINT [FK_Enrollments_Students]
GO
ALTER TABLE [dbo].[feedback]  WITH CHECK ADD FOREIGN KEY([CourseID])
    REFERENCES [dbo].[courses] ([CourseID])
GO
ALTER TABLE [dbo].[feedback]  WITH CHECK ADD FOREIGN KEY([UserID])
    REFERENCES [dbo].[users] ([UserID])
GO
ALTER TABLE [dbo].[lessons]  WITH CHECK ADD FOREIGN KEY([CourseID])
    REFERENCES [dbo].[courses] ([CourseID])
    ON DELETE CASCADE
GO
ALTER TABLE [dbo].[materials]  WITH CHECK ADD FOREIGN KEY([LessonID])
    REFERENCES [dbo].[lessons] ([LessonID])
    ON DELETE CASCADE
GO
ALTER TABLE [dbo].[orderdetails]  WITH CHECK ADD FOREIGN KEY([CourseID])
    REFERENCES [dbo].[courses] ([CourseID])
GO
ALTER TABLE [dbo].[orderdetails]  WITH CHECK ADD FOREIGN KEY([OrderID])
    REFERENCES [dbo].[orders] ([OrderID])
    ON DELETE CASCADE
GO
ALTER TABLE [dbo].[orders]  WITH CHECK ADD FOREIGN KEY([UserID])
    REFERENCES [dbo].[users] ([UserID])
GO
ALTER TABLE [dbo].[question_attempts]  WITH CHECK ADD FOREIGN KEY([AttemptID])
    REFERENCES [dbo].[quiz_attempts] ([AttemptID])
    ON DELETE CASCADE
GO
ALTER TABLE [dbo].[question_attempts]  WITH CHECK ADD FOREIGN KEY([QuestionID])
    REFERENCES [dbo].[questions] ([QuestionID])
GO
ALTER TABLE [dbo].[question_attempts]  WITH CHECK ADD FOREIGN KEY([OptionID])
    REFERENCES [dbo].[answers] ([AnswerID])
GO
ALTER TABLE [dbo].[questions]  WITH CHECK ADD FOREIGN KEY([QuizID])
    REFERENCES [dbo].[quizzes] ([QuizID])
    ON DELETE CASCADE
GO
ALTER TABLE [dbo].[quiz_attempts]  WITH CHECK ADD FOREIGN KEY([QuizID])
    REFERENCES [dbo].[quizzes] ([QuizID])
    ON DELETE CASCADE
GO
ALTER TABLE [dbo].[quiz_attempts]  WITH CHECK ADD FOREIGN KEY([UserID])
    REFERENCES [dbo].[users] ([UserID])
    ON DELETE CASCADE
GO
ALTER TABLE [dbo].[quizzes]  WITH CHECK ADD FOREIGN KEY([LessonID])
    REFERENCES [dbo].[lessons] ([LessonID])
    ON DELETE CASCADE
GO
ALTER TABLE [dbo].[user_avatars]  WITH CHECK ADD FOREIGN KEY([UserID])
    REFERENCES [dbo].[users] ([UserID])
    ON DELETE CASCADE
GO
ALTER TABLE [dbo].[user_roles]  WITH CHECK ADD FOREIGN KEY([RoleID])
    REFERENCES [dbo].[roles] ([RoleID])
    ON DELETE CASCADE
GO
ALTER TABLE [dbo].[user_roles]  WITH CHECK ADD FOREIGN KEY([UserID])
    REFERENCES [dbo].[users] ([UserID])
    ON DELETE CASCADE
GO
ALTER TABLE [dbo].[cart]  WITH CHECK ADD CHECK  (([Status]='completed' OR [Status]='active'))
GO
ALTER TABLE [dbo].[courses]  WITH CHECK ADD CHECK  (([Status]='draft' OR [Status]='inactive' OR [Status]='active'))
GO
ALTER TABLE [dbo].[enrollments]  WITH CHECK ADD  CONSTRAINT [CK_Enrollments_Grade] CHECK  (([grade] IS NULL OR [grade]>=(0) AND [grade]<=(10)))
GO
ALTER TABLE [dbo].[enrollments] CHECK CONSTRAINT [CK_Enrollments_Grade]
GO
ALTER TABLE [dbo].[enrollments]  WITH CHECK ADD  CONSTRAINT [CK_Enrollments_Progress] CHECK  (([progress_percentage]>=(0) AND [progress_percentage]<=(100)))
GO
ALTER TABLE [dbo].[enrollments] CHECK CONSTRAINT [CK_Enrollments_Progress]
GO
ALTER TABLE [dbo].[enrollments]  WITH CHECK ADD  CONSTRAINT [CK_Enrollments_Status] CHECK  (([status]='SUSPENDED' OR [status]='DROPPED' OR [status]='COMPLETED' OR [status]='ACTIVE'))
GO
ALTER TABLE [dbo].[enrollments] CHECK CONSTRAINT [CK_Enrollments_Status]
GO
ALTER TABLE [dbo].[feedback]  WITH CHECK ADD CHECK  (([Rating]>=(1) AND [Rating]<=(5)))
GO
ALTER TABLE [dbo].[orders]  WITH CHECK ADD CHECK  (([Status]='cancelled' OR [Status]='paid' OR [Status]='pending'))
GO
USE [master]
GO
ALTER DATABASE [CourseManagementSystem] SET  READ_WRITE
GO
