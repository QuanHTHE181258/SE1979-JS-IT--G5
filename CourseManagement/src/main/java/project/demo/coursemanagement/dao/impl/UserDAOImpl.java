package project.demo.coursemanagement.dao.impl;

import project.demo.coursemanagement.dao.UserDAO;
import project.demo.coursemanagement.entities.User;
import project.demo.coursemanagement.utils.DatabaseConnection;
import project.demo.coursemanagement.entities.Role;

import java.sql.*;
import java.time.Instant;
import java.time.LocalDate;
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
                           u.first_name, u.last_name, u.phone, u.date_of_birth, u.avatar_url,
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

    // Find user by ID including inactive users
    @Override
    public User findUserByIdIncludeInactive(Integer id) {
        String sql = """
                    SELECT u.user_id, u.username, u.email, u.password_hash,
                           u.first_name, u.last_name, u.phone, u.date_of_birth, u.avatar_url,
                           u.is_active, u.email_verified, u.last_login,
                           u.created_at, u.updated_at,
                           r.role_id, r.role_name, r.description as role_description
                    FROM Users u
                    INNER JOIN Roles r ON u.role_id = r.role_id
                    WHERE u.user_id = ?
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
            System.err.println("Error finding user by ID (including inactive): " + e.getMessage());
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

    @Override
    public List<User> searchUsersByName(String searchTerm) {
        List<User> users = new ArrayList<>();
        String sql = "SELECT u.user_id, u.username, u.email, u.password_hash, u.first_name, u.last_name, u.phone, u.date_of_birth, u.avatar_url, u.is_active, u.email_verified, u.last_login, u.created_at, u.updated_at, r.role_id, r.role_name, r.description as role_description FROM Users u INNER JOIN Roles r ON u.role_id = r.role_id WHERE u.first_name LIKE ? OR u.last_name LIKE ? OR u.username LIKE ?";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            String searchPattern = "%" + searchTerm + "%";
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);
            stmt.setString(3, searchPattern);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    users.add(mapResultSetToUser(rs));
                }
            }
        } catch (SQLException e) {
            System.err.println("Error searching users by name: " + e.getMessage());
            e.printStackTrace();
        }
        return users;
    }
// get recent logins
    @Override
    public List<User> getRecentLogins(int limit) {
        List<User> users = new ArrayList<>();
        String sql = """
            SELECT TOP (?) u.user_id, u.username, u.email, u.password_hash, u.first_name, u.last_name,
                   u.phone, u.date_of_birth, u.avatar_url, u.is_active, u.email_verified, u.last_login,
                   u.created_at, u.updated_at, r.role_id, r.role_name, r.description as role_description
            FROM Users u
            INNER JOIN Roles r ON u.role_id = r.role_id
            WHERE u.last_login IS NOT NULL
            ORDER BY u.last_login DESC
        """;
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, limit);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    users.add(mapResultSetToUser(rs));
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting recent logins: " + e.getMessage());
            e.printStackTrace();
        }
        return users;
    }

    @Override
    public List<User> findUsers(String search, String roleName, int offset, int limit) {
        List<User> users = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT u.user_id, u.username, u.email, u.password_hash, u.first_name, u.last_name, u.phone, u.date_of_birth, u.avatar_url, u.is_active, u.email_verified, u.last_login, u.created_at, u.updated_at, r.role_id, r.role_name, r.description as role_description FROM Users u INNER JOIN Roles r ON u.role_id = r.role_id WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (search != null && !search.trim().isEmpty()) {
            sql.append(" AND (u.username LIKE ? OR u.email LIKE ? OR u.first_name LIKE ? OR u.last_name LIKE ?)");
            String searchPattern = "%" + search + "%";
            params.add(searchPattern);
            params.add(searchPattern);
            params.add(searchPattern);
            params.add(searchPattern);
        }

        if (roleName != null && !roleName.trim().isEmpty()) {
            sql.append(" AND r.role_name = ?");
            params.add(roleName);
        }

        sql.append(" ORDER BY u.user_id");
        sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"); // SQL Server syntax for pagination

        params.add(offset);
        params.add(limit);

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    users.add(mapResultSetToUser(rs));
                }
            }
        } catch (SQLException e) {
            System.err.println("Error finding users with search, filter, and pagination: " + e.getMessage());
            e.printStackTrace();
        }
        return users;
    }

    @Override
    public int countUsers(String search, String roleName) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM Users u INNER JOIN Roles r ON u.role_id = r.role_id WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (search != null && !search.trim().isEmpty()) {
            sql.append(" AND (u.username LIKE ? OR u.email LIKE ? OR u.first_name LIKE ? OR u.last_name LIKE ?)");
            String searchPattern = "%" + search + "%";
            params.add(searchPattern);
            params.add(searchPattern);
            params.add(searchPattern);
            params.add(searchPattern);
        }

        if (roleName != null && !roleName.trim().isEmpty()) {
            sql.append(" AND r.role_name = ?");
            params.add(roleName);
        }

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error counting users with search and filter: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public boolean createUser(User user) {
        String sql = "INSERT INTO Users (username, email, password_hash, first_name, last_name, phone, date_of_birth, avatar_url, role_id, is_active, email_verified, created_at, updated_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPasswordHash());
            stmt.setString(4, user.getFirstName());
            stmt.setString(5, user.getLastName());
            stmt.setString(6, user.getPhone());
            stmt.setObject(7, user.getDateOfBirth()); // LocalDate
            stmt.setString(8, user.getAvatarUrl());
            stmt.setInt(9, user.getRole().getId()); // Assuming Role object has an ID
            stmt.setBoolean(10, user.getIsActive());
            stmt.setBoolean(11, user.getEmailVerified());
            stmt.setTimestamp(12, Timestamp.from(Instant.now())); // created_at
            stmt.setTimestamp(13, Timestamp.from(Instant.now())); // updated_at

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error creating user: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean updateUser(User user) {
        String sql = "UPDATE Users SET username = ?, email = ?, password_hash = ?, first_name = ?, last_name = ?, phone = ?, date_of_birth = ?, avatar_url = ?, role_id = ?, is_active = ?, email_verified = ?, updated_at = ? WHERE user_id = ?";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPasswordHash());
            stmt.setString(4, user.getFirstName());
            stmt.setString(5, user.getLastName());
            stmt.setString(6, user.getPhone());
            stmt.setObject(7, user.getDateOfBirth());
            stmt.setString(8, user.getAvatarUrl());
            stmt.setInt(9, user.getRole().getId());
            stmt.setBoolean(10, user.getIsActive());
            stmt.setBoolean(11, user.getEmailVerified());
            stmt.setTimestamp(12, Timestamp.from(Instant.now())); // updated_at
            stmt.setInt(13, user.getId());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error updating user: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean deleteUser(int userId) {
        String sql = "DELETE FROM Users WHERE user_id = ?";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting user: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
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
        if (lastLoginTs != null) {
            user.setLastLogin(lastLoginTs.toInstant());
        }

        Timestamp createdAtTs = rs.getTimestamp("created_at");
        if (createdAtTs != null) {
            user.setCreatedAt(createdAtTs.toInstant());
        }

        Timestamp updatedAtTs = rs.getTimestamp("updated_at");
        if (updatedAtTs != null) {
            user.setUpdatedAt(updatedAtTs.toInstant());
        }

        // Map Role
        Role role = new Role();
        role.setId(rs.getInt("role_id"));
        role.setRoleName(rs.getString("role_name"));
        role.setDescription(rs.getString("role_description"));

        user.setRole(role);

        return user;
    }

    @Override
    public boolean updatePassword(Integer userId, String newPassword) {
        String sql = "UPDATE Users SET password_hash = ?, updated_at = GETDATE() WHERE user_id = ?";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement statement = conn.prepareStatement(sql)) {

            statement.setString(1, newPassword);
            statement.setInt(2, userId);
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating password: " + e.getMessage());
            return false;
        }
    }

    @Override
    public boolean updateAndUploadAvatar(Integer userId, String avatarPath) {
        String sql = "UPDATE Users SET avatar_url = ? WHERE user_id = ?";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement statement = conn.prepareStatement(sql)) {

            statement.setString(1, avatarPath);
            statement.setInt(2, userId);
            return statement.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Error updating and uploading avatar: " + e.getMessage());
            return false;
        }
    }
}
