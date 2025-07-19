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

    public List<CourseDTO> getCoursesByInstructorUsername(String username) {
        List<CourseDTO> courses = new ArrayList<>();
        String sql = "SELECT c.CourseID, c.Title, c.Description, c.Price, c.Rating, c.Status " +
                "FROM Courses c JOIN Users u ON c.InstructorID = u.UserID " +
                "WHERE u.Username = ?";
        try (Connection con = dbConn.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                CourseDTO course = new CourseDTO();
                course.setCourseID(rs.getInt("CourseID"));
                course.setCourseTitle(rs.getString("Title"));
                course.setCourseDescription(rs.getString("Description"));
                course.setPrice(rs.getBigDecimal("Price"));
                course.setRating(rs.getDouble("Rating"));
                course.setCourseStatus(rs.getString("Status"));
                courses.add(course);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return courses;
    }

}
