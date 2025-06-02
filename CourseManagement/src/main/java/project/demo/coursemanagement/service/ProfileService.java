package project.demo.coursemanagement.service;

import project.demo.coursemanagement.dao.ProfileDAO;
import project.demo.coursemanagement.dao.ProfileDAOImpl;
import project.demo.coursemanagement.dao.UserDAO;
import project.demo.coursemanagement.dao.UserDAOImpl;
import project.demo.coursemanagement.entities.User;
import project.demo.coursemanagement.entities.UserImage;
import project.demo.coursemanagement.dto.ProfileUpdateRequest;
import project.demo.coursemanagement.dto.ValidationResult;
import project.demo.coursemanagement.utils.PasswordUtil;
import project.demo.coursemanagement.utils.ValidationUtil;

import jakarta.servlet.http.Part;

import java.io.File;
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
    private static final String UPLOAD_DIR = "uploads/avatars";
    private static final long MAX_FILE_SIZE = 5 * 1024 * 1024; // 5MB

    public ProfileService() {
        this.profileDAO = new ProfileDAOImpl();
        this.userDAO = new UserDAOImpl();
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
            // Create upload directory if it doesn't exist
            Path uploadPath = Paths.get(UPLOAD_DIR);
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

                // Save image record if ProfileDAO is available
                if (profileDAO != null) {
                    UserImage userImage = new UserImage();
                    User user = new User();
                    user.setId(userId);
                    userImage.setUser(user);
                    userImage.setImageName(fileName);
                    userImage.setImagePath(avatarUrl);
                    userImage.setImageSize(filePart.getSize());
                    userImage.setImageType(filePart.getContentType());
                    userImage.setIsDefault(true);
                    userImage.setUploadDate(Instant.now());

                    profileDAO.saveUserImage(userImage);
                    if (userImage.getId() != null) {
                        profileDAO.setDefaultUserImage(userId, userImage.getId());
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
                Path filePath = Paths.get(UPLOAD_DIR, fileName);

                try {
                    Files.deleteIfExists(filePath);
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
        if (userId == null) {
            return new ProfileStatistics();
        }

        try {
            ProfileStatistics stats = new ProfileStatistics();

            // Get profile completion percentage
            stats.setProfileCompletionPercentage(profileDAO.getProfileCompletionPercentage(userId));

            // Get user profile for additional stats
            User user = profileDAO.getUserProfile(userId);
            if (user != null) {
                stats.setEmailVerified(user.getEmailVerified() != null ? user.getEmailVerified() : false);
                stats.setHasAvatar(user.getAvatarUrl() != null);
                stats.setAccountAge(calculateAccountAge(user.getCreatedAt()));
                stats.setLastLoginDaysAgo(calculateDaysSince(user.getLastLogin()));
            }

            // Get recent activities
            stats.setRecentActivities(profileDAO.getRecentProfileActivities(userId, 5));

            return stats;

        } catch (Exception e) {
            System.err.println("ProfileService: Error getting profile statistics: " + e.getMessage());
            e.printStackTrace();
            return new ProfileStatistics();
        }
    }

    /**
     * Get user's uploaded images
     */
    public List<UserImage> getUserImages(Integer userId) {
        if (userId == null) {
            return new ArrayList<>();
        }

        try {
            return profileDAO.getUserImages(userId);
        } catch (Exception e) {
            System.err.println("ProfileService: Error getting user images: " + e.getMessage());
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    /**
     * Set default user image
     */
    public boolean setDefaultImage(Integer userId, Integer imageId) {
        if (userId == null || imageId == null) {
            return false;
        }

        try {
            return profileDAO.setDefaultUserImage(userId, imageId);
        } catch (Exception e) {
            System.err.println("ProfileService: Error setting default image: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Delete user image
     */
    public boolean deleteImage(Integer imageId) {
        if (imageId == null) {
            return false;
        }

        try {
            return profileDAO.deleteUserImage(imageId);
        } catch (Exception e) {
            System.err.println("ProfileService: Error deleting image: " + e.getMessage());
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
        private boolean emailVerified;
        private boolean hasAvatar;
        private int accountAge; // in days
        private int lastLoginDaysAgo;
        private List<ProfileDAO.ProfileActivity> recentActivities;

        public ProfileStatistics() {
            this.recentActivities = new ArrayList<>();
        }

        // Getters and setters
        public int getProfileCompletionPercentage() {
            return profileCompletionPercentage;
        }

        public void setProfileCompletionPercentage(int profileCompletionPercentage) {
            this.profileCompletionPercentage = profileCompletionPercentage;
        }

        public boolean isEmailVerified() {
            return emailVerified;
        }

        public void setEmailVerified(boolean emailVerified) {
            this.emailVerified = emailVerified;
        }

        public boolean isHasAvatar() {
            return hasAvatar;
        }

        public void setHasAvatar(boolean hasAvatar) {
            this.hasAvatar = hasAvatar;
        }

        public int getAccountAge() {
            return accountAge;
        }

        public void setAccountAge(int accountAge) {
            this.accountAge = accountAge;
        }

        public int getLastLoginDaysAgo() {
            return lastLoginDaysAgo;
        }

        public void setLastLoginDaysAgo(int lastLoginDaysAgo) {
            this.lastLoginDaysAgo = lastLoginDaysAgo;
        }

        public List<ProfileDAO.ProfileActivity> getRecentActivities() {
            return recentActivities;
        }

        public void setRecentActivities(List<ProfileDAO.ProfileActivity> recentActivities) {
            this.recentActivities = recentActivities;
        }

        // Helper methods
        public String getCompletionStatus() {
            if (profileCompletionPercentage >= 100) {
                return "Complete";
            } else if (profileCompletionPercentage >= 75) {
                return "Almost Complete";
            } else if (profileCompletionPercentage >= 50) {
                return "Partially Complete";
            } else {
                return "Incomplete";
            }
        }

        public String getAccountAgeFormatted() {
            if (accountAge == 0) {
                return "Today";
            } else if (accountAge == 1) {
                return "1 day";
            } else if (accountAge < 30) {
                return accountAge + " days";
            } else if (accountAge < 365) {
                int months = accountAge / 30;
                return months + (months == 1 ? " month" : " months");
            } else {
                int years = accountAge / 365;
                return years + (years == 1 ? " year" : " years");
            }
        }

        public String getLastLoginFormatted() {
            if (lastLoginDaysAgo < 0) {
                return "Never";
            } else if (lastLoginDaysAgo == 0) {
                return "Today";
            } else if (lastLoginDaysAgo == 1) {
                return "Yesterday";
            } else if (lastLoginDaysAgo < 7) {
                return lastLoginDaysAgo + " days ago";
            } else if (lastLoginDaysAgo < 30) {
                int weeks = lastLoginDaysAgo / 7;
                return weeks + (weeks == 1 ? " week ago" : " weeks ago");
            } else {
                int months = lastLoginDaysAgo / 30;
                return months + (months == 1 ? " month ago" : " months ago");
            }
        }
    }
}