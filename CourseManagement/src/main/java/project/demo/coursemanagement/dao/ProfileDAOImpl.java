package project.demo.coursemanagement.dao;

import project.demo.coursemanagement.entities.User;
import project.demo.coursemanagement.entities.UserImage;
import project.demo.coursemanagement.entities.Role;
import project.demo.coursemanagement.dto.ProfileUpdateRequest;
import project.demo.coursemanagement.utils.DatabaseConnection;

import java.sql.*;
import java.time.Instant;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;


public class ProfileDAOImpl implements ProfileDAO {

    @Override
    public User getUserProfile(Integer userId) {
        String sql = """
            SELECT u.user_id, u.username, u.email, u.password_hash, u.first_name, u.last_name,
                   u.phone, u.date_of_birth, u.avatar_url, u.is_active, u.email_verified,
                   u.last_login, u.created_at, u.updated_at,
                   r.role_id, r.role_name, r.description,
                   ui.image_id, ui.image_path
            FROM Users u
            INNER JOIN Roles r ON u.role_id = r.role_id
            LEFT JOIN UserImages ui ON u.current_avatar_id = ui.image_id
            WHERE u.user_id = ?
        """;

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUser(rs);
                }
            }

        } catch (SQLException e) {
            System.err.println("Error getting user profile: " + e.getMessage());
            e.printStackTrace();
        }

        return null;
    }

    @Override
    public boolean updateProfile(ProfileUpdateRequest updateRequest) {
        StringBuilder sql = new StringBuilder("UPDATE Users SET ");
        List<Object> params = new ArrayList<>();
        boolean first = true;

        // Build dynamic update query based on provided fields
        if (updateRequest.getUsername() != null) {
            sql.append("username = ?");
            params.add(updateRequest.getUsername());
            first = false;
        }

        if (updateRequest.getEmail() != null) {
            if (!first) sql.append(", ");
            sql.append("email = ?");
            params.add(updateRequest.getEmail());
            first = false;
        }

        if (updateRequest.getFirstName() != null) {
            if (!first) sql.append(", ");
            sql.append("first_name = ?");
            params.add(updateRequest.getFirstName());
            first = false;
        }

        if (updateRequest.getLastName() != null) {
            if (!first) sql.append(", ");
            sql.append("last_name = ?");
            params.add(updateRequest.getLastName());
            first = false;
        }

        if (updateRequest.getPhone() != null) {
            if (!first) sql.append(", ");
            sql.append("phone = ?");
            params.add(updateRequest.getPhone().isEmpty() ? null : updateRequest.getPhone());
            first = false;
        }



        if (updateRequest.getDateOfBirth() != null) {
            if (!first) sql.append(", ");
            sql.append("date_of_birth = ?");

            LocalDate dob = updateRequest.getParsedDateOfBirth();
            if (dob != null) {
                params.add(Date.valueOf(dob));
            } else {
                params.add(null);
            }
            first = false;
        }

        // Always update the updated_at timestamp
        if (!first) sql.append(", ");
        sql.append("updated_at = GETDATE()");

        sql.append(" WHERE user_id = ?");
        params.add(updateRequest.getUserId());

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql.toString())) {

            // Set parameters
            for (int i = 0; i < params.size(); i++) {
                if (params.get(i) == null) {
                    stmt.setNull(i + 1, Types.VARCHAR);
                } else if (params.get(i) instanceof Date) {
                    stmt.setDate(i + 1, (Date) params.get(i));
                } else {
                    stmt.setObject(i + 1, params.get(i));
                }
            }

            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                // Log the activity
                logProfileActivity(updateRequest.getUserId(), "PROFILE_UPDATE",
                        "Profile information updated");
                return true;
            }

        } catch (SQLException e) {
            System.err.println("Error updating profile: " + e.getMessage());
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public boolean updatePassword(Integer userId, String newPasswordHash) {
        String sql = "UPDATE Users SET password_hash = ?, updated_at = GETDATE() WHERE user_id = ?";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, newPasswordHash);
            stmt.setInt(2, userId);

            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                logProfileActivity(userId, "PASSWORD_CHANGE", "Password changed successfully");
                return true;
            }

        } catch (SQLException e) {
            System.err.println("Error updating password: " + e.getMessage());
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public boolean updateAvatarUrl(Integer userId, String avatarUrl) {
        String sql = "UPDATE Users SET avatar_url = ?, updated_at = GETDATE() WHERE user_id = ?";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, avatarUrl);
            stmt.setInt(2, userId);

            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                logProfileActivity(userId, "AVATAR_UPDATE", "Avatar image updated");
                return true;
            }

        } catch (SQLException e) {
            System.err.println("Error updating avatar URL: " + e.getMessage());
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public boolean removeAvatar(Integer userId) {
        String sql = "UPDATE Users SET avatar_url = NULL, current_avatar_id = NULL, updated_at = GETDATE() WHERE user_id = ?";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);

            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                logProfileActivity(userId, "AVATAR_REMOVE", "Avatar image removed");
                return true;
            }

        } catch (SQLException e) {
            System.err.println("Error removing avatar: " + e.getMessage());
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public boolean saveUserImage(UserImage userImage) {
        String sql = """
            INSERT INTO UserImages (user_id, image_name, image_path, image_size, image_type, is_default, upload_date)
            VALUES (?, ?, ?, ?, ?, ?, GETDATE())
        """;

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setInt(1, userImage.getUser().getId());
            stmt.setString(2, userImage.getImageName());
            stmt.setString(3, userImage.getImagePath());
            stmt.setLong(4, userImage.getImageSize() != null ? userImage.getImageSize() : 0);
            stmt.setString(5, userImage.getImageType());
            stmt.setBoolean(6, userImage.getIsDefault() != null ? userImage.getIsDefault() : false);

            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        userImage.setId(rs.getInt(1));
                        return true;
                    }
                }
            }

        } catch (SQLException e) {
            System.err.println("Error saving user image: " + e.getMessage());
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public List<UserImage> getUserImages(Integer userId) {
        String sql = """
            SELECT image_id, user_id, image_name, image_path, image_size, image_type, is_default, upload_date
            FROM UserImages
            WHERE user_id = ?
            ORDER BY upload_date DESC
        """;

        List<UserImage> images = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    images.add(mapResultSetToUserImage(rs));
                }
            }

        } catch (SQLException e) {
            System.err.println("Error getting user images: " + e.getMessage());
            e.printStackTrace();
        }

        return images;
    }

    @Override
    public UserImage getDefaultUserImage(Integer userId) {
        String sql = """
            SELECT image_id, user_id, image_name, image_path, image_size, image_type, is_default, upload_date
            FROM UserImages
            WHERE user_id = ? AND is_default = 1
        """;

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUserImage(rs);
                }
            }

        } catch (SQLException e) {
            System.err.println("Error getting default user image: " + e.getMessage());
            e.printStackTrace();
        }

        return null;
    }

    @Override
    public boolean setDefaultUserImage(Integer userId, Integer imageId) {
        Connection conn = null;

        try {
            conn = DatabaseConnection.getInstance().getConnection();
            conn.setAutoCommit(false);

            // First, unset all current defaults
            String unsetSql = "UPDATE UserImages SET is_default = 0 WHERE user_id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(unsetSql)) {
                stmt.setInt(1, userId);
                stmt.executeUpdate();
            }

            // Then set the new default
            String setSql = "UPDATE UserImages SET is_default = 1 WHERE image_id = ? AND user_id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(setSql)) {
                stmt.setInt(1, imageId);
                stmt.setInt(2, userId);
                stmt.executeUpdate();
            }

            // Update user's current avatar
            String updateUserSql = "UPDATE Users SET current_avatar_id = ? WHERE user_id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(updateUserSql)) {
                stmt.setInt(1, imageId);
                stmt.setInt(2, userId);
                stmt.executeUpdate();
            }

            conn.commit();
            return true;

        } catch (SQLException e) {
            System.err.println("Error setting default user image: " + e.getMessage());
            e.printStackTrace();

            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    System.err.println("Error rolling back transaction: " + ex.getMessage());
                }
            }
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) {
                    System.err.println("Error closing connection: " + e.getMessage());
                }
            }
        }

        return false;
    }

    @Override
    public boolean deleteUserImage(Integer imageId) {
        String sql = "DELETE FROM UserImages WHERE image_id = ?";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, imageId);

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Error deleting user image: " + e.getMessage());
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public boolean isUsernameExistsForOthers(String username, Integer excludeUserId) {
        String sql = "SELECT COUNT(*) FROM Users WHERE username = ? AND user_id != ?";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);
            stmt.setInt(2, excludeUserId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }

        } catch (SQLException e) {
            System.err.println("Error checking username existence: " + e.getMessage());
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public boolean isEmailExistsForOthers(String email, Integer excludeUserId) {
        String sql = "SELECT COUNT(*) FROM Users WHERE email = ? AND user_id != ?";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);
            stmt.setInt(2, excludeUserId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }

        } catch (SQLException e) {
            System.err.println("Error checking email existence: " + e.getMessage());
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public String getUserPasswordHash(Integer userId) {
        String sql = "SELECT password_hash FROM Users WHERE user_id = ?";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("password_hash");
                }
            }

        } catch (SQLException e) {
            System.err.println("Error getting user password hash: " + e.getMessage());
            e.printStackTrace();
        }

        return null;
    }

    @Override
    public boolean updateLastUpdatedTime(Integer userId) {
        String sql = "UPDATE Users SET updated_at = GETDATE() WHERE user_id = ?";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Error updating last updated time: " + e.getMessage());
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public int getProfileCompletionPercentage(Integer userId) {
        String sql = """
            SELECT username, email, first_name, last_name, phone, date_of_birth, 
                   avatar_url, email_verified
            FROM Users
            WHERE user_id = ?
        """;

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    int totalFields = 8;
                    int completedFields = 0;

                    if (rs.getString("username") != null) completedFields++;
                    if (rs.getString("email") != null) completedFields++;
                    if (rs.getString("first_name") != null) completedFields++;
                    if (rs.getString("last_name") != null) completedFields++;
                    if (rs.getString("phone") != null) completedFields++;
                    if (rs.getDate("date_of_birth") != null) completedFields++;
                    if (rs.getString("avatar_url") != null) completedFields++;
                    if (rs.getBoolean("email_verified")) completedFields++;

                    return (completedFields * 100) / totalFields;
                }
            }

        } catch (SQLException e) {
            System.err.println("Error calculating profile completion: " + e.getMessage());
            e.printStackTrace();
        }

        return 0;
    }

    @Override
    public boolean logProfileActivity(Integer userId, String activityType, String details) {
        // In a real implementation, this would insert into a ProfileActivities table
        System.out.println("Profile Activity Log:");
        System.out.println("  User ID: " + userId);
        System.out.println("  Type: " + activityType);
        System.out.println("  Details: " + details);
        System.out.println("  Timestamp: " + Instant.now());

        return true; // Simulated success
    }

    @Override
    public List<ProfileActivity> getRecentProfileActivities(Integer userId, int limit) {
        // In a real implementation, this would query a ProfileActivities table
        List<ProfileActivity> activities = new ArrayList<>();

        // Return empty list for now (would be populated from database)
        return activities;
    }

    // Helper method to map ResultSet to User entity
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

        user.setAvatarUrl(rs.getString("avatar_url"));
        user.setIsActive(rs.getBoolean("is_active"));
        user.setEmailVerified(rs.getBoolean("email_verified"));

        Timestamp lastLogin = rs.getTimestamp("last_login");
        if (lastLogin != null) {
            user.setLastLogin(lastLogin.toInstant());
        }

        Timestamp createdAt = rs.getTimestamp("created_at");
        if (createdAt != null) {
            user.setCreatedAt(createdAt.toInstant());
        }

        Timestamp updatedAt = rs.getTimestamp("updated_at");
        if (updatedAt != null) {
            user.setUpdatedAt(updatedAt.toInstant());
        }

        // Map Role
        Role role = new Role();
        role.setId(rs.getInt("role_id"));
        role.setRoleName(rs.getString("role_name"));
        role.setDescription(rs.getString("description"));
        user.setRole(role);

        // Map current avatar if exists
        int imageId = rs.getInt("image_id");
        if (!rs.wasNull()) {
            UserImage avatar = new UserImage();
            avatar.setId(imageId);
            avatar.setImagePath(rs.getString("image_path"));
            user.setCurrentAvatar(avatar);
        }

        return user;
    }

    // Helper method to map ResultSet to UserImage entity
    private UserImage mapResultSetToUserImage(ResultSet rs) throws SQLException {
        UserImage image = new UserImage();
        image.setId(rs.getInt("image_id"));
        image.setImageName(rs.getString("image_name"));
        image.setImagePath(rs.getString("image_path"));
        image.setImageSize(rs.getLong("image_size"));
        image.setImageType(rs.getString("image_type"));
        image.setIsDefault(rs.getBoolean("is_default"));

        Timestamp uploadDate = rs.getTimestamp("upload_date");
        if (uploadDate != null) {
            image.setUploadDate(uploadDate.toInstant());
        }

        // Note: We don't set the User object here to avoid circular references
        // The caller should set it if needed

        return image;
    }
}