package project.demo.coursemanagement.dao.impl;

import project.demo.coursemanagement.dao.LessonPreviewDAO;
import project.demo.coursemanagement.dto.LessonDTO;
import project.demo.coursemanagement.utils.DatabaseConnection;

import java.math.BigDecimal;
import java.sql.*;

public class LessonPreviewDAOimp implements LessonPreviewDAO {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    DatabaseConnection dbConn = DatabaseConnection.getInstance();

    @Override
    public LessonDTO getLessonById(int lessonId) {
        LessonDTO lesson = null;
        String sql = """
                SELECT LessonID, CourseID, Title, Content, Status, IsFreePreview, CreatedAt
                FROM lessons
                WHERE LessonID = ?
                """;

        try (Connection conn = dbConn.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, lessonId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    lesson = new LessonDTO();
                    lesson.setLessonID(rs.getInt("LessonID"));
                    lesson.setTitle(rs.getString("Title"));
                    lesson.setContent(rs.getString("Content"));
                    lesson.setStatus(rs.getString("Status"));
                    lesson.setIsFreePreview(rs.getBoolean("IsFreePreview"));
                    Timestamp createdAt = rs.getTimestamp("CreatedAt");
                    lesson.setCreatedAt(createdAt != null ? createdAt.toInstant() : null);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return lesson;
    }
}
