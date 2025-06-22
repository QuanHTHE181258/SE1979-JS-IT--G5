package project.demo.coursemanagement.dao;

import project.demo.coursemanagement.entities.User;
import project.demo.coursemanagement.entities.UserAvatar;
import project.demo.coursemanagement.dto.ProfileUpdateRequest;

import java.util.List;

/**
 * Data Access Object interface for profile management
 */
public interface ProfileDAO {

    User getUserProfile(Integer userId);

    boolean updateProfile(ProfileUpdateRequest updateRequest);

    boolean updatePassword(Integer userId, String newPasswordHash);

    boolean updateAvatarUrl(Integer userId, String avatarUrl);

    boolean removeAvatar(Integer userId);

    boolean saveUserAvatar(UserAvatar userAvatar);

    List<UserAvatar> getUserAvatars(Integer userId);

    UserAvatar getDefaultUserAvatar(Integer userId);

    boolean setDefaultUserAvatar(Integer userId, Integer avatarId);

    boolean deleteUserAvatar(Integer avatarId);

    boolean isUsernameExistsForOthers(String username, Integer excludeUserId);

    boolean isEmailExistsForOthers(String email, Integer excludeUserId);

    String getUserPasswordHash(Integer userId);

    boolean updateLastUpdatedTime(Integer userId);

    int getProfileCompletionPercentage(Integer userId);

    boolean logProfileActivity(Integer userId, String activityType, String details);

    List<ProfileActivity> getRecentProfileActivities(Integer userId, int limit);

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
