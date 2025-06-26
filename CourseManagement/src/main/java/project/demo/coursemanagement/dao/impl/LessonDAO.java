package project.demo.coursemanagement.dao.impl;


import project.demo.coursemanagement.entities.Cours;
import project.demo.coursemanagement.entities.Lesson;
import project.demo.coursemanagement.entities.QuestionOption;
import project.demo.coursemanagement.entities.QuizHistory;
import project.demo.coursemanagement.utils.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class LessonDAO {

    //lay lesson detail theo lesson id
    public Lesson getLessonById(int lessonId) {
        Lesson lesson = null;
        String sql = "SELECT * FROM lessons WHERE LessonID = ?";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, lessonId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {

                    Lesson.builder()
                            .id(rs.getInt("LessonID"))
                            .courseID(Cours.builder().id(rs.getInt("CourseID")).build())
                            .title(rs.getString("Title"))
                            .content(rs.getString("Content"))
                            .status(rs.getString("Status"))
                            .isFreePreview(rs.getBoolean("IsFreePreview"))
                            .createdAt(rs.getTimestamp("CreatedAt").toInstant())
                            .build();
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // hoặc log ra logger
        }

        return lesson;
    }

    //lay lesson theo courseId
    public List<Lesson> getLessonsByCourseId(int courseId) {
        List<Lesson> lessons = new ArrayList<>();
        String sql = "SELECT * FROM lessons WHERE CourseID = ?";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, courseId);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                lessons.add(Lesson.builder()
                        .id(rs.getInt("LessonID"))
                        .courseID(Cours.builder().id(rs.getInt("CourseID")).build())
                        .title(rs.getString("Title"))
                        .content(rs.getString("Content"))
                        .status(rs.getString("Status"))
                        .isFreePreview(rs.getBoolean("IsFreePreview"))
                        .createdAt(rs.getTimestamp("CreatedAt").toInstant())
                        .build()
                );
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Xử lý ngoại lệ thích hợp, có thể ghi log
        }
        return lessons;
    }


    //lay lesson theo teacherId de manageLesson
    public List<Lesson> getLessonsByTeacherId(int InstructorID) {
        String query = "SELECT l.LessonID, l.CourseID, l.Title, l.Content, l.Status, l.IsFreePreview, l.CreatedAt "
                + "FROM lessons l "
                + "JOIN courses c ON l.CourseID = c.CourseID "
                + "WHERE c.InstructorID = ?";

        List<Lesson> lessons = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, InstructorID);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    lessons.add(Lesson.builder()
                            .id(rs.getInt("LessonID"))
                            .courseID(Cours.builder().id(rs.getInt("CourseID")).build())
                            .title(rs.getString("Title"))
                            .content(rs.getString("Content"))
                            .status(rs.getString("Status"))
                            .isFreePreview(rs.getBoolean("IsFreePreview"))
                            .createdAt(rs.getTimestamp("CreatedAt").toInstant())
                            .build()
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return lessons;
    }

    //
//    public List<Lesson> getLessonsCompletedByCourseId(int courseId) {
//        List<Lesson> lessons = new ArrayList<>();
//        String sql = "SELECT LessonID, CourseID, Title, Content, VideoURL, CreatedAt FROM Lesson WHERE CourseID = ?";
//        try {
//            PreparedStatement pstmt = connection.prepareStatement(sql);
//            pstmt.setInt(1, courseId);
//            ResultSet rs = pstmt.executeQuery();
//
//            while (rs.next()) {
//                Lesson lesson = new Lesson();
//                lesson.setLessonId(rs.getInt("LessonID"));
//                lesson.setCourseId(rs.getInt("CourseID"));
//                lesson.setTitle(rs.getString("Title"));
//                lesson.setContent(rs.getString("Content"));
//                lesson.setVidURL(rs.getString("VideoURL"));
//                lesson.setCreatedAt(rs.getDate("CreatedAt"));
//                lessons.add(lesson);
//            }
//        } catch (SQLException e) {
//            e.printStackTrace(); // Xử lý ngoại lệ thích hợp, có thể ghi log
//        }
//        return lessons;
//    }
//
    public Lesson getLessonDetails(int lessonId, int courseId) {
        Lesson lesson = null;
        String sql = "SELECT * FROM lessons WHERE LessonID = ? AND CourseID = ?";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, lessonId);
            pstmt.setInt(2, courseId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                lesson = Lesson.builder()
                        .id(rs.getInt("LessonID"))
                        .courseID(Cours.builder().id(rs.getInt("CourseID")).build())
                        .title(rs.getString("Title"))
                        .content(rs.getString("Content"))
                        .status(rs.getString("Status"))
                        .isFreePreview(rs.getBoolean("IsFreePreview"))
                        .createdAt(rs.getTimestamp("CreatedAt").toInstant())
                        .build();
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return lesson;
    }

    public boolean isUserEnrolled(int userId, int courseId) {
        String sql = "SELECT 1 FROM enrollments WHERE student_id = ? AND course_id = ?";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, courseId);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    //
