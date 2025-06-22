package project.demo.coursemanagement.dao.impl;

import project.demo.coursemanagement.dao.CourseCatalogDAO;
import project.demo.coursemanagement.dto.CourseDTO;
import project.demo.coursemanagement.entities.Cours;
import project.demo.coursemanagement.utils.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;


public class CourseCatalogDAOimp implements CourseCatalogDAO {

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
}

