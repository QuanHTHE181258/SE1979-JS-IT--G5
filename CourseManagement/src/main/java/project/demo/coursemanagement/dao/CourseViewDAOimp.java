package project.demo.coursemanagement.dao;

import project.demo.coursemanagement.dto.CourseDTO;
import project.demo.coursemanagement.utils.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CourseViewDAOimp implements CourseViewDAO {

    List<CourseDTO> courses = new ArrayList<>();
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    DatabaseConnection dbConn = DatabaseConnection.getInstance();

    @Override
    public List<CourseDTO> getAllCourses() {


        try {
            conn = dbConn.getConnection();
            String sql = """
            SELECT DISTINCT c.course_code, c.title, c.short_description, u.username, c.price,
                    c.duration_hours, c.max_students, c.start_date, c.end_date
            FROM Courses c
            JOIN Users u ON c.teacher_id = u.user_id 
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
            course.setCourseCode(rs.getString("course_code"));
            course.setTitle(rs.getString("title"));
            course.setShortDescription(rs.getString("short_description"));
            course.setTeacherUsername(rs.getString("username"));
            course.setPrice(rs.getBigDecimal("price"));
            course.setDurationHours(rs.getInt("duration_hours"));
            course.setMaxStudents(rs.getInt("max_students"));
            Timestamp startDate = rs.getTimestamp("start_date");
            course.setStartDate(startDate != null ? startDate.toInstant() : null);
            Timestamp endDate = rs.getTimestamp("end_date");
            course.setEndDate(endDate != null ? endDate.toInstant() : null);
            return course;
        }catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error extracting course from result set: " + e.getMessage());
            throw e;
        }
    }

    public static void main(String[] args) {
        DatabaseConnection dbConn = DatabaseConnection.getInstance();
        boolean isConnected = dbConn.testConnection();
        System.out.println("Database connection successful: " + isConnected);
    }
}