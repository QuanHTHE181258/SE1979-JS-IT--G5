package project.demo.coursemanagement.service;

import project.demo.coursemanagement.dao.ProfileDAO;
import project.demo.coursemanagement.dao.impl.ProfileDAOImpl;
import project.demo.coursemanagement.dao.UserDAO;
import project.demo.coursemanagement.entities.User;
import project.demo.coursemanagement.entities.UserAvatar;
import project.demo.coursemanagement.dto.ProfileUpdateRequest;
import project.demo.coursemanagement.dto.ValidationResult;
import project.demo.coursemanagement.utils.PasswordUtil;
import project.demo.coursemanagement.utils.ValidationUtil;

import jakarta.servlet.http.Part;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.time.Instant;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

/**
 * Service class for profile management
 */
public class ProfileService {

    private ProfileDAO profileDAO;
    private UserDAO userDAO;
    private static final String UPLOAD_DIR = "assets/avatar";
    private static final long MAX_FILE_SIZE = 5 * 1024 * 1024; // 5MB
    private String webappPath;

    public ProfileService() {
        this.profileDAO = new ProfileDAOImpl();
        this.userDAO = new UserDAOImpl();
    }

    /**
     * Constructor with webapp path for proper file uploads
     */
    public ProfileService(String webappPath) {
        this.profileDAO = new ProfileDAOImpl();
        this.userDAO = new UserDAOImpl();
        this.webappPath = webappPath;
    }

    /**
     * Constructor with dependency injection for testing
     */
    public ProfileService(ProfileDAO profileDAO) {
        this.profileDAO = profileDAO;
        this.userDAO = new UserDAOImpl();
    }

