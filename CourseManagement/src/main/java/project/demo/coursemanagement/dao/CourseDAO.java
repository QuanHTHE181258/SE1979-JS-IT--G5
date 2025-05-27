package project.demo.coursemanagement.dao;

import project.demo.coursemanagement.dto.CourseDTO;
import project.demo.coursemanagement.utils.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CourseDAO {
    List<CourseDTO> courses = new ArrayList<>();
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    DatabaseConnection dbConn = DatabaseConnection.getInstance();


    public CourseDTO getCourseByCode(String courseCode) {
        String sql = """
        SELECT c.course_code, c.title, c.short_description, u.username, c.price,
               c.duration_hours, c.max_students, c.start_date, c.end_date
        FROM Courses c
        JOIN Users u ON c.teacher_id = u.user_id
        WHERE c.course_code = ?
    """;

        try (Connection conn = dbConn.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, courseCode);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    CourseDTO course = new CourseDTO();
                    course.setCourseCode(rs.getString("course_code"));
                    course.setTitle(rs.getString("title"));
                    course.setShortDescription(rs.getString("short_description"));
                    course.setTeacherUsername(rs.getString("username"));
                    course.setPrice(rs.getBigDecimal("price"));
                    course.setDurationHours(rs.getInt("duration_hours"));
                    course.setMaxStudents(rs.getInt("max_students"));

                    Timestamp startTs = rs.getTimestamp("start_date");
                    if (startTs != null) {
                        course.setStartDate(startTs.toInstant());
                    }

                    Timestamp endTs = rs.getTimestamp("end_date");
                    if (endTs != null) {
                        course.setEndDate(endTs.toInstant());
                    }

                    return course;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error getting course by code: " + e.getMessage());
        }
        return null;
    }


    public boolean updateCourse(CourseDTO course) {
        String sql = """
        UPDATE Courses
        SET title = ?, short_description = ?, price = ?, duration_hours = ?, 
            max_students = ?, start_date = ?, end_date = ?, updated_at = GETDATE()
        WHERE course_code = ?
    """;

        try (Connection conn = dbConn.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, course.getTitle());
            ps.setString(2, course.getShortDescription());
            ps.setBigDecimal(3, course.getPrice());
            ps.setInt(4, course.getDurationHours());
            ps.setInt(5, course.getMaxStudents());

            if (course.getStartDate() != null) {
                ps.setTimestamp(6, Timestamp.from(course.getStartDate()));
            } else {
                ps.setNull(6, Types.TIMESTAMP);
            }

            if (course.getEndDate() != null) {
                ps.setTimestamp(7, Timestamp.from(course.getEndDate()));
            } else {
                ps.setNull(7, Types.TIMESTAMP);
            }

            ps.setString(8, course.getCourseCode());

            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error updating course: " + e.getMessage());
            return false;
        }
    }

}