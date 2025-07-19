package project.demo.coursemanagement.dao;

import project.demo.coursemanagement.entities.User;
import project.demo.coursemanagement.entities.UserAvatar;
import project.demo.coursemanagement.dto.ProfileUpdateRequest;

import java.util.List;

/**
 * Data Access Object interface for profile management
 */
public interface ProfileDAO {

    /**
     * Get user profile by ID
     */
    User getUserProfile(Integer userId);

    /**
     * Update user profile
     */
    boolean updateProfile(ProfileUpdateRequest updateRequest);

    /**
     * Update user password
     */
    boolean updatePassword(Integer userId, String newPasswordHash);

    /**
     * Update user avatar URL
     */
    boolean updateAvatarUrl(Integer userId, String avatarUrl);

    /**
     * Remove user avatar
     */
    boolean removeAvatar(Integer userId);

    /**
     * Save user avatar record
     */
    boolean saveUserAvatar(UserAvatar userAvatar);

    /**
     * Get user avatars
     */
    List<UserAvatar> getUserAvatars(Integer userId);

    /**
     * Get default user avatar
     */
    UserAvatar getDefaultUserAvatar(Integer userId);

    /**
     * Set default user avatar
     */
    boolean setDefaultUserAvatar(Integer userId, Integer avatarId);

    /**
     * Delete user avatar
     */
    boolean deleteUserAvatar(Integer avatarId);

    /**
     * Check if username exists for other users
     */
    boolean isUsernameExistsForOthers(String username, Integer excludeUserId);

    /**
     * Check if email exists for other users
     */
    boolean isEmailExistsForOthers(String email, Integer excludeUserId);

    /**
     * Get user's current password hash
     */
    String getUserPasswordHash(Integer userId);

    /**
     * Update user's last updated timestamp
     */
    boolean updateLastUpdatedTime(Integer userId);

    /**
     * Get profile completion percentage
     */
    int getProfileCompletionPercentage(Integer userId);

    /**
     * Log profile update activity
     */
    boolean logProfileActivity(Integer userId, String activityType, String details);

    /**
     * Get recent profile activities
     */
    List<ProfileActivity> getRecentProfileActivities(Integer userId, int limit);

    /**
     * Inner class for profile activity
     */
    class ProfileActivity {
        private Integer activityId;
        private Integer userId;
        private String activityType;
        private String details;
        private java.time.Instant activityTime;

        // Constructors
        public ProfileActivity() {}

        public ProfileActivity(Integer userId, String activityType, String details) {
            this.userId = userId;
            this.activityType = activityType;
            this.details = details;
            this.activityTime = java.time.Instant.now();
        }

        // Getters and setters
        public Integer getActivityId() { return activityId; }
        public void setActivityId(Integer activityId) { this.activityId = activityId; }

        public Integer getUserId() { return userId; }
        public void setUserId(Integer userId) { this.userId = userId; }

        public String getActivityType() { return activityType; }
        public void setActivityType(String activityType) { this.activityType = activityType; }

        public String getDetails() { return details; }
        public void setDetails(String details) { this.details = details; }

        public java.time.Instant getActivityTime() { return activityTime; }
        public void setActivityTime(java.time.Instant activityTime) { this.activityTime = activityTime; }
    }
}
