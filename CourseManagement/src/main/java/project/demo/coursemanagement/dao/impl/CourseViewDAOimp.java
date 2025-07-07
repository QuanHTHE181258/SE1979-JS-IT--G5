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
            System.out.println("Number of courses retrieved in view-courses: " + courses.size());
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

    public List<CourseDTO> getCoursesByPage(int page, int size) {
        List<CourseDTO> courses = new ArrayList<>();
        try {
            conn = dbConn.getConnection();
            String sql = """
            SELECT DISTINCT c.CourseID, c.Title, c.Description, u.Username, ct.Name, c.Price,
                        c.Rating, c.Status
                        FROM courses c
                        JOIN users u ON c.InstructorID = u.UserID
                        JOIN categories ct on ct.CategoryID = c.CategoryID\s
                        ORDER BY c.CourseID
                        OFFSET ? ROWS
                        FETCH NEXT ? ROWS ONLY
        """;
            ps = conn.prepareStatement(sql);
            ps.setInt(1, (page - 1) * size);
            ps.setInt(2, size);
            rs = ps.executeQuery();

            while (rs.next()) {
                CourseDTO course = extractCourseFromResultSet(rs);
                courses.add(course);
            }
            System.out.println("Number of courses pages retrieved in view-courses : " + courses.size());
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

    public int getTotalCourseCount() {
        int count = 0;
        try {
            conn = dbConn.getConnection();
            String sql = "SELECT COUNT(*) FROM Courses";
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) count = rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) dbConn.closeConnection(conn);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return count;
    }

    private CourseDTO extractCourseFromResultSet(ResultSet rs) throws SQLException {
        try {
            CourseDTO course = new CourseDTO();
            course.setCourseID(rs.getInt("CourseID"));
            course.setCourseTitle(rs.getString("Title"));
            course.setCourseDescription(rs.getString("Description"));
            course.setTeacherName(rs.getString("Username"));
            course.setRating(rs.getDouble("Rating"));
            course.setCategories(rs.getString("Name"));
            course.setPrice(rs.getBigDecimal("Price"));
            course.setCourseStatus(rs.getString("Status"));
            return course;
        }catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error extracting course from result set: " + e.getMessage());
            throw e;
        }
    }
}
