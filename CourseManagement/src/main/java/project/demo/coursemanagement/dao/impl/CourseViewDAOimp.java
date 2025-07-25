package project.demo.coursemanagement.dao.impl;

import project.demo.coursemanagement.dao.CourseViewDAO;
import project.demo.coursemanagement.dto.CourseDTO;
import project.demo.coursemanagement.utils.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Implementation of the CourseViewDAO interface
 */
public class CourseViewDAOimp implements CourseViewDAO {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    DatabaseConnection dbConn = DatabaseConnection.getInstance();

    @Override
    public List<CourseDTO> getAllCourses() {
        List<CourseDTO> courses = new ArrayList<>();
        String sql = """
            SELECT DISTINCT c.CourseID, c.Title, c.Description, u.Username, ct.Name, c.Price,
                            c.Rating, c.Status
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
                course.setCategories(rs.getString("Name"));
                course.setPrice(rs.getBigDecimal("Price"));
                course.setRating(rs.getDouble("Rating"));
                course.setCourseStatus(rs.getString("Status"));
                courses.add(course);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error retrieving all courses", e);
        }

        return courses;
    }

    @Override
    public List<CourseDTO> getCoursesByPage(int page, int size) {
        List<CourseDTO> courses = new ArrayList<>();
        String sql = """
            SELECT DISTINCT c.CourseID, c.Title, c.Description, u.Username, ct.Name, c.Price,
                            c.Rating, c.Status
            FROM courses c
            JOIN users u ON c.InstructorID = u.UserID
            JOIN categories ct ON ct.CategoryID = c.CategoryID
            ORDER BY c.CourseID
            OFFSET ? ROWS FETCH NEXT ? ROWS ONLY
        """;

        try (Connection conn = dbConn.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, (page - 1) * size);
            ps.setInt(2, size);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    CourseDTO course = new CourseDTO();
                    course.setCourseID(rs.getInt("CourseID"));
                    course.setCourseTitle(rs.getString("Title"));
                    course.setCourseDescription(rs.getString("Description"));
                    course.setTeacherName(rs.getString("Username"));
                    course.setCategories(rs.getString("Name"));
                    course.setPrice(rs.getBigDecimal("Price"));
                    course.setRating(rs.getDouble("Rating"));
                    course.setCourseStatus(rs.getString("Status"));
                    courses.add(course);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error retrieving paginated courses", e);
        }

        return courses;
    }

    @Override
    public int getTotalCourseCount() {
        String sql = "SELECT COUNT(*) FROM courses";

        try (Connection conn = dbConn.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error counting courses", e);
        }

        return 0;
    }
}