//    public List<Lesson> getAllLessons() {
//        List<Lesson> lessons = new ArrayList<>();
//        String sql = "SELECT * FROM Lesson";
//        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
//            while (rs.next()) {
//                lessons.add(new Lesson(
//                        rs.getInt("LessonID"),
//                        rs.getInt("CourseID"),
//                        rs.getString("Title"),
//                        rs.getString("Content"),
//                        rs.getString("VideoURL"),
//                        rs.getTimestamp("CreatedAt")
//                ));
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return lessons;
//    }
//
//    // Thêm lesson
//    public boolean addLesson(Lesson lesson) {
//        String sql = "INSERT INTO [dbo].[Lesson] ([CourseID], [Title], [Content], [VideoURL], [CreatedAt]) VALUES (?, ?, ?, ?, ?)";
//        try (PreparedStatement ps = connection.prepareStatement(sql)) {
//            ps.setInt(1, lesson.getCourseId());
//            ps.setString(2, lesson.getTitle());
//            ps.setString(3, lesson.getContent());
//            ps.setString(4, lesson.getVidURL());
//            ps.setDate(5, new java.sql.Date(lesson.getCreatedAt().getTime()));
//
//            int rows = ps.executeUpdate();
//            return rows > 0;
//        } catch (SQLException e) {
//            e.printStackTrace();
//            return false;
//        }
//    }
//
    // Cập nhật lesson
    public void updateLesson(Lesson lesson) {
        String sql = "UPDATE lessons SET Title = ?, Content = ?, Status = ?, IsFreePreview = ? WHERE LessonID = ?";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, lesson.getTitle());
            ps.setString(2, lesson.getContent());
            ps.setString(3, lesson.getStatus());
            ps.setBoolean(4, lesson.getIsFreePreview());
            ps.setInt(4, lesson.getId());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
