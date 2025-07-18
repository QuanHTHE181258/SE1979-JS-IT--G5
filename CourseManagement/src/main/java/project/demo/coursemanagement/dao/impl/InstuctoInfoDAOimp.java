package project.demo.coursemanagement.dao.impl;

import project.demo.coursemanagement.dao.InstructorInfoDAO;
import project.demo.coursemanagement.dto.UserDTO;
import project.demo.coursemanagement.entities.User;
import project.demo.coursemanagement.utils.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class InstuctoInfoDAOimp {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    DatabaseConnection dbConn = DatabaseConnection.getInstance();

    public UserDTO getUserByUsername(String username) {
        UserDTO user = null;
        String sql = """
                    SELECt u.Username, u.FirstName + ' ' + u.LastName AS FullName, u.Email, u.PhoneNumber, u.DateOfBirth
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
                }
            }
        } catch (Exception e) {
            throw new RuntimeException("Failed to fetch user" ,e);
        }
        return user;
    }
}
