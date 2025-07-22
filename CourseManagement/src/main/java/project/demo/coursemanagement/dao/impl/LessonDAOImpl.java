package project.demo.coursemanagement.dao.impl;

import project.demo.coursemanagement.dao.LessonDAO;
import project.demo.coursemanagement.entities.Lesson;
import project.demo.coursemanagement.dto.LessonStats;
import project.demo.coursemanagement.entities.Quiz;
import project.demo.coursemanagement.entities.Material;
import java.sql.*;
import java.util.*;

public class LessonDAOImpl implements LessonDAO {
    @Override
    public List<LessonStats> getLessonsWithStatsByCourseId(int courseId) {
        List<LessonStats> list = new ArrayList<>();
        String sql = "SELECT l.LessonID, l.Title, l.Content, l.Status, l.IsFreePreview, l.CreatedAt, " +
                "(SELECT COUNT(*) FROM quizzes q WHERE q.LessonID = l.LessonID) as totalQuizzes, " +
                "(SELECT COUNT(*) FROM materials m WHERE m.LessonID = l.LessonID) as totalMaterials " +
                "FROM lessons l WHERE l.CourseID = ? ORDER BY l.LessonID";
        try (Connection conn = project.demo.coursemanagement.utils.DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, courseId);
            try (ResultSet rs = stmt.executeQuery()) {
                int order = 1;
                while (rs.next()) {
                    Lesson lesson = new Lesson();
                    lesson.setId(rs.getInt("LessonID"));
                    lesson.setTitle(rs.getString("Title"));
                    lesson.setContent(rs.getString("Content"));
                    lesson.setStatus(rs.getString("Status"));
                    lesson.setIsFreePreview(rs.getBoolean("IsFreePreview"));
                    lesson.setCreatedAt(rs.getTimestamp("CreatedAt").toInstant());
                    int totalQuizzes = rs.getInt("totalQuizzes");
                    int totalMaterials = rs.getInt("totalMaterials");
                    list.add(new LessonStats(lesson, order++, totalQuizzes, totalMaterials));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public List<LessonStats> getLessonSummaryByCourseId(int courseId) {
        List<LessonStats> list = new ArrayList<>();
        String sql = "SELECT l.LessonID, l.Title, " +
                    "COUNT(DISTINCT q.QuizID) as QuizCount, " +
                    "COUNT(DISTINCT m.MaterialID) as MaterialCount " +
                    "FROM [CourseManagementSystem].[dbo].[lessons] l " +
                    "LEFT JOIN [CourseManagementSystem].[dbo].[quizzes] q ON q.LessonID = l.LessonID " +
                    "LEFT JOIN [CourseManagementSystem].[dbo].[materials] m ON m.LessonID = l.LessonID " +
                    "WHERE l.CourseID = ? " +
                    "GROUP BY l.LessonID, l.Title " +
                    "ORDER BY l.LessonID";

        try (Connection conn = project.demo.coursemanagement.utils.DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, courseId);
            System.out.println("Executing query with courseId: " + courseId);

            try (ResultSet rs = stmt.executeQuery()) {
                int orderNumber = 1;
                while (rs.next()) {
                    Lesson lesson = new Lesson();
                    lesson.setId(rs.getInt("LessonID"));
                    lesson.setTitle(rs.getString("Title"));

                    int quizCount = rs.getInt("QuizCount");
                    int materialCount = rs.getInt("MaterialCount");

                    LessonStats stats = new LessonStats(lesson, orderNumber++, quizCount, materialCount);
                    list.add(stats);

                    System.out.println("Found lesson: " + lesson.getTitle() +
                                     " with " + quizCount + " quizzes and " +
                                     materialCount + " materials");
                }
            }

        } catch (SQLException e) {
            System.err.println("SQL Error: " + e.getMessage());
            System.err.println("SQL State: " + e.getSQLState());
            System.err.println("Error Code: " + e.getErrorCode());
            e.printStackTrace();
        }

        return list;
    }

    @Override
    public Lesson getLessonById(int lessonId) {
        String sql = "SELECT LessonID, Title, Content, Status, IsFreePreview, CreatedAt, CourseID FROM lessons WHERE LessonID = ?";
        try (Connection conn = project.demo.coursemanagement.utils.DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, lessonId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Lesson lesson = new Lesson();
                    lesson.setId(rs.getInt("LessonID"));
                    lesson.setTitle(rs.getString("Title"));
                    lesson.setContent(rs.getString("Content"));
                    lesson.setStatus(rs.getString("Status"));
                    lesson.setIsFreePreview(rs.getBoolean("IsFreePreview"));
                    lesson.setCreatedAt(rs.getTimestamp("CreatedAt").toInstant());
                    
                    // Set courseID
                    project.demo.coursemanagement.entities.Cours course = new project.demo.coursemanagement.entities.Cours();
                    course.setId(rs.getInt("CourseID"));
                    lesson.setCourseID(course);
                    return lesson;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Quiz> getQuizzesByLessonId(int lessonId) {
        List<Quiz> quizzes = new ArrayList<>();
        String sql = "SELECT QuizID, LessonID, Title FROM quizzes WHERE LessonID = ?";
        try (Connection conn = project.demo.coursemanagement.utils.DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, lessonId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Quiz quiz = new Quiz();
                    quiz.setId(rs.getInt("QuizID"));
                    quiz.setLessonId(rs.getInt("LessonID"));
                    quiz.setTitle(rs.getString("Title"));
                    quizzes.add(quiz);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return quizzes;
    }

    @Override
    public List<Material> getMaterialsByLessonId(int lessonId) {
        List<Material> materials = new ArrayList<>();
        String sql = "SELECT MaterialID, LessonID, Title, FileURL FROM materials WHERE LessonID = ?";
        try (Connection conn = project.demo.coursemanagement.utils.DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, lessonId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Material material = new Material();
                    material.setId(rs.getInt("MaterialID"));
                    material.setLessonId(rs.getInt("LessonID"));
                    material.setTitle(rs.getString("Title"));
                    material.setFileURL(rs.getString("FileURL"));
                    materials.add(material);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return materials;
    }

    @Override
    public List<Lesson> getLessonsByCourseId(int courseId) {
        List<Lesson> lessons = new ArrayList<>();
        String sql = "SELECT LessonID, Title, Content, Status, IsFreePreview, CreatedAt, CourseID FROM lessons WHERE CourseID = ? ORDER BY LessonID";
        try (Connection conn = project.demo.coursemanagement.utils.DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, courseId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Lesson lesson = new Lesson();
                    lesson.setId(rs.getInt("LessonID"));
                    lesson.setTitle(rs.getString("Title"));
                    lesson.setContent(rs.getString("Content"));
                    lesson.setStatus(rs.getString("Status"));
                    lesson.setIsFreePreview(rs.getBoolean("IsFreePreview"));
                    lesson.setCreatedAt(rs.getTimestamp("CreatedAt").toInstant());
                    
                    // Set courseID
                    project.demo.coursemanagement.entities.Cours course = new project.demo.coursemanagement.entities.Cours();
                    course.setId(rs.getInt("CourseID"));
                    lesson.setCourseID(course);
                    
                    lessons.add(lesson);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lessons;
    }

    @Override
    public boolean updateLesson(Lesson lesson) {
        String sql = "UPDATE lessons SET Title = ?, Content = ?, Status = ?, IsFreePreview = ?, CourseID = ? WHERE LessonID = ?";
        try (Connection conn = project.demo.coursemanagement.utils.DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, lesson.getTitle());
            stmt.setString(2, lesson.getContent());
            stmt.setString(3, lesson.getStatus());
            stmt.setBoolean(4, lesson.getIsFreePreview());
            stmt.setInt(5, lesson.getCourseId());
            stmt.setInt(6, lesson.getId());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Additional method from HEAD branch
    public boolean addLesson(Lesson lesson) {
        String sql = "INSERT INTO lessons (Title, Content, Status, IsFreePreview, CreatedAt, CourseID) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = project.demo.coursemanagement.utils.DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, lesson.getTitle());
            stmt.setString(2, lesson.getContent());
            stmt.setString(3, lesson.getStatus());
            stmt.setBoolean(4, lesson.getIsFreePreview());
            stmt.setTimestamp(5, Timestamp.from(lesson.getCreatedAt()));
            stmt.setInt(6, lesson.getCourseId());
            int affected = stmt.executeUpdate();
            return affected > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}