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
                    SELECT u.UserID, u.Username, u.Email, u.PasswordHash, u.FirstName,
                           u.LastName, u.PhoneNumber, u.DateOfBirth, u.AvatarURL,
                           u.LastLogin, u.CreatedAt
                    FROM users u
                    WHERE (u.Username = ? OR u.Email = ?)
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
                    SELECT u.UserID, u.Username, u.Email, u.PasswordHash,
                           u.FirstName, u.LastName, u.PhoneNumber, u.DateOfBirth, u.AvatarURL,
                           u.LastLogin, u.CreatedAt
                    FROM users u
                    WHERE u.UserID = ?
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
        // Note: is_active field no longer exists in the database schema
        // This method is kept for backward compatibility but now behaves the same as findUserById
        return findUserById(id);
    }

    @Override
    public boolean UpdateLastLogin(Integer userId) {
        String sql = "UPDATE users SET LastLogin = GETDATE() WHERE UserID = ?";

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
        String sql = """
                    SELECT u.UserID, u.Username, u.Email, u.PasswordHash, u.FirstName,
                           u.LastName, u.PhoneNumber, u.DateOfBirth, u.AvatarURL,
                           u.LastLogin, u.CreatedAt,
                           r.RoleID, r.RoleName
                    FROM users u
                    INNER JOIN user_roles ur ON u.UserID = ur.UserID
                    INNER JOIN roles r ON ur.RoleID = r.RoleID
                """;
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
        String sql = """
                    SELECT u.UserID, u.Username, u.Email, u.PasswordHash, u.FirstName,
                           u.LastName, u.PhoneNumber, u.DateOfBirth, u.AvatarURL,
                           u.LastLogin, u.CreatedAt,
                           r.RoleID, r.RoleName
                    FROM users u
                    INNER JOIN user_roles ur ON u.UserID = ur.UserID
                    INNER JOIN roles r ON ur.RoleID = r.RoleID
                    WHERE u.FirstName LIKE ? OR u.LastName LIKE ? OR u.Username LIKE ?
                """;
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
            SELECT TOP (?) u.UserID, u.Username, u.Email, u.PasswordHash, u.FirstName, u.LastName,
                   u.PhoneNumber, u.DateOfBirth, u.AvatarURL, u.LastLogin, u.CreatedAt,
                   r.RoleID, r.RoleName
            FROM users u
            INNER JOIN user_roles ur ON u.UserID = ur.UserID
            INNER JOIN roles r ON ur.RoleID = r.RoleID
            WHERE u.LastLogin IS NOT NULL
            ORDER BY u.LastLogin DESC
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
        StringBuilder sql = new StringBuilder("""
            SELECT u.UserID, u.Username, u.Email, u.PasswordHash, u.FirstName, u.LastName,
                   u.PhoneNumber, u.DateOfBirth, u.AvatarURL, u.LastLogin, u.CreatedAt,
                   r.RoleID, r.RoleName
            FROM users u
            INNER JOIN user_roles ur ON u.UserID = ur.UserID
            INNER JOIN roles r ON ur.RoleID = r.RoleID
            WHERE 1=1
        """);
        List<Object> params = new ArrayList<>();

        if (search != null && !search.trim().isEmpty()) {
            sql.append(" AND (u.Username LIKE ? OR u.Email LIKE ? OR u.FirstName LIKE ? OR u.LastName LIKE ?)");
            String searchPattern = "%" + search + "%";
            params.add(searchPattern);
            params.add(searchPattern);
            params.add(searchPattern);
            params.add(searchPattern);
        }

        if (roleName != null && !roleName.trim().isEmpty()) {
            sql.append(" AND r.RoleName = ?");
            params.add(roleName);
        }

        sql.append(" ORDER BY u.UserID");
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
        StringBuilder sql = new StringBuilder("""
            SELECT COUNT(*) 
            FROM users u 
            INNER JOIN user_roles ur ON u.UserID = ur.UserID 
            INNER JOIN roles r ON ur.RoleID = r.RoleID 
            WHERE 1=1
        """);
        List<Object> params = new ArrayList<>();

        if (search != null && !search.trim().isEmpty()) {
            sql.append(" AND (u.Username LIKE ? OR u.Email LIKE ? OR u.FirstName LIKE ? OR u.LastName LIKE ?)");
            String searchPattern = "%" + search + "%";
            params.add(searchPattern);
            params.add(searchPattern);
            params.add(searchPattern);
            params.add(searchPattern);
        }

        if (roleName != null && !roleName.trim().isEmpty()) {
            sql.append(" AND r.RoleName = ?");
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
        String sql = "INSERT INTO users (Username, Email, PasswordHash, FirstName, LastName, PhoneNumber, DateOfBirth, AvatarURL, CreatedAt) VALUES (?, ?, ?, ?, ?, ?, ?, ?, GETDATE())";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPasswordHash());
            stmt.setString(4, user.getFirstName());
            stmt.setString(5, user.getLastName());
            stmt.setString(6, user.getPhoneNumber());
            stmt.setObject(7, user.getDateOfBirth()); // LocalDate
            stmt.setString(8, user.getAvatarUrl());

            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        user.setId(rs.getInt(1));
                    }
                }
            }

            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error creating user: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean updateUser(User user) {
        String sql = "UPDATE users SET Username = ?, Email = ?, PasswordHash = ?, FirstName = ?, LastName = ?, PhoneNumber = ?, DateOfBirth = ?, AvatarURL = ? WHERE UserID = ?";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPasswordHash());
            stmt.setString(4, user.getFirstName());
            stmt.setString(5, user.getLastName());
            stmt.setString(6, user.getPhoneNumber());
            stmt.setObject(7, user.getDateOfBirth());
            stmt.setString(8, user.getAvatarUrl());
            stmt.setInt(9, user.getId());

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
        String sql = "DELETE FROM users WHERE UserID = ?";
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
        user.setId(rs.getInt("UserID"));
        user.setUsername(rs.getString("Username"));
        user.setEmail(rs.getString("Email"));
        user.setPasswordHash(rs.getString("PasswordHash"));
        user.setFirstName(rs.getString("FirstName"));
        user.setLastName(rs.getString("LastName"));
        user.setPhoneNumber(rs.getString("PhoneNumber"));
        user.setDateOfBirth(rs.getObject("DateOfBirth", LocalDate.class));
        user.setAvatarUrl(rs.getString("AvatarURL"));

        Timestamp lastLoginTs = rs.getTimestamp("LastLogin");
        if (lastLoginTs != null) {
            user.setLastLogin(lastLoginTs.toInstant());
        }

        Timestamp createdAtTs = rs.getTimestamp("CreatedAt");
        if (createdAtTs != null) {
            user.setCreatedAt(createdAtTs.toInstant());
        }

        return user;
    }

    @Override
    public boolean updatePassword(Integer userId, String newPassword) {
        String sql = "UPDATE users SET PasswordHash = ? WHERE UserID = ?";
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
        String sql = "UPDATE users SET AvatarURL = ? WHERE UserID = ?";
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