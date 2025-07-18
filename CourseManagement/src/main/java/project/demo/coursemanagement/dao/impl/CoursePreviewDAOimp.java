package project.demo.coursemanagement.dao.impl;

import project.demo.coursemanagement.dao.CoursePreviewDAO;
import project.demo.coursemanagement.dto.CourseDTO;
import project.demo.coursemanagement.dto.FeedbackDTO;
import project.demo.coursemanagement.dto.LessonDTO;
import project.demo.coursemanagement.utils.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;


public class CoursePreviewDAOimp implements CoursePreviewDAO {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    DatabaseConnection dbConn = DatabaseConnection.getInstance();

    @Override
    public CourseDTO getCourseInfoById(int id) {
        CourseDTO courseDTO = null;
        String sql = """
                            SELECT c.CourseID, c.Title, c.Description, c.Price, c.Rating, c.CreatedAt, c.ImageURL,  
                            ct.Name AS Categories, c.Status, u.Username AS TeacherName  
                            FROM courses c
                            JOIN users u ON c.InstructorID = u.UserID
                            JOIN categories ct on ct.CategoryID = c.CategoryID
                            WHERE c.CourseID = ?
        """;

        try (Connection conn = dbConn.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    courseDTO = new CourseDTO();
                    courseDTO.setCourseID(rs.getInt("CourseID"));
                    courseDTO.setCourseTitle(rs.getString("Title"));
                    courseDTO.setCourseDescription(rs.getString("Description"));
                    courseDTO.setPrice(rs.getBigDecimal("Price"));
                    courseDTO.setRating(rs.getDouble("Rating"));
                    Timestamp createdAtTimestamp = rs.getTimestamp("CreatedAt");
                    courseDTO.setCreatedAt(createdAtTimestamp != null ? createdAtTimestamp.toInstant() : null);
                    courseDTO.setTeacherName(rs.getString("TeacherName"));
                    courseDTO.setCategories(rs.getString("Categories"));
                    courseDTO.setCourseStatus(rs.getString("Status"));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Failed to fetch course", e);
        }

        return courseDTO;
    }

    @Override
    public List<LessonDTO> getLessonsByCourseId(int courseId) {
        List<LessonDTO> lessons = new ArrayList<>();
        String sql = """
                SELECT LessonID, Title, Content, Status, IsFreePreview, CreatedAt 
                FROM lessons WHERE CourseID = ?
        """;
        try (Connection conn = dbConn.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, courseId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    LessonDTO lesson = new LessonDTO();
                    lesson.setLessonID(rs.getInt("LessonID"));
                    lesson.setTitle(rs.getString("Title"));
                    lesson.setContent(rs.getString("Content"));
                    lesson.setStatus(rs.getString("Status"));
                    lesson.setIsFreePreview(rs.getBoolean("IsFreePreview"));
                    Timestamp createdAtTimestamp = rs.getTimestamp("CreatedAt");
                    lesson.setCreatedAt(createdAtTimestamp != null ? createdAtTimestamp.toInstant() : null);
                    lessons.add(lesson);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Failed to fetch lessons", e);
        }
        return lessons;
    }

    @Override
    public List<FeedbackDTO> getFeedbacksByCourseId(int courseId) {
        List<FeedbackDTO> feedbacks = new ArrayList<>();
        String sql = """
            SELECT f.FeedbackID, f.Rating, f.Comment, f.CreatedAt, u.UserName 
                            FROM feedback f 
                            LEFT JOIN users u ON f.UserID = u.UserID 
                            WHERE f.CourseID = ?
        """;
        try (Connection conn = dbConn.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, courseId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    FeedbackDTO feedback = new FeedbackDTO();
                    feedback.setFeedbackID(rs.getInt("FeedbackID"));
                    feedback.setRating(rs.getInt("Rating"));
                    feedback.setComment(rs.getString("Comment"));
                    Timestamp createdAtTimestamp = rs.getTimestamp("CreatedAt");
                    feedback.setCreatedAt(createdAtTimestamp != null ? createdAtTimestamp.toInstant() : null);
                    feedback.setUserName(rs.getString("UserName"));
                    feedbacks.add(feedback);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Failed to fetch feedbacks", e);
        }
        return feedbacks;
    }
}

