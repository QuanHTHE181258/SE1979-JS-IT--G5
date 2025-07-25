package project.demo.coursemanagement.dao.impl;

import project.demo.coursemanagement.dao.ProfileDAO;
import project.demo.coursemanagement.entities.User;
import project.demo.coursemanagement.entities.UserAvatar;
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
            SELECT u.UserID, u.Username, u.Email, u.PasswordHash, u.FirstName, u.LastName,
                   u.PhoneNumber, u.DateOfBirth, u.AvatarURL, u.LastLogin, u.CreatedAt,
                   r.RoleID, r.RoleName
            FROM users u
            INNER JOIN user_roles ur ON u.UserID = ur.UserID
            INNER JOIN roles r ON ur.RoleID = r.RoleID
            WHERE u.UserID = ?
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
        StringBuilder sql = new StringBuilder("UPDATE users SET ");
        List<Object> params = new ArrayList<>();
        boolean first = true;

        // Build dynamic update query based on provided fields
        if (updateRequest.getUsername() != null) {
            sql.append("Username = ?");
            params.add(updateRequest.getUsername());
            first = false;
        }

        if (updateRequest.getEmail() != null) {
            if (!first) sql.append(", ");
            sql.append("Email = ?");
            params.add(updateRequest.getEmail());
            first = false;
        }

        if (updateRequest.getFirstName() != null) {
            if (!first) sql.append(", ");
            sql.append("FirstName = ?");
            params.add(updateRequest.getFirstName());
            first = false;
        }

        if (updateRequest.getLastName() != null) {
            if (!first) sql.append(", ");
            sql.append("LastName = ?");
            params.add(updateRequest.getLastName());
            first = false;
        }

        if (updateRequest.getPhone() != null) {
            if (!first) sql.append(", ");
            sql.append("PhoneNumber = ?");
            params.add(updateRequest.getPhone().isEmpty() ? null : updateRequest.getPhone());
            first = false;
        }



        if (updateRequest.getDateOfBirth() != null) {
            if (!first) sql.append(", ");
            sql.append("DateOfBirth = ?");

            LocalDate dob = updateRequest.getParsedDateOfBirth();
            if (dob != null) {
                params.add(Date.valueOf(dob));
            } else {
                params.add(null);
            }
            first = false;
        }

        sql.append(" WHERE UserID = ?");
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
        String sql = "UPDATE users SET PasswordHash = ? WHERE UserID = ?";

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
    public boolean removeAvatar(Integer userId) {
        String sql = "UPDATE users SET AvatarURL = NULL WHERE UserID = ?";

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
    public boolean saveUserAvatar(UserAvatar userAvatar) {
        String sql = """
            INSERT INTO user_avatars (UserID, ImageURL, IsDefault, UploadedAt)
            VALUES (?, ?, ?, GETDATE())
        """;

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setInt(1, userAvatar.getUserID().getId());
            stmt.setString(2, userAvatar.getImageURL());
            stmt.setBoolean(3, userAvatar.getIsDefault() != null ? userAvatar.getIsDefault() : false);

            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        userAvatar.setId(rs.getInt(1));
                        return true;
                    }
                }
            }

        } catch (SQLException e) {
            System.err.println("Error saving user avatar: " + e.getMessage());
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public List<UserAvatar> getUserAvatars(Integer userId) {
        String sql = """
            SELECT AvatarID, UserID, ImageURL, IsDefault, UploadedAt
            FROM user_avatars
            WHERE UserID = ?
            ORDER BY UploadedAt DESC
        """;

        List<UserAvatar> avatars = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    avatars.add(mapResultSetToUserAvatar(rs));
                }
            }

        } catch (SQLException e) {
            System.err.println("Error getting user avatars: " + e.getMessage());
            e.printStackTrace();
        }

        return avatars;
    }

    @Override
    public boolean setDefaultUserAvatar(Integer userId, Integer avatarId) {
        Connection conn = null;

        try {
            conn = DatabaseConnection.getInstance().getConnection();
            conn.setAutoCommit(false);

            // First, unset all current defaults
            String unsetSql = "UPDATE user_avatars SET IsDefault = 0 WHERE UserID = ?";
            try (PreparedStatement stmt = conn.prepareStatement(unsetSql)) {
                stmt.setInt(1, userId);
                stmt.executeUpdate();
            }

            // Then set the new default
            String setSql = "UPDATE user_avatars SET IsDefault = 1 WHERE AvatarID = ? AND UserID = ?";
            try (PreparedStatement stmt = conn.prepareStatement(setSql)) {
                stmt.setInt(1, avatarId);
                stmt.setInt(2, userId);
                stmt.executeUpdate();
            }

            // Update user's avatar URL
            String getAvatarUrlSql = "SELECT ImageURL FROM user_avatars WHERE AvatarID = ?";
            String avatarUrl = null;
            try (PreparedStatement stmt = conn.prepareStatement(getAvatarUrlSql)) {
                stmt.setInt(1, avatarId);
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        avatarUrl = rs.getString("ImageURL");
                    }
                }
            }

            if (avatarUrl != null) {
                String updateUserSql = "UPDATE users SET AvatarURL = ? WHERE UserID = ?";
                try (PreparedStatement stmt = conn.prepareStatement(updateUserSql)) {
                    stmt.setString(1, avatarUrl);
                    stmt.setInt(2, userId);
                    stmt.executeUpdate();
                }
            }

            conn.commit();
            return true;

        } catch (SQLException e) {
            System.err.println("Error setting default user avatar: " + e.getMessage());
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
    public boolean isUsernameExistsForOthers(String username, Integer excludeUserId) {
        String sql = "SELECT COUNT(*) FROM users WHERE Username = ? AND UserID != ?";

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
        String sql = "SELECT COUNT(*) FROM users WHERE Email = ? AND UserID != ?";

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
    public int getProfileCompletionPercentage(Integer userId) {
        String sql = """
            SELECT Username, Email, FirstName, LastName, PhoneNumber, DateOfBirth, 
                   AvatarURL
            FROM users
            WHERE UserID = ?
        """;

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    int totalFields = 7;
                    int completedFields = 0;

                    if (rs.getString("Username") != null) completedFields++;
                    if (rs.getString("Email") != null) completedFields++;
                    if (rs.getString("FirstName") != null) completedFields++;
                    if (rs.getString("LastName") != null) completedFields++;
                    if (rs.getString("PhoneNumber") != null) completedFields++;
                    if (rs.getDate("DateOfBirth") != null) completedFields++;
                    if (rs.getString("AvatarURL") != null) completedFields++;

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

        user.setAvatarUrl(rs.getString("AvatarURL"));

        Timestamp lastLogin = rs.getTimestamp("LastLogin");
        if (lastLogin != null) {
            user.setLastLogin(lastLogin.toInstant());
        }

        Timestamp createdAt = rs.getTimestamp("CreatedAt");
        if (createdAt != null) {
            user.setCreatedAt(createdAt.toInstant());
        }

        return user;
    }

    // Helper method to map ResultSet to UserAvatar entity
    private UserAvatar mapResultSetToUserAvatar(ResultSet rs) throws SQLException {
        UserAvatar avatar = new UserAvatar();
        avatar.setId(rs.getInt("AvatarID"));

        // Create a User object with just the ID
        User user = new User();
        user.setId(rs.getInt("UserID"));
        avatar.setUserID(user);

        avatar.setImageURL(rs.getString("ImageURL"));
        avatar.setIsDefault(rs.getBoolean("IsDefault"));

        Timestamp uploadedAt = rs.getTimestamp("UploadedAt");
        if (uploadedAt != null) {
            avatar.setUploadedAt(uploadedAt.toInstant());
        }

        return avatar;
    }


    @Override
    public List<EnrollmentSummary> getRecentEnrollments(Integer userId, int limit) {
        String sql = """
        SELECT TOP (?) e.enrollment_id, e.course_id, c.Title as course_title, 
               e.status, e.progress_percentage, e.grade, e.certificate_issued,
               e.enrollment_date, e.completion_date
        FROM enrollments e
        INNER JOIN courses c ON e.course_id = c.CourseID
        WHERE e.student_id = ?
        ORDER BY e.enrollment_date DESC
    """;

        List<EnrollmentSummary> enrollments = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, limit);
            stmt.setInt(2, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    enrollments.add(mapResultSetToEnrollmentSummary(rs));
                }
            }

        } catch (SQLException e) {
            System.err.println("Error getting recent enrollments: " + e.getMessage());
            e.printStackTrace();
        }

        return enrollments;
    }


    @Override
    public int getEnrolledCoursesCount(Integer userId) {
        String sql = "SELECT COUNT(*) FROM enrollments WHERE student_id = ? AND status = 'ACTIVE'";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }

        } catch (SQLException e) {
            System.err.println("Error getting enrolled courses count: " + e.getMessage());
            e.printStackTrace();
        }

        return 0;
    }

    @Override
    public int getCompletedCoursesCount(Integer userId) {
        String sql = "SELECT COUNT(*) FROM enrollments WHERE student_id = ? AND status = 'COMPLETED'";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }

        } catch (SQLException e) {
            System.err.println("Error getting completed courses count: " + e.getMessage());
            e.printStackTrace();
        }

        return 0;
    }

    @Override
    public int getCertificatesIssuedCount(Integer userId) {
        String sql = "SELECT COUNT(*) FROM enrollments WHERE student_id = ? AND certificate_issued = 1";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }

        } catch (SQLException e) {
            System.err.println("Error getting certificates count: " + e.getMessage());
            e.printStackTrace();
        }

        return 0;
    }

    // Helper method to map ResultSet to EnrollmentSummary
    private EnrollmentSummary mapResultSetToEnrollmentSummary(ResultSet rs) throws SQLException {
        EnrollmentSummary summary = new EnrollmentSummary();
        summary.setEnrollmentId(rs.getInt("enrollment_id"));
        summary.setCourseId(rs.getInt("course_id"));
        summary.setCourseTitle(rs.getString("course_title"));
        summary.setStatus(rs.getString("status"));
        summary.setProgressPercentage(rs.getBigDecimal("progress_percentage"));
        summary.setGrade(rs.getBigDecimal("grade"));
        summary.setCertificateIssued(rs.getBoolean("certificate_issued"));

        Timestamp enrollmentDate = rs.getTimestamp("enrollment_date");
        if (enrollmentDate != null) {
            summary.setEnrollmentDate(enrollmentDate.toInstant());
        }

        Timestamp completionDate = rs.getTimestamp("completion_date");
        if (completionDate != null) {
            summary.setCompletionDate(completionDate.toInstant());
        }

        return summary;
    }
}