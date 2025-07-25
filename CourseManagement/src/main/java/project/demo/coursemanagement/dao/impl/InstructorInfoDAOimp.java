package project.demo.coursemanagement.dao.impl;

import project.demo.coursemanagement.dao.InstructorInfoDAO;
import project.demo.coursemanagement.dto.CourseDTO;
import project.demo.coursemanagement.dto.UserDTO;
import project.demo.coursemanagement.utils.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class InstructorInfoDAOimp implements InstructorInfoDAO {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    DatabaseConnection dbConn = DatabaseConnection.getInstance();

    @Override
    public UserDTO getUserByUsername(String username) {
        UserDTO user = null;
        String sql = """
                    SELECt u.Username, u.FirstName + ' ' + u.LastName AS FullName, 
                           u.Email, u.PhoneNumber, u.DateOfBirth
                    FROM users u
                    WHERE u.Username = ?
                """;
        try (Connection conn = dbConn.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    user = new UserDTO();
                    user.setUsername(username);
                    user.setFullName(rs.getString("FullName"));
                    user.setEmail(rs.getString("Email"));
                    user.setPhoneNumber(rs.getString("PhoneNumber"));
                    Timestamp DateOfBirthTimestamp = rs.getTimestamp("DateOfBirth");
                    user.setDateOfBirth(DateOfBirthTimestamp != null ? DateOfBirthTimestamp.toInstant() : null);
                }
            }
        } catch (Exception e) {
            throw new RuntimeException("Failed to fetch user" ,e);
        }
        return user;
    }

    @Override
    public List<CourseDTO> getCoursesByInstructorUsernameAndPage(String username, int page, int size) {
        List<CourseDTO> courses = new ArrayList<>();
        String sql = """
            SELECT c.CourseID, c.Title, c.Description, c.Price, c.Rating, c.Status, c.CreatedAt
            FROM courses c
            JOIN users u ON c.InstructorID = u.UserID
            WHERE u.Username = ?
            ORDER BY c.CourseID
            OFFSET ? ROWS FETCH NEXT ? ROWS ONLY
        """;

        try (Connection conn = dbConn.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setInt(2, (page - 1) * size);
            ps.setInt(3, size);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    CourseDTO course = new CourseDTO();
                    course.setCourseID(rs.getInt("CourseID"));
                    course.setCourseTitle(rs.getString("Title"));
                    course.setCourseDescription(rs.getString("Description"));
                    course.setPrice(rs.getBigDecimal("Price"));
                    course.setRating(rs.getDouble("Rating"));
                    course.setCourseStatus(rs.getString("Status"));
                    Timestamp createdAt = rs.getTimestamp("CreatedAt");
                    course.setCreatedAt(createdAt != null ? createdAt.toInstant() : null);
                    courses.add(course);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return courses;
    }

    @Override
    public int countCoursesByInstructor(String username) {
        int count = 0;
        try {
            conn = dbConn.getConnection();
            String sql = """
            SELECT COUNT(*) FROM courses c
            JOIN users u ON c.InstructorID = u.UserID
            WHERE u.Username = ?
        """;
            ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            rs = ps.executeQuery();
            if (rs.next()) count = rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
        }
        return count;
    }
}
