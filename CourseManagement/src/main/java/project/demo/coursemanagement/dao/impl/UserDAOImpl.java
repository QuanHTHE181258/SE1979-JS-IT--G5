package project.demo.coursemanagement.dao.impl;

import project.demo.coursemanagement.dao.UserDAO;
import project.demo.coursemanagement.entities.User;
import project.demo.coursemanagement.utils.DatabaseConnection;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.text.Normalizer;
import java.util.regex.Pattern;

public class UserDAOImpl implements UserDAO {

    // Find user by username or email
    @Override
    public User findUserByUsernameOrEmail(String identifier) {
        String sql = """
                    SELECT u.UserID, u.Username, u.Email, u.PasswordHash, u.FirstName,
                           u.LastName, u.PhoneNumber, u.DateOfBirth, u.AvatarURL,
                           u.LastLogin, u.CreatedAt, u.Blocked
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
                           u.FirstName, u.LastName, u.PhoneNumber, u.DateOfBirth,
                           u.AvatarURL, u.LastLogin, u.CreatedAt, u.Blocked
                    FROM users u
                    WHERE u.UserID = ?
                """;
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            System.out.println("DEBUG - Attempting to find user with ID: " + id);
            stmt.setInt(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    User user = mapResultSetToUser(rs);
                    System.out.println("DEBUG - Found user: " + user);
                    return user;
                } else {
                    System.out.println("DEBUG - No user found with ID: " + id);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error finding user by ID " + id + ": " + e.getMessage());
            System.err.println("SQL State: " + e.getSQLState());
            System.err.println("Error Code: " + e.getErrorCode());
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
                           u.LastLogin, u.CreatedAt, u.Blocked
                    FROM users u
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
                           u.LastLogin, u.CreatedAt, u.Blocked
                    FROM users u
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
                   u.PhoneNumber, u.DateOfBirth, u.AvatarURL, u.LastLogin, u.CreatedAt, u.Blocked
            FROM users u
            ORDER BY u.CreatedAt DESC
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
        StringBuilder sql = new StringBuilder();

        if (roleName != null && !roleName.trim().isEmpty()) {
            // Include role filter
            sql.append("""
                SELECT u.UserID, u.Username, u.Email, u.PasswordHash, u.FirstName, u.LastName,
                       u.PhoneNumber, u.DateOfBirth, u.AvatarURL, u.LastLogin, u.CreatedAt, u.Blocked
                FROM users u
                INNER JOIN user_roles ur ON u.UserID = ur.UserID
                INNER JOIN roles r ON ur.RoleID = r.RoleID
                WHERE 1=1
            """);
        } else {
            // No role filter
            sql.append("""
                SELECT u.UserID, u.Username, u.Email, u.PasswordHash, u.FirstName, u.LastName,
                       u.PhoneNumber, u.DateOfBirth, u.AvatarURL, u.LastLogin, u.CreatedAt, u.Blocked
                FROM users u
                WHERE 1=1
            """);
        }

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
        StringBuilder sql = new StringBuilder();

        if (roleName != null && !roleName.trim().isEmpty()) {
            // Include role filter
            sql.append("""
                SELECT COUNT(*) 
                FROM users u 
                INNER JOIN user_roles ur ON u.UserID = ur.UserID 
                INNER JOIN roles r ON ur.RoleID = r.RoleID 
                WHERE 1=1
            """);
        } else {
            // No role filter
            sql.append("""
                SELECT COUNT(*) 
                FROM users u 
                WHERE 1=1
            """);
        }

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
        String sql = "UPDATE users SET Username = ?, Email = ?, FirstName = ?, LastName = ?, PhoneNumber = ?, DateOfBirth = ?, AvatarURL = ? WHERE UserID = ?";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            System.out.println("Executing update for user ID: " + user.getId());
            System.out.println("New values:");
            System.out.println("- Username: " + user.getUsername());
            System.out.println("- Email: " + user.getEmail());
            System.out.println("- FirstName: " + user.getFirstName());
            System.out.println("- LastName: " + user.getLastName());
            System.out.println("- PhoneNumber: " + user.getPhoneNumber());
            System.out.println("- DateOfBirth: " + user.getDateOfBirth());
            System.out.println("- AvatarURL: " + user.getAvatarUrl());

            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getFirstName());
            stmt.setString(4, user.getLastName());
            stmt.setString(5, user.getPhoneNumber());
            stmt.setObject(6, user.getDateOfBirth());
            stmt.setString(7, user.getAvatarUrl());
            stmt.setInt(8, user.getId());

            int rowsAffected = stmt.executeUpdate();
            System.out.println("Update result: " + rowsAffected + " rows affected");

            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error updating user in database: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean deleteUser(int userId) {
        String deleteEnrollmentsSql = "DELETE FROM enrollments WHERE student_id = ?";
        String deleteUserSql = "DELETE FROM users WHERE UserID = ?";
        String deleteFeedbacksSql = "DELETE FROM feedback WHERE UserID = ?";

        try (Connection conn = DatabaseConnection.getInstance().getConnection()) {
            conn.setAutoCommit(false); // Bắt đầu transaction

            try (PreparedStatement stmt1 = conn.prepareStatement(deleteEnrollmentsSql);
                 PreparedStatement stmt3 = conn.prepareStatement(deleteFeedbacksSql);
                 PreparedStatement stmt2 = conn.prepareStatement(deleteUserSql)) {


                // Xoá enrollments trước
                stmt1.setInt(1, userId);
                stmt3.setInt(1, userId);
                stmt1.executeUpdate();
                stmt3.executeUpdate();

                // Xoá user sau
                stmt2.setInt(1, userId);
                int rowsAffected = stmt2.executeUpdate();

                conn.commit(); // Commit nếu không có lỗi

                return rowsAffected > 0;
            } catch (SQLException e) {
                conn.rollback(); // rollback nếu lỗi
                System.err.println("Transaction rollback - Error deleting user: " + e.getMessage());
                return false;
            } finally {
                conn.setAutoCommit(true);
            }
        } catch (SQLException e) {
            System.err.println("Connection error: " + e.getMessage());
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
            user.setLastLoginDate(new java.util.Date(lastLoginTs.getTime()));
        }

        Timestamp createdAtTs = rs.getTimestamp("CreatedAt");
        if (createdAtTs != null) {
            user.setCreatedAt(createdAtTs.toInstant());
            user.setCreatedAtDate(new java.util.Date(createdAtTs.getTime()));
        }

        // Fix: set blocked status from DB
        try {
            int blockedValue = rs.getInt("Blocked");
            user.setBlocked(blockedValue == 1);
            System.out.println("[USER MAP] UserID=" + user.getId() + ", Blocked=" + blockedValue + ", mappedBlocked=" + user.isBlocked());
        } catch (SQLException e) {
            System.out.println("[USER MAP] Blocked column not found for UserID=" + user.getId());
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

    @Override
    public List<User> searchRecentActivities(String keyword, int limit, String role) {
        List<User> result = new ArrayList<>();
        String sql = "SELECT TOP (?) u.UserID, u.Username, u.Email, u.PasswordHash, u.FirstName, u.LastName, " +
                "u.PhoneNumber, u.DateOfBirth, u.AvatarURL, u.LastLogin, u.CreatedAt, r.RoleName " +
                "FROM users u " +
                "JOIN user_roles ur ON u.UserID = ur.UserID " +
                "JOIN roles r ON ur.RoleID = r.RoleID " +
                "WHERE (u.Username LIKE ? OR u.Email LIKE ? OR u.FirstName LIKE ? OR u.LastName LIKE ?) " +
                "AND LOWER(r.RoleName) = ? " +
                "ORDER BY u.LastLogin DESC";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            String searchPattern = "%" + keyword + "%";
            String roleName = role.toLowerCase();

            stmt.setInt(1, limit);
            stmt.setString(2, searchPattern);
            stmt.setString(3, searchPattern);
            stmt.setString(4, searchPattern);
            stmt.setString(5, searchPattern);
            stmt.setString(6, roleName);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                User user = mapResultSetToUserWithRole(rs);
                // Additional filtering for diacritics
                if (removeDiacritics(user.getFirstName().toLowerCase()).contains(removeDiacritics(keyword.toLowerCase())) ||
                        removeDiacritics(user.getLastName().toLowerCase()).contains(removeDiacritics(keyword.toLowerCase())) ||
                        user.getUsername().toLowerCase().contains(keyword.toLowerCase())) {
                    result.add(user);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    @Override
    public List<User> getRecentUsersByRole(int limit, String role) {
        List<User> result = new ArrayList<>();
        String sql = "SELECT TOP (?) u.UserID, u.Username, u.Email, u.PasswordHash, u.FirstName, u.LastName, " +
                "u.PhoneNumber, u.DateOfBirth, u.AvatarURL, u.LastLogin, u.CreatedAt, r.RoleName " +
                "FROM users u " +
                "JOIN user_roles ur ON u.UserID = ur.UserID " +
                "JOIN roles r ON ur.RoleID = r.RoleID " +
                "WHERE LOWER(r.RoleName) = ? " +
                "ORDER BY CASE WHEN u.LastLogin IS NULL THEN 1 ELSE 0 END, u.LastLogin DESC, u.CreatedAt DESC";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, limit);
            stmt.setString(2, role.toLowerCase());
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                User user = mapResultSetToUserWithRole(rs);
                result.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    // Helper method to map ResultSet to User with role information
    private User mapResultSetToUserWithRole(ResultSet rs) throws SQLException {
        User user = mapResultSetToUser(rs);
        // Set role information
        String roleName = rs.getString("RoleName");
        if (roleName != null) {
            // Role role = new Role();
            // role.setRoleName(roleName);
            // user.setRole(role); // Xóa dòng này vì User không có setRole
            // Nếu cần, có thể trả về roleName ngoài entity
        }
        return user;
    }

    // Helper method to remove diacritics from a string
    private String removeDiacritics(String str) {
        String nfdNormalizedString = Normalizer.normalize(str, Normalizer.Form.NFD);
        Pattern pattern = Pattern.compile("\\p{InCombiningDiacriticalMarks}+");
        return pattern.matcher(nfdNormalizedString).replaceAll("");
    }

    @Override
    public boolean blockUser(int userId) {
        String sql = "UPDATE users SET Blocked = 1 WHERE UserID = ?";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error blocking user: " + e.getMessage());
            return false;
        }
    }

    @Override
    public boolean unblockUser(int userId) {
        String sql = "UPDATE users SET Blocked = 0 WHERE UserID = ?";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error unblocking user: " + e.getMessage());
            return false;
        }
    }

    @Override
    public boolean createTeacher(User user) {
        boolean userCreated = createUser(user);
        if (!userCreated || user.getId() == null) {
            System.err.println("Failed to create user for teacher");
            return false;
        }

        String sql = "INSERT INTO user_roles (UserID, RoleID) SELECT ?, RoleID FROM roles WHERE RoleName = 'Teacher'";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, user.getId());
            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected == 0) {
                System.err.println("Failed to assign Teacher role to user ID: " + user.getId());
            }

            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error assigning Teacher role: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

}