    /**
     * Get user profile by ID
     */
    public User getUserProfile(Integer userId) {
        if (userId == null) {
            return null;
        }

        try {
            return profileDAO.getUserProfile(userId);
        } catch (Exception e) {
            System.err.println("Error getting user profile: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    /**
     * Get user by ID (using UserDAO)
     */
    public User getUserById(Integer userId) {
        if (userId == null) {
            return null;
        }

        try {
            return userDAO.findUserById(userId);
        } catch (Exception e) {
            System.err.println("Error getting user by ID: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    /**
     * Validate profile update request
     */
    public ValidationResult validateProfileUpdate(ProfileUpdateRequest request) {
        List<String> errors = new ArrayList<>();

        if (request == null || request.getUserId() == null) {
            errors.add("Invalid update request");
            return new ValidationResult(false, errors);
        }

        // Validate username if provided
        if (request.getUsername() != null) {
            ValidationUtil.validateUsername(request.getUsername(), errors);

            // Check if username already exists for other users
            if (errors.isEmpty() && profileDAO.isUsernameExistsForOthers(request.getUsername(), request.getUserId())) {
                errors.add("Username '" + request.getUsername() + "' is already taken");
            }
        }

        // Validate email if provided
        if (request.getEmail() != null) {
            ValidationUtil.validateEmail(request.getEmail(), errors);

            // Check if email already exists for other users
            if (errors.isEmpty() && profileDAO.isEmailExistsForOthers(request.getEmail(), request.getUserId())) {
                errors.add("Email '" + request.getEmail() + "' is already registered");
            }
        }

        // Validate first name if provided
        if (request.getFirstName() != null) {
            ValidationUtil.validateFirstName(request.getFirstName(), errors);
        }

        // Validate last name if provided
        if (request.getLastName() != null) {
            ValidationUtil.validateLastName(request.getLastName(), errors);
        }

        // Validate phone if provided
        if (request.getPhone() != null && !request.getPhone().isEmpty()) {
            ValidationUtil.validatePhone(request.getPhone(), errors);
        }

        // Validate date of birth if provided
        if (request.getDateOfBirth() != null && !request.getDateOfBirth().isEmpty()) {
            ValidationUtil.validateDateOfBirth(request.getDateOfBirth(), errors);
        }

        boolean isValid = errors.isEmpty();
        return new ValidationResult(isValid, errors);
    }

    /**
     * Validate profile update request (without ProfileDAO validation)
     */
    public ValidationResult validateProfileUpdateSimple(ProfileUpdateRequest request) {
        List<String> errors = new ArrayList<>();

        if (request == null || request.getUserId() == null) {
            errors.add("Invalid update request");
            return new ValidationResult(false, errors);
        }

        // Basic validation without database checks
        if (request.getUsername() != null) {
            ValidationUtil.validateUsername(request.getUsername(), errors);
        }

        if (request.getEmail() != null) {
            ValidationUtil.validateEmail(request.getEmail(), errors);
        }

        if (request.getFirstName() != null) {
            ValidationUtil.validateFirstName(request.getFirstName(), errors);
        }

        if (request.getLastName() != null) {
            ValidationUtil.validateLastName(request.getLastName(), errors);
        }

        if (request.getPhone() != null && !request.getPhone().isEmpty()) {
            ValidationUtil.validatePhone(request.getPhone(), errors);
        }

        if (request.getDateOfBirth() != null && !request.getDateOfBirth().isEmpty()) {
            ValidationUtil.validateDateOfBirth(request.getDateOfBirth(), errors);
        }

        boolean isValid = errors.isEmpty();
        return new ValidationResult(isValid, errors);
    }

    /**
     * Update user profile
     */
    public boolean updateProfile(ProfileUpdateRequest request) {
        if (request == null || request.getUserId() == null) {
            return false;
        }

        try {
            System.out.println("ProfileService: Updating profile for user ID: " + request.getUserId());

            // Perform the update
            boolean success = profileDAO.updateProfile(request);

            if (success) {
                System.out.println("ProfileService: Profile updated successfully");
            } else {
                System.err.println("ProfileService: Profile update failed");
            }

            return success;

        } catch (Exception e) {
            System.err.println("ProfileService: Error updating profile: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Validate and change password
     */
    public boolean validateAndChangePassword(Integer userId, String currentPassword, String newPassword) {
        if (userId == null || currentPassword == null || newPassword == null) {
            return false;
        }

        try {
            // Get user to verify current password
            User user = userDAO.findUserByIdIncludeInactive(userId);
            if (user == null) {
                System.err.println("ProfileService: User not found for password change");
                return false;
            }

            // Verify current password
            if (!PasswordUtil.verifyPassword(currentPassword, user.getPasswordHash())) {
                System.err.println("ProfileService: Current password verification failed");
                return false;
            }

            // Hash new password
            String newPasswordHash = PasswordUtil.hashPassword(newPassword);

            if (newPasswordHash == null) {
                System.err.println("ProfileService: Failed to hash new password");
                return false;
            }

            // Update password using UserDAO
            boolean success = userDAO.updatePassword(userId, newPasswordHash);

            if (success) {
                System.out.println("ProfileService: Password changed successfully for user ID: " + userId);
                // Log activity if ProfileDAO is available
                if (profileDAO != null) {
                    profileDAO.logProfileActivity(userId, "PASSWORD_CHANGE", "Password changed successfully");
                }
            }

            return success;

        } catch (Exception e) {
            System.err.println("ProfileService: Error changing password: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Validate and upload avatar
     */
    public String validateAndUploadAvatar(Integer userId, Part filePart, String fileName) {
        if (userId == null || filePart == null || fileName == null) {
            return null;
        }

        try {
            // Use webapp path to create the correct upload directory
            Path uploadPath;
            if (webappPath != null) {
                uploadPath = Paths.get(webappPath, UPLOAD_DIR);
            } else {
                // Fallback to relative path (not recommended for production)
                uploadPath = Paths.get(UPLOAD_DIR);
                System.err.println("ProfileService: Warning - Using relative path for avatar upload. This may not work correctly.");
            }

            if (!Files.exists(uploadPath)) {
                Files.createDirectories(uploadPath);
            }

            // Generate unique filename
            String fileExtension = getFileExtension(fileName);
            String uniqueFileName = userId + "_" + UUID.randomUUID().toString() + "." + fileExtension;
            Path filePath = uploadPath.resolve(uniqueFileName);

            // Save file to disk
            try (InputStream input = filePart.getInputStream()) {
                Files.copy(input, filePath, StandardCopyOption.REPLACE_EXISTING);
            }

            // Create relative URL for the avatar
            String avatarUrl = "/" + UPLOAD_DIR + "/" + uniqueFileName;

            // Update user's avatar URL using UserDAO
            boolean success = userDAO.updateAndUploadAvatar(userId, avatarUrl);

            if (success) {
                System.out.println("ProfileService: Avatar uploaded successfully for user ID: " + userId);
                System.out.println("ProfileService: Avatar saved to: " + filePath.toAbsolutePath());
                System.out.println("ProfileService: Avatar URL: " + avatarUrl);

                // Save avatar record if ProfileDAO is available
                if (profileDAO != null) {
                    UserAvatar userAvatar = new UserAvatar();
                    User user = new User();
                    user.setId(userId);
                    userAvatar.setUserID(user);
                    userAvatar.setImageURL(avatarUrl);
                    userAvatar.setIsDefault(true);
                    userAvatar.setUploadedAt(Instant.now());

                    profileDAO.saveUserAvatar(userAvatar);
                    if (userAvatar.getId() != null) {
                        profileDAO.setDefaultUserAvatar(userId, userAvatar.getId());
                    }
                }

                return avatarUrl;
            } else {
                // If database update failed, delete the uploaded file
                Files.deleteIfExists(filePath);
                System.err.println("ProfileService: Failed to update avatar URL in database");
                return null;
            }

        } catch (IOException e) {
            System.err.println("ProfileService: Error uploading avatar: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    /**
     * Delete user avatar
     */
    public boolean deleteAvatar(Integer userId) {
        if (userId == null) {
            return false;
        }

        try {
            // Get current avatar info
            User user = profileDAO.getUserProfile(userId);
            if (user == null || user.getAvatarUrl() == null) {
                return true; // No avatar to delete
            }

            // Delete physical file
            String avatarUrl = user.getAvatarUrl();
            if (avatarUrl.startsWith("/" + UPLOAD_DIR)) {
                String fileName = avatarUrl.substring(avatarUrl.lastIndexOf('/') + 1);

                Path filePath;
                if (webappPath != null) {
                    filePath = Paths.get(webappPath, UPLOAD_DIR, fileName);
                } else {
                    filePath = Paths.get(UPLOAD_DIR, fileName);
                }

                try {
                    Files.deleteIfExists(filePath);
                    System.out.println("ProfileService: Deleted avatar file: " + filePath.toAbsolutePath());
                } catch (IOException e) {
                    System.err.println("ProfileService: Error deleting avatar file: " + e.getMessage());
                    // Continue even if file deletion fails
                }
            }

            // Remove avatar from database
            boolean success = profileDAO.removeAvatar(userId);

            if (success) {
                System.out.println("ProfileService: Avatar deleted successfully for user ID: " + userId);
            }

            return success;

        } catch (Exception e) {
            System.err.println("ProfileService: Error deleting avatar: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Get profile statistics
     */
    public ProfileStatistics getProfileStatistics(Integer userId) {
        ProfileStatistics stats = new ProfileStatistics();

        try {
            // Get basic profile statistics
            stats.setProfileCompletionPercentage(profileDAO.getProfileCompletionPercentage(userId));

            // Get user for account age and last login
            User user = profileDAO.getUserProfile(userId);
            if (user != null) {
                // Calculate account age
                if (user.getCreatedAt() != null) {
                    long daysSinceCreation = java.time.Duration.between(user.getCreatedAt(), java.time.Instant.now()).toDays();
                    if (daysSinceCreation == 0) {
                        stats.setAccountAgeFormatted("Today");
                    } else if (daysSinceCreation == 1) {
                        stats.setAccountAgeFormatted("1 day");
                    } else if (daysSinceCreation < 30) {
                        stats.setAccountAgeFormatted(daysSinceCreation + " days");
                    } else if (daysSinceCreation < 365) {
                        long months = daysSinceCreation / 30;
                        stats.setAccountAgeFormatted(months + (months == 1 ? " month" : " months"));
                    } else {
                        long years = daysSinceCreation / 365;
                        stats.setAccountAgeFormatted(years + (years == 1 ? " year" : " years"));
                    }
                } else {
                    stats.setAccountAgeFormatted("Unknown");
                }

                // Format last login
                if (user.getLastLogin() != null) {
                    long hoursSinceLogin = java.time.Duration.between(user.getLastLogin(), java.time.Instant.now()).toHours();
                    if (hoursSinceLogin == 0) {
                        stats.setLastLoginFormatted("Just now");
                    } else if (hoursSinceLogin == 1) {
                        stats.setLastLoginFormatted("1 hour ago");
                    } else if (hoursSinceLogin < 24) {
                        stats.setLastLoginFormatted(hoursSinceLogin + " hours ago");
                    } else {
                        long daysSinceLogin = hoursSinceLogin / 24;
                        if (daysSinceLogin == 1) {
                            stats.setLastLoginFormatted("1 day ago");
                        } else {
                            stats.setLastLoginFormatted(daysSinceLogin + " days ago");
                        }
                    }
                } else {
                    stats.setLastLoginFormatted("Never");
                }
            }

            // Get enrollment statistics
            stats.setEnrolledCoursesCount(profileDAO.getEnrolledCoursesCount(userId));
            stats.setCompletedCoursesCount(profileDAO.getCompletedCoursesCount(userId));
            stats.setCertificatesIssuedCount(profileDAO.getCertificatesIssuedCount(userId));

            // Get recent enrollments
            stats.setRecentEnrollments(profileDAO.getRecentEnrollments(userId, 5));

        } catch (Exception e) {
            System.err.println("Error getting profile statistics: " + e.getMessage());
            e.printStackTrace();

            // Set default values on error
            stats.setProfileCompletionPercentage(0);
            stats.setAccountAgeFormatted("Unknown");
            stats.setLastLoginFormatted("Unknown");
            stats.setEnrolledCoursesCount(0);
            stats.setCompletedCoursesCount(0);
            stats.setCertificatesIssuedCount(0);
            stats.setRecentEnrollments(new ArrayList<>());
        }

        return stats;
    }

    /**
     * Get user's uploaded avatars
     */
    public List<UserAvatar> getUserAvatars(Integer userId) {
        if (userId == null) {
            return new ArrayList<>();
        }

        try {
            return profileDAO.getUserAvatars(userId);
        } catch (Exception e) {
            System.err.println("ProfileService: Error getting user avatars: " + e.getMessage());
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    /**
     * Set default user avatar
     */
    public boolean setDefaultAvatar(Integer userId, Integer avatarId) {
        if (userId == null || avatarId == null) {
            return false;
        }

        try {
            return profileDAO.setDefaultUserAvatar(userId, avatarId);
        } catch (Exception e) {
            System.err.println("ProfileService: Error setting default avatar: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // Helper methods

    /**
     * Get file extension from filename
     */
    private String getFileExtension(String fileName) {
        if (fileName == null || !fileName.contains(".")) {
            return "jpg"; // Default extension
        }
        return fileName.substring(fileName.lastIndexOf('.') + 1).toLowerCase();
    }

    /**
     * Calculate account age in days
     */
    private int calculateAccountAge(Instant createdAt) {
        if (createdAt == null) {
            return 0;
        }

        long daysDiff = (Instant.now().toEpochMilli() - createdAt.toEpochMilli()) / (1000 * 60 * 60 * 24);
        return (int) daysDiff;
    }

    /**
     * Calculate days since last login
     */
    private int calculateDaysSince(Instant lastLogin) {
        if (lastLogin == null) {
            return -1; // Never logged in
        }

        long daysDiff = (Instant.now().toEpochMilli() - lastLogin.toEpochMilli()) / (1000 * 60 * 60 * 24);
        return (int) daysDiff;
    }

    /**
     * Inner class for profile statistics
     */
    public static class ProfileStatistics {
        private int profileCompletionPercentage;
        private String accountAgeFormatted;
        private String lastLoginFormatted;
        private int enrolledCoursesCount;
        private int completedCoursesCount;
        private int certificatesIssuedCount;
        private List<ProfileDAO.EnrollmentSummary> recentEnrollments;

        public ProfileStatistics() {
            this.recentEnrollments = new ArrayList<>();
        }

        // Existing getters and setters
        public int getProfileCompletionPercentage() {
            return profileCompletionPercentage;
        }

        public void setProfileCompletionPercentage(int profileCompletionPercentage) {
            this.profileCompletionPercentage = profileCompletionPercentage;
        }

        public String getAccountAgeFormatted() {
            return accountAgeFormatted;
        }

        public void setAccountAgeFormatted(String accountAgeFormatted) {
            this.accountAgeFormatted = accountAgeFormatted;
        }

        public String getLastLoginFormatted() {
            return lastLoginFormatted;
        }

        public void setLastLoginFormatted(String lastLoginFormatted) {
            this.lastLoginFormatted = lastLoginFormatted;
        }

        // New getters and setters for enrollment statistics
        public int getEnrolledCoursesCount() {
            return enrolledCoursesCount;
        }

        public void setEnrolledCoursesCount(int enrolledCoursesCount) {
            this.enrolledCoursesCount = enrolledCoursesCount;
        }

        public int getCompletedCoursesCount() {
            return completedCoursesCount;
        }

        public void setCompletedCoursesCount(int completedCoursesCount) {
            this.completedCoursesCount = completedCoursesCount;
        }

        public int getCertificatesIssuedCount() {
            return certificatesIssuedCount;
        }

        public void setCertificatesIssuedCount(int certificatesIssuedCount) {
            this.certificatesIssuedCount = certificatesIssuedCount;
        }

        public List<ProfileDAO.EnrollmentSummary> getRecentEnrollments() {
            return recentEnrollments;
        }

        public void setRecentEnrollments(List<ProfileDAO.EnrollmentSummary> recentEnrollments) {
            this.recentEnrollments = recentEnrollments;
        }
    }
}