package project.demo.coursemanagement.dao;

import project.demo.coursemanagement.entities.User;
import project.demo.coursemanagement.entities.Role;
import project.demo.coursemanagement.utils.DatabaseConnection;

import java.sql.*;
import java.time.Instant;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class RegisterDAOImpl implements RegisterDAO {

    // Create new user in database
    @Override
    public boolean createUser(User user) {
        String sql = """
            INSERT INTO Users (username, email, password_hash, first_name, last_name, 
                             phone, date_of_birth, role_id, is_active, email_verified, 
                             created_at, updated_at)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, GETDATE(), GETDATE())
        """;

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPasswordHash());
            stmt.setString(4, user.getFirstName());
            stmt.setString(5, user.getLastName());
            stmt.setString(6, user.getPhone());

            if (user.getDateOfBirth() != null) {
                stmt.setDate(7, Date.valueOf(user.getDateOfBirth()));
            } else {
                stmt.setNull(7, Types.DATE);
            }

            stmt.setInt(8, user.getRole().getId());
            stmt.setBoolean(9, user.getIsActive() != null ? user.getIsActive() : true);
            stmt.setBoolean(10, user.getEmailVerified() != null ? user.getEmailVerified() : false);

            int result = stmt.executeUpdate();

            if (result > 0) {
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        user.setId(rs.getInt(1));
                    }
                }
                return true;
            }

        } catch (SQLException e) {
            System.err.println("Error creating user: " + e.getMessage());
            e.printStackTrace();
        }

        return false;
    }

    // Check if username exists
    @Override
    public boolean isUsernameExists(String username) {
        String sql = "SELECT COUNT(*) FROM Users WHERE username = ?";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }

        } catch (SQLException e) {
            System.err.println("Error checking username existence: " + e.getMessage());
        }

        return false;
    }

    // Check if email exists
    @Override
    public boolean isEmailExists(String email) {
        String sql = "SELECT COUNT(*) FROM Users WHERE email = ?";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }

        } catch (SQLException e) {
            System.err.println("Error checking email existence: " + e.getMessage());
        }

        return false;
    }

    // Find user by username
    @Override
    public User findByUsername(String username) {
        String sql = """
            SELECT u.user_id, u.username, u.email, u.password_hash, u.first_name, u.last_name,
                   u.phone, u.date_of_birth, u.is_active, u.email_verified, u.created_at, u.updated_at,
                   r.role_id, r.role_name, r.description
            FROM Users u 
            INNER JOIN Roles r ON u.role_id = r.role_id
            WHERE u.username = ?
        """;

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUser(rs);
                }
            }

        } catch (SQLException e) {
            System.err.println("Error finding user by username: " + e.getMessage());
        }

        return null;
    }

    // Find user by email
    @Override
    public User findByEmail(String email) {
        String sql = """
            SELECT u.user_id, u.username, u.email, u.password_hash, u.first_name, u.last_name,
                   u.phone, u.date_of_birth, u.is_active, u.email_verified, u.created_at, u.updated_at,
                   r.role_id, r.role_name, r.description
            FROM Users u 
            INNER JOIN Roles r ON u.role_id = r.role_id
            WHERE u.email = ?
        """;

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUser(rs);
                }
            }

        } catch (SQLException e) {
            System.err.println("Error finding user by email: " + e.getMessage());
        }

        return null;
    }

    // Get role by name
    @Override
    public Role findRoleByName(String roleName) {
        String sql = "SELECT role_id, role_name, description, created_at FROM Roles WHERE role_name = ?";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, roleName);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToRole(rs);
                }
            }

        } catch (SQLException e) {
            System.err.println("Error finding role by name: " + e.getMessage());
        }

        return null;
    }

    // Get role by ID
    @Override
    public Role findRoleById(Integer roleId) {
        String sql = "SELECT role_id, role_name, description, created_at FROM Roles WHERE role_id = ?";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, roleId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToRole(rs);
                }
            }

        } catch (SQLException e) {
            System.err.println("Error finding role by ID: " + e.getMessage());
        }

        return null;
    }

    // Get available roles for registration
    @Override
    public List<Role> getAvailableRoles() {
        String sql = """
            SELECT role_id, role_name, description, created_at 
            FROM Roles 
            WHERE role_name IN ('USER', 'TEACHER')
            ORDER BY role_name
        """;

        List<Role> roles = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                roles.add(mapResultSetToRole(rs));
            }

        } catch (SQLException e) {
            System.err.println("Error getting available roles: " + e.getMessage());
        }

        return roles;
    }

    // Update email verification status
    @Override
    public boolean updateEmailVerificationStatus(Integer userId, boolean verified) {
        String sql = "UPDATE Users SET email_verified = ?, updated_at = GETDATE() WHERE user_id = ?";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setBoolean(1, verified);
            stmt.setInt(2, userId);

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Error updating email verification status: " + e.getMessage());
        }

        return false;
    }

    // Update user active status
    @Override
    public boolean updateUserActiveStatus(Integer userId, boolean active) {
        String sql = "UPDATE Users SET is_active = ?, updated_at = GETDATE() WHERE user_id = ?";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setBoolean(1, active);
            stmt.setInt(2, userId);

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Error updating user active status: " + e.getMessage());
        }

        return false;
    }

    // Get registration statistics
    @Override
    public RegistrationStats getRegistrationStatistics() {
        String sql = """
            SELECT 
                (SELECT COUNT(*) FROM Users) as total_users,
                (SELECT COUNT(*) FROM Users WHERE CAST(created_at AS DATE) = CAST(GETDATE() AS DATE)) as today_registrations,
                (SELECT COUNT(*) FROM Users WHERE created_at >= DATEADD(week, -1, GETDATE())) as weekly_registrations,
                (SELECT COUNT(*) FROM Users WHERE created_at >= DATEADD(month, -1, GETDATE())) as monthly_registrations,
                (SELECT COUNT(*) FROM Users WHERE is_active = 1) as active_users,
                (SELECT COUNT(*) FROM Users WHERE email_verified = 0) as pending_verifications
        """;

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                return new RegistrationStats(
                        rs.getInt("total_users"),
                        rs.getInt("today_registrations"),
                        rs.getInt("weekly_registrations"),
                        rs.getInt("monthly_registrations"),
                        rs.getInt("active_users"),
                        rs.getInt("pending_verifications")
                );
            }

        } catch (SQLException e) {
            System.err.println("Error getting registration statistics: " + e.getMessage());
        }

        return new RegistrationStats();
    }

    // Get recent registrations
    @Override
    public List<User> getRecentRegistrations(int limit) {
        String sql = """
            SELECT TOP (?) u.user_id, u.username, u.email, u.password_hash, u.first_name, u.last_name,
                   u.phone, u.date_of_birth, u.is_active, u.email_verified, u.created_at, u.updated_at,
                   r.role_id, r.role_name, r.description
            FROM Users u 
            INNER JOIN Roles r ON u.role_id = r.role_id
            ORDER BY u.created_at DESC
        """;

        List<User> users = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, limit);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    users.add(mapResultSetToUser(rs));
                }
            }

        } catch (SQLException e) {
            System.err.println("Error getting recent registrations: " + e.getMessage());
        }

        return users;
    }

    // Check if registration is enabled
    @Override
    public boolean isRegistrationEnabled() {
        String sql = """
            SELECT setting_value 
            FROM SystemSettings 
            WHERE setting_key = 'REGISTRATION_ENABLED'
        """;

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                String value = rs.getString("setting_value");
                return "true".equalsIgnoreCase(value) || "1".equals(value);
            }

        } catch (SQLException e) {
            System.err.println("Error checking if registration is enabled: " + e.getMessage());
        }

        return true; // Default to enabled if setting not found
    }

    // Log registration attempt
    @Override
    public boolean logRegistrationAttempt(String username, String email, String ipAddress, boolean success, String message) {
        // In a real implementation, this would insert into an audit log table
        System.out.println("Registration Attempt Log:");
        System.out.println("  Username: " + username);
        System.out.println("  Email: " + email);
        System.out.println("  IP: " + ipAddress);
        System.out.println("  Success: " + success);
        System.out.println("  Message: " + message);
        System.out.println("  Timestamp: " + Instant.now());

        return true; // Always return true for simulation
    }

    // Map ResultSet to User entity
    private User mapResultSetToUser(ResultSet rs) throws SQLException {
        User user = new User();
        user.setId(rs.getInt("user_id"));
        user.setUsername(rs.getString("username"));
        user.setEmail(rs.getString("email"));
        user.setPasswordHash(rs.getString("password_hash"));
        user.setFirstName(rs.getString("first_name"));
        user.setLastName(rs.getString("last_name"));
        user.setPhone(rs.getString("phone"));

        Date dateOfBirth = rs.getDate("date_of_birth");
        if (dateOfBirth != null) {
            user.setDateOfBirth(dateOfBirth.toLocalDate());
        }

        user.setIsActive(rs.getBoolean("is_active"));
        user.setEmailVerified(rs.getBoolean("email_verified"));

        Timestamp createdAt = rs.getTimestamp("created_at");
        if (createdAt != null) {
            user.setCreatedAt(Timestamp.from(Instant.now()));
        }

        Timestamp updatedAt = rs.getTimestamp("updated_at");
        if (updatedAt != null) {
            user.setUpdatedAt(Timestamp.from(Instant.now()));
        }

        // Map Role
        Role role = new Role();
        role.setId(rs.getInt("role_id"));
        role.setRoleName(rs.getString("role_name"));
        role.setDescription(rs.getString("description"));
        user.setRole(role);

        return user;
    }

    // Map ResultSet to Role entity
    private Role mapResultSetToRole(ResultSet rs) throws SQLException {
        Role role = new Role();
        role.setId(rs.getInt("role_id"));
        role.setRoleName(rs.getString("role_name"));
        role.setDescription(rs.getString("description"));

        Timestamp createdAt = rs.getTimestamp("created_at");
        if (createdAt != null) {
            role.setCreatedAt(LocalDateTime.from(createdAt.toInstant()));
        }

        return role;
    }
}