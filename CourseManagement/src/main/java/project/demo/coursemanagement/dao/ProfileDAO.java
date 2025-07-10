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

    boolean removeAvatar(Integer userId);

    boolean saveUserAvatar(UserAvatar userAvatar);

    List<UserAvatar> getUserAvatars(Integer userId);


    boolean setDefaultUserAvatar(Integer userId, Integer avatarId);

    boolean isUsernameExistsForOthers(String username, Integer excludeUserId);

    boolean isEmailExistsForOthers(String email, Integer excludeUserId);

    int getProfileCompletionPercentage(Integer userId);

    boolean logProfileActivity(Integer userId, String activityType, String details);

    List<ProfileActivity> getRecentProfileActivities(Integer userId, int limit);

    // New methods for enrollment statistics
    int getEnrolledCoursesCount(Integer userId);

    int getCompletedCoursesCount(Integer userId);

    int getCertificatesIssuedCount(Integer userId);

    List<EnrollmentSummary> getRecentEnrollments(Integer userId, int limit);

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

    class EnrollmentSummary {
        private Integer enrollmentId;
        private Integer courseId;
        private String courseTitle;
        private String status;
        private java.math.BigDecimal progressPercentage;
        private java.math.BigDecimal grade;
        private boolean certificateIssued;
        private java.time.Instant enrollmentDate;
        private java.time.Instant completionDate;

        // Constructors
        public EnrollmentSummary() {}

        public EnrollmentSummary(Integer enrollmentId, Integer courseId, String courseTitle,
                                 String status, java.math.BigDecimal progressPercentage,
                                 java.math.BigDecimal grade, boolean certificateIssued,
                                 java.time.Instant enrollmentDate, java.time.Instant completionDate) {
            this.enrollmentId = enrollmentId;
            this.courseId = courseId;
            this.courseTitle = courseTitle;
            this.status = status;
            this.progressPercentage = progressPercentage;
            this.grade = grade;
            this.certificateIssued = certificateIssued;
            this.enrollmentDate = enrollmentDate;
            this.completionDate = completionDate;
        }

        // Getters and setters
        public Integer getEnrollmentId() { return enrollmentId; }
        public void setEnrollmentId(Integer enrollmentId) { this.enrollmentId = enrollmentId; }

        public Integer getCourseId() { return courseId; }
        public void setCourseId(Integer courseId) { this.courseId = courseId; }

        public String getCourseTitle() { return courseTitle; }
        public void setCourseTitle(String courseTitle) { this.courseTitle = courseTitle; }

        public String getStatus() { return status; }
        public void setStatus(String status) { this.status = status; }

        public java.math.BigDecimal getProgressPercentage() { return progressPercentage; }
        public void setProgressPercentage(java.math.BigDecimal progressPercentage) { this.progressPercentage = progressPercentage; }

        public java.math.BigDecimal getGrade() { return grade; }
        public void setGrade(java.math.BigDecimal grade) { this.grade = grade; }

        public boolean isCertificateIssued() { return certificateIssued; }
        public void setCertificateIssued(boolean certificateIssued) { this.certificateIssued = certificateIssued; }

        public java.time.Instant getEnrollmentDate() { return enrollmentDate; }
        public void setEnrollmentDate(java.time.Instant enrollmentDate) { this.enrollmentDate = enrollmentDate; }

        public java.time.Instant getCompletionDate() { return completionDate; }
        public void setCompletionDate(java.time.Instant completionDate) { this.completionDate = completionDate; }
    }
}