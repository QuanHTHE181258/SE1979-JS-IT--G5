package project.demo.coursemanagement.dao.impl;

import project.demo.coursemanagement.dao.LessonDAO;
import project.demo.coursemanagement.entities.Lesson;
import project.demo.coursemanagement.dto.LessonStats;

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
    public Lesson getLessonById(int lessonId) {
        String sql = "SELECT LessonID, CourseID, Title, Content, Status, IsFreePreview, CreatedAt FROM lessons WHERE LessonID = ?";
        try (Connection conn = project.demo.coursemanagement.utils.DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, lessonId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Lesson lesson = new Lesson();
                    lesson.setId(rs.getInt("LessonID"));
                    // Set courseID as Cours entity
                    project.demo.coursemanagement.entities.Cours course = new project.demo.coursemanagement.entities.Cours();
                    course.setId(rs.getInt("CourseID"));
                    lesson.setCourseID(course);
                    lesson.setTitle(rs.getString("Title"));
                    lesson.setContent(rs.getString("Content"));
                    lesson.setStatus(rs.getString("Status"));
                    lesson.setIsFreePreview(rs.getBoolean("IsFreePreview"));
                    lesson.setCreatedAt(rs.getTimestamp("CreatedAt").toInstant());
                    return lesson;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Lesson> getLessonsByCourseId(int courseId) {
        List<Lesson> list = new ArrayList<>();
        String sql = "SELECT LessonID, CourseID, Title, Content, Status, IsFreePreview, CreatedAt FROM lessons WHERE CourseID = ? ORDER BY LessonID";
        try (Connection conn = project.demo.coursemanagement.utils.DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, courseId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Lesson lesson = new Lesson();
                    lesson.setId(rs.getInt("LessonID"));
                    // Set courseID as Cours entity
                    project.demo.coursemanagement.entities.Cours course = new project.demo.coursemanagement.entities.Cours();
                    course.setId(rs.getInt("CourseID"));
                    lesson.setCourseID(course);
                    lesson.setTitle(rs.getString("Title"));
                    lesson.setContent(rs.getString("Content"));
                    lesson.setStatus(rs.getString("Status"));
                    lesson.setIsFreePreview(rs.getBoolean("IsFreePreview"));
                    lesson.setCreatedAt(rs.getTimestamp("CreatedAt").toInstant());
                    list.add(lesson);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean addLesson(Lesson lesson) {
        String sql = "INSERT INTO lessons (Title, Content, Status, IsFreePreview, CreatedAt, CourseID) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = project.demo.coursemanagement.utils.DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, lesson.getTitle());
            stmt.setString(2, lesson.getContent());
            stmt.setString(3, lesson.getStatus());
            stmt.setBoolean(4, lesson.getIsFreePreview());
            stmt.setTimestamp(5, Timestamp.from(lesson.getCreatedAt()));
            stmt.setInt(6, lesson.getCourseID().getId());
            int affected = stmt.executeUpdate();
            return affected > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
