package project.demo.coursemanagement.dao.impl;

import project.demo.coursemanagement.dao.HomeDAO;
import project.demo.coursemanagement.dto.CourseDTO;
import project.demo.coursemanagement.utils.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class HomeDAOimp implements HomeDAO {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    DatabaseConnection dbConn = DatabaseConnection.getInstance();

    @Override
    public List<CourseDTO> getAllCourses() {
        List<CourseDTO> courses = new ArrayList<>();
        String sql = """
                SELECT DISTINCT c.CourseID, c.Title, c.Description, u.Username, 
                                ct.Name AS CategoryName, c.Price, c.Rating, c.Status
                FROM courses c
                JOIN users u ON c.InstructorID = u.UserID
                JOIN categories ct ON ct.CategoryID = c.CategoryID
                """;
        try (Connection conn = dbConn.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                CourseDTO course = new CourseDTO();
                course.setCourseID(rs.getInt("CourseID"));
                course.setCourseTitle(rs.getString("Title"));
                course.setCourseDescription(rs.getString("Description"));
                course.setTeacherName(rs.getString("Username"));
                course.setCategories(rs.getString("CategoryName"));
                course.setPrice(rs.getBigDecimal("Price"));
                course.setRating(rs.getDouble("Rating"));
                course.setCourseStatus(rs.getString("Status"));
                courses.add(course);
            }

        } catch (SQLException e) {
            throw new RuntimeException("Failed to fetch courses", e);
        }

        return courses;
    }
}