//
//    // Xóa lesson
//    public void deleteLesson(int lessonId) throws SQLException {
//        String sql = "DELETE FROM Lesson WHERE lessonId = ?";
//        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
//            stmt.setInt(1, lessonId);
//            stmt.executeUpdate();
//        }
//    }
//
//    // Thêm method để lưu thông tin hoàn thành lesson vào bảng Lesson_Completion
//    public void saveLessonCompletion(int userId, int lessonId) {
//        String sql = "INSERT INTO Lesson_Completion (userId, lessonId, completedAt) VALUES (?, ?, ?)";
//        try (Connection conn = DatabaseConnection.getInstance().getConnection();
//             PreparedStatement ps = conn.prepareStatement(sql)) {
//            ps.setInt(1, userId);
//            ps.setInt(2, lessonId);
//            ps.setDate(3, new java.sql.Date(new Date().getTime()));
//            ps.executeUpdate();
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//    }
//
//    // Thêm method để kiểm tra xem lesson đã hoàn thành hay chưa
//    public boolean isLessonCompleted(int userId, int lessonId) throws SQLException {
//        String sql = "SELECT COUNT(*) FROM Lesson_Completion WHERE userId = ? AND lessonId = ?";
//        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
//            stmt.setInt(1, userId);
//            stmt.setInt(2, lessonId);
//            try (ResultSet rs = stmt.executeQuery()) {
//                if (rs.next()) {
//                    return rs.getInt(1) > 0;
//                }
//                return false;
//            }
//        }
//    }
//
//    //lấy danh sách các khóa học trong bảng lesson_completed
//    public List<Lesson_Completion> getListLessonCompleted(int courseId) {
//        List<Lesson_Completion> lessons = new ArrayList<>();
//        String sql = "SELECT LC.*\n"
//                + "FROM Lesson_Completion LC\n"
//                + "JOIN Lesson L ON LC.LessonID = L.LessonID\n"
//                + "WHERE L.CourseID = ?";
//        try (Connection conn = DatabaseConnection.getInstance().getConnection();
//             PreparedStatement stmt = conn.prepareStatement(sql)) {
//            stmt.setInt(1, courseId);
//            ResultSet rs = stmt.executeQuery();
//            while (rs.next()) {
//                Lesson_Completion lesson = new Lesson_Completion(
//                        rs.getInt("CompletionID"),
//                        rs.getInt("UserID"),
//                        rs.getInt("LessonID"),
//                        rs.getDate("CompletedAt")
//                );
//                lessons.add(lesson);
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return lessons;
//    }

    public List<QuizHistory> getQuizHistoryByCourseAndUser(int courseId, int userId) {
        List<QuizHistory> historyList = new ArrayList<>();
        String sql = "SELECT \n"
                + "    qa.AttemptID,\n"
                + "    qa.UserID,\n"
                + "    qa.QuizID,\n"
                + "    q.Title AS QuizTitle,\n"
                + "    l.LessonID,\n"
                + "    l.Title AS LessonTitle,\n"
                + "    qa.AttemptDate,\n"
                + "    qa.Score,\n"
                + "    qa.completion_time_minutes\n"
                + "FROM quiz_attempts qa\n"
                + "JOIN quizzes q ON qa.QuizID = q.QuizID\n"
                + "JOIN lessons l ON q.LessonID = l.LessonID\n"
                + "WHERE l.CourseID = ? AND qa.UserID = ?";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, courseId);
            stmt.setInt(2, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                historyList.add(QuizHistory.builder().attemptId(rs.getInt("AttemptID"))
                        .userId(rs.getInt("UserID"))
                        .quizId(rs.getInt("QuizID"))
                        .quizTitle(rs.getString("QuizTitle"))
                        .lessonId(rs.getInt("LessonID"))
                        .lessonTitle(rs.getString("LessonTitle"))
                        .attemptDate(rs.getString("AttemptDate"))
                        .score(rs.getInt("Score"))
                        .completionTimeMinutes(rs.getInt("completion_time_minutes"))
                        .build()
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return historyList;
    }

    public List<QuestionOption> getQuestionOptions(int attemptID) {
        List<QuestionOption> questionOptions = new ArrayList<>();
        String sql = "SELECT q.QuestionID, q.QuestionText AS QuestionText, ao.AnswerID, ao.AnswerText AS OptionText, ao.IsCorrect, ua.OptionID AS UserSelectedOptionID "
                + "FROM quiz_attempts qa "
                + "JOIN question_attempts ua ON qa.AttemptID = ua.AttemptID "
                + "JOIN questions q ON ua.QuestionID = q.QuestionID "
                + "JOIN answers ao ON ao.QuestionID = q.QuestionID "
                + "LEFT JOIN question_attempts selected ON selected.AttemptID = qa.AttemptID "
                + "AND selected.QuestionID = q.QuestionID "
                + "AND selected.OptionID = ao.AnswerID "
                + "WHERE qa.AttemptID = ? "
                + "ORDER BY q.QuestionID, ao.AnswerID";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, attemptID);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                int questionID = rs.getInt("QuestionID");
                String questionText = rs.getString("QuestionText");
                int optionID = rs.getInt("AnswerID");
                String optionText = rs.getString("OptionText");
                boolean isCorrect = rs.getBoolean("IsCorrect");
                Integer userSelectedOptionID = (Integer) rs.getObject("UserSelectedOptionID");

                QuestionOption questionOption = new QuestionOption(questionID, questionText, optionID, optionText, isCorrect, userSelectedOptionID);
                questionOptions.add(questionOption);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return questionOptions;
    }
//
//    public static void main(String[] args) {
////        LessonDAO lessonDAO = new LessonDAO();
////        int courseId = 12; // Thay thế bằng courseId thực tế bạn muốn truy vấn
////        List<String> lessonTitles = lessonDAO.getLessonTitlesByCourseId(courseId);
////
////        if (lessonTitles.isEmpty()) {
////            System.out.println("Không tìm thấy bài học nào cho Course ID: " + courseId);
////        } else {
////            System.out.println("Danh sách tiêu đề bài học cho Course ID: " + courseId);
////            for (String title : lessonTitles) {
////                System.out.println("- " + title);
////            }
////        }
//        LessonDAO lessonDAO = new LessonDAO();
////        int lessonId = 2; // Thay thế bằng lessonId thực tế bạn muốn truy vấn
////        int courseId = 12; // Thay thế bằng courseId thực tế bạn muốn truy vấn
////
////        Lesson lesson = lessonDAO.getLessonDetails(lessonId, courseId);
////
////        if (lesson == null) {
////            System.out.println("Không tìm thấy bài học nào với Lesson ID: " + lessonId + " và Course ID: " + courseId);
////        } else {
////            System.out.println("Thông tin chi tiết bài học:");
////            System.out.println("Title: " + lesson.getTitle());
////            System.out.println("Content: " + lesson.getContent());
////            System.out.println("Video URL: " + lesson.getVidURL());
////            System.out.println("Created At: " + lesson.getCreatedAt());
////        }
//        Lesson newLesson = lessonDAO.getLessonById(2);
//        System.out.println(newLesson);
////        List<QuestionOption> lessons = lessonDAO.getQuestionOptions(2);
////        for (QuestionOption lessonComple : lessons) {
////            System.out.println(lessonComple);
////        }
//
//    }
}
