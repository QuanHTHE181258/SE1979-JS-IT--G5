package project.demo.coursemanagement.dao;

import project.demo.coursemanagement.dao.UserDAO;
import project.demo.coursemanagement.entities.User;
import project.demo.coursemanagement.utils.DatabaseConnection;
import project.demo.coursemanagement.entities.Role;

import java.sql.*;
import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.util.ArrayList;
import java.util.List;

public class UserDAOImpl implements UserDAO {

    // Find user by username or email
    @Override
    public User findUserByUsernameOrEmail(String identifier) {
        String sql = """
                    SELECT u.user_id, u.username, u.email, u.password_hash,u.first_name,
                           u.last_name, u.phone, u.date_of_birth, u.avatar_url,
                           u.is_active, u.email_verified, u.last_login,
                           u.created_at, u.updated_at,
                           r.role_id, r.role_name, r.description as role_description
                    FROM Users u
                    INNER JOIN Roles r ON u.role_id = r.role_id
                    WHERE (u.username = ? OR u.email = ?) AND u.is_active = 1
                """;
        try (Connection connection = DatabaseConnection.getInstance().getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, identifier);
            statement.setString(2, identifier);

            try(ResultSet rs = statement.executeQuery()){
                if(rs.next()){
                    return mapResultSetToUser(rs);
                }
            }
        }catch (SQLException e) {
            System.err.println("Error finding user by username or email: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    // Find user by ID
    @Override
    public User findUserById(Integer id) {
        String sql = """
                    SELECT u.user_id, u.username, u.email, u.password_hash,
                           u.full_name, u.phone, u.date_of_birth, u.avatar_url,
                           u.is_active, u.email_verified, u.last_login,
                           u.created_at, u.updated_at,
                           r.role_id, r.role_name, r.description as role_description
                    FROM Users u
                    INNER JOIN Roles r ON u.role_id = r.role_id
                    WHERE u.user_id = ? AND u.is_active = 1
                """;
        try (Connection connection = DatabaseConnection.getInstance().getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, id);

            try(ResultSet rs = statement.executeQuery()){
                if(rs.next()){
                    return mapResultSetToUser(rs);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error finding user by ID: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean UpdateLastLogin(Integer userId) {
        String sql = "UPDATE Users SET last_login = GETDATE() WHERE user_id = ?";

        try(Connection conn = DatabaseConnection.getInstance().getConnection();
            PreparedStatement statement = conn.prepareStatement(sql)) {

            statement.setInt(1, userId);
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating last login: " + e.getMessage());
            return false;
        }
    }

    @Override
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT u.user_id, u.username, u.email, u.password_hash, u.first_name, u.last_name, u.phone, u.date_of_birth, u.avatar_url, u.is_active, u.email_verified, u.last_login, u.created_at, u.updated_at, r.role_id, r.role_name, r.description as role_description FROM Users u INNER JOIN Roles r ON u.role_id = r.role_id";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                users.add(mapResultSetToUser(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting all users: " + e.getMessage());
            e.printStackTrace();
        }
        return users;
    }

    // Retrieve user details from ResultSet and map to User object
    private User mapResultSetToUser(ResultSet rs) throws SQLException {
        User user = new User();
        user.setId(rs.getInt("user_id"));
        user.setUsername(rs.getString("username"));
        user.setEmail(rs.getString("email"));
        user.setPasswordHash(rs.getString("password_hash"));
        user.setFirstName(rs.getString("first_name"));
        user.setLastName(rs.getString("last_name"));
        user.setPhone(rs.getString("phone"));
        user.setDateOfBirth(rs.getObject("date_of_birth", LocalDate.class));
        user.setAvatarUrl(rs.getString("avatar_url"));
        user.setIsActive(rs.getBoolean("is_active"));
        user.setEmailVerified(rs.getBoolean("email_verified"));
        Timestamp lastLoginTs = rs.getTimestamp("last_login");
        user.setLastLogin(lastLoginTs != null ? lastLoginTs.toInstant() : null);

        Timestamp createdAtTs = rs.getTimestamp("created_at");
        user.setCreatedAt(createdAtTs != null ? createdAtTs.toInstant() : null);

        Timestamp updatedAtTs = rs.getTimestamp("updated_at");
        user.setUpdatedAt(updatedAtTs != null ? updatedAtTs.toInstant() : null);

        // Map Role
        Role role = new Role();
        role.setId(rs.getInt("role_id"));
        role.setRoleName(rs.getString("role_name"));
        role.setDescription(rs.getString("role_description"));

        user.setRole(role);

        return user;
    }
}

