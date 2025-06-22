package project.demo.coursemanagement.dao.impl;

import project.demo.coursemanagement.dao.CourseDAO;
import project.demo.coursemanagement.dto.CourseStatsDTO;
import project.demo.coursemanagement.utils.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CourseDAOImpl implements CourseDAO {

    @Override
    public List<CourseStatsDTO> getAllCoursesWithStats() {
        List<CourseStatsDTO> courses = new ArrayList<>();

        String sql = """
        SELECT c.CourseID, c.Title, c.Description, c.Price, c.Rating, c.CreatedAt, c.ImageURL,
            cat.CategoryID, cat.Name as CategoryName,
            (SELECT COUNT(*) FROM feedback f WHERE f.CourseID = c.CourseID) AS FeedbackCount,
            (SELECT COUNT(*) FROM materials m
                JOIN lessons l ON m.LessonID = l.LessonID
                WHERE l.CourseID = c.CourseID) AS MaterialCount,
            (SELECT COUNT(*) FROM quizzes q
                JOIN lessons l ON q.LessonID = l.LessonID
                WHERE l.CourseID = c.CourseID) AS QuizCount,
            (SELECT COUNT(*) FROM enrollments e WHERE e.course_id = c.CourseID) AS EnrollmentCount
        FROM Courses c
        LEFT JOIN categories cat ON c.CategoryID = cat.CategoryID
        ORDER BY c.CreatedAt DESC
    """;

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                CourseStatsDTO course = new CourseStatsDTO(
                        (long) rs.getInt("CourseID"),
                        rs.getString("Title"),
                        rs.getString("Description"),
                        rs.getBigDecimal("Price"),
                        rs.getDouble("Rating"),
                        rs.getTimestamp("CreatedAt").toInstant(),
                        rs.getString("ImageURL"),
                        rs.getLong("FeedbackCount"),
                        rs.getLong("MaterialCount"),
                        rs.getLong("QuizCount"),
                        rs.getLong("EnrollmentCount"),
                        rs.getLong("CategoryID"),
                        rs.getString("CategoryName")
                );
                courses.add(course);
            }

        } catch (SQLException e) {
            System.err.println("Error in getAllCoursesWithStats: " + e.getMessage());
            e.printStackTrace();
        }

        return courses;
    }

    @Override
    public List<CourseStatsDTO> getCoursesByCategory(Long categoryId) {
        List<CourseStatsDTO> courses = new ArrayList<>();

        String sql = """
        SELECT c.CourseID, c.Title, c.Description, c.Price, c.Rating, c.CreatedAt, c.ImageURL,
            cat.CategoryID, cat.Name as CategoryName,
            (SELECT COUNT(*) FROM feedback f WHERE f.CourseID = c.CourseID) AS FeedbackCount,
            (SELECT COUNT(*) FROM materials m
                JOIN lessons l ON m.LessonID = l.LessonID
                WHERE l.CourseID = c.CourseID) AS MaterialCount,
            (SELECT COUNT(*) FROM quizzes q
                JOIN lessons l ON q.LessonID = l.LessonID
                WHERE l.CourseID = c.CourseID) AS QuizCount,
            (SELECT COUNT(*) FROM enrollments e WHERE e.course_id = c.CourseID) AS EnrollmentCount
        FROM Courses c
        LEFT JOIN categories cat ON c.CategoryID = cat.CategoryID
        WHERE c.CategoryID = ?
        ORDER BY c.CreatedAt DESC
        """;

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setLong(1, categoryId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    CourseStatsDTO course = new CourseStatsDTO(
                            (long) rs.getInt("CourseID"),
                            rs.getString("Title"),
                            rs.getString("Description"),
                            rs.getBigDecimal("Price"),
                            rs.getDouble("Rating"),
                            rs.getTimestamp("CreatedAt").toInstant(),
                            rs.getString("ImageURL"),
                            rs.getLong("FeedbackCount"),
                            rs.getLong("MaterialCount"),
                            rs.getLong("QuizCount"),
                            rs.getLong("EnrollmentCount"),
                            rs.getLong("CategoryID"),
                            rs.getString("CategoryName")
                    );
                    courses.add(course);
                }
            }

        } catch (SQLException e) {
            System.err.println("Error in getCoursesByCategory: " + e.getMessage());
            e.printStackTrace();
        }

        return courses;
    }
}