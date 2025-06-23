package project.demo.coursemanagement.dao.impl;

import project.demo.coursemanagement.dao.RegisterDAO;
import project.demo.coursemanagement.entities.User;
import project.demo.coursemanagement.entities.Role;
import project.demo.coursemanagement.utils.DatabaseConnection;

import java.sql.*;
import java.time.Instant;
import java.util.ArrayList;
import java.util.List;

public class RegisterDAOImpl implements RegisterDAO {

    // Create new user in database
    @Override
    public boolean createUser(User user) {
        String sql = """
            INSERT INTO users (Username, Email, PasswordHash, FirstName, LastName, 
                             PhoneNumber, DateOfBirth, CreatedAt)
            VALUES (?, ?, ?, ?, ?, ?, ?, GETDATE())
        """;

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPasswordHash());
            stmt.setString(4, user.getFirstName());
            stmt.setString(5, user.getLastName());
            stmt.setString(6, user.getPhoneNumber());

            if (user.getDateOfBirth() != null) {
                stmt.setDate(7, Date.valueOf(user.getDateOfBirth()));
            } else {
                stmt.setNull(7, Types.DATE);
            }

            int result = stmt.executeUpdate();

            if (result > 0) {
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        user.setId(rs.getInt(1));
                        // Set default avatar URL
                        setDefaultAvatar(user.getId());
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

    public boolean assignDefaultRoles(User user) {
        // Default to Student role (ID 1)
        return assignRole(user, 1);
    }

    private void setDefaultAvatar(Integer userId) {
        String updateAvatarSql = "UPDATE users SET AvatarURL = ? WHERE UserID = ?";
        String defaultAvatarPath = "/assets/avatar/default_avatar.png";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(updateAvatarSql)) {

            stmt.setString(1, defaultAvatarPath);
            stmt.setInt(2, userId);
            stmt.executeUpdate();

            System.out.println("Default avatar set for user ID: " + userId);

        } catch (SQLException e) {
            System.err.println("Error setting default avatar: " + e.getMessage());
            // Don't fail registration if avatar setting fails
        }
    }

    @Override
    public boolean assignRole(User user, Integer roleId) {
        String sql = """
            INSERT INTO user_roles (UserID, RoleID)
            VALUES (?, ?)
        """;

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, user.getId()); // Set user ID
            stmt.setInt(2, roleId); // Set role ID

            int result = stmt.executeUpdate();
            return result > 0;

        } catch (SQLException e) {
            System.err.println("Error assigning role: " + e.getMessage());
            e.printStackTrace();
        }

        return false;
    }

    // Check if username exists
    @Override
    public boolean isUsernameExists(String username) {
        String sql = "SELECT COUNT(*) FROM users WHERE Username = ?";

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
        String sql = "SELECT COUNT(*) FROM users WHERE Email = ?";

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
            SELECT u.UserID, u.Username, u.Email, u.PasswordHash, u.FirstName, u.LastName,
                   u.PhoneNumber, u.DateOfBirth, u.LastLogin, u.CreatedAt
            FROM users u 
            WHERE u.Username = ?
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
            SELECT u.UserID, u.Username, u.Email, u.PasswordHash, u.FirstName, u.LastName,
                   u.PhoneNumber, u.DateOfBirth, u.LastLogin, u.CreatedAt
            FROM users u 
            WHERE u.Email = ?
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
        String sql = "SELECT RoleID, RoleName FROM roles WHERE RoleName = ?";

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
        String sql = "SELECT RoleID, RoleName FROM roles WHERE RoleID = ?";

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
            SELECT RoleID, RoleName 
            FROM roles 
            WHERE RoleID = 1  -- Student role (ID 1)
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
    // Note: email_verified field no longer exists in the database schema
    @Override
    public boolean updateEmailVerificationStatus(Integer userId, boolean verified) {
        // This method is kept for backward compatibility but doesn't do anything
        System.out.println("updateEmailVerificationStatus called but email_verified field no longer exists");
        return true;
    }

    // Update user active status
    // Note: is_active field no longer exists in the database schema
    @Override
    public boolean updateUserActiveStatus(Integer userId, boolean active) {
        // This method is kept for backward compatibility but doesn't do anything
        System.out.println("updateUserActiveStatus called but is_active field no longer exists");
        return true;
    }

    // Get registration statistics
    @Override
    public RegistrationStats getRegistrationStatistics() {
        String sql = """
            SELECT 
                (SELECT COUNT(*) FROM users) as total_users,
                (SELECT COUNT(*) FROM users WHERE CAST(CreatedAt AS DATE) = CAST(GETDATE() AS DATE)) as today_registrations,
                (SELECT COUNT(*) FROM users WHERE CreatedAt >= DATEADD(week, -1, GETDATE())) as weekly_registrations,
                (SELECT COUNT(*) FROM users WHERE CreatedAt >= DATEADD(month, -1, GETDATE())) as monthly_registrations
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
                        0, // No active_users field in new schema
                        0  // No pending_verifications field in new schema
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
            SELECT TOP (?) u.UserID, u.Username, u.Email, u.PasswordHash, u.FirstName, u.LastName,
                   u.PhoneNumber, u.DateOfBirth, u.LastLogin, u.CreatedAt
            FROM users u 
            ORDER BY u.CreatedAt DESC
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
        user.setId(rs.getInt("UserID"));
        user.setUsername(rs.getString("Username"));
        user.setEmail(rs.getString("Email"));
        user.setPasswordHash(rs.getString("PasswordHash"));
        user.setFirstName(rs.getString("FirstName"));
        user.setLastName(rs.getString("LastName"));
        user.setPhoneNumber(rs.getString("PhoneNumber"));

        Date dateOfBirth = rs.getDate("DateOfBirth");
        if (dateOfBirth != null) {
            user.setDateOfBirth(dateOfBirth.toLocalDate());
        }

        Timestamp createdAt = rs.getTimestamp("CreatedAt");
        if (createdAt != null) {
            user.setCreatedAt(createdAt.toInstant());
        }

        Timestamp lastLogin = rs.getTimestamp("LastLogin");
        if (lastLogin != null) {
            user.setLastLogin(lastLogin.toInstant());
        }

        return user;
    }

    // Map ResultSet to Role entity
    private Role mapResultSetToRole(ResultSet rs) throws SQLException {
        Role role = new Role();
        role.setId(rs.getInt("RoleID"));
        role.setRoleName(rs.getString("RoleName"));

        return role;
    }

}
