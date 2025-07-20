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
}
