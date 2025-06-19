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
        try {
            conn = dbConn.getConnection();
            String sql = """
                SELECT DISTINCT c.CourseID, c.Title, c.Description, u.Username, ct.Name, c.Price,
                c.Rating, c.Status
                FROM courses c
                JOIN users u ON c.InstructorID = u.UserID
                JOIN categories ct on ct.CategoryID = c.CategoryID
            """;
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                CourseDTO course = extractCourseFromResultSet(rs);
                courses.add(course);
            }
            System.out.println("Number of courses retrieved: " + courses.size());
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error retrieving courses: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) dbConn.closeConnection(conn);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return courses;
    }

    private CourseDTO extractCourseFromResultSet(ResultSet rs) throws SQLException {
        try {
            CourseDTO course = new CourseDTO();
            course.setCourseID(rs.getInt("CourseID"));
            course.setCourseTitle(rs.getString("Title"));
            course.setCourseDescription(rs.getString("Description"));
            course.setTeacherName(rs.getString("Name"));
            course.setCategories(rs.getString("Name"));
            course.setPrice(rs.getBigDecimal("Price"));
            course.setCourseStatus(rs.getString("Status"));
            return course;
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error extracting course from result set: " + e.getMessage());
            throw e;
        }
    }
}

