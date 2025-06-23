package project.demo.coursemanagement.dto;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;

/**
 * Data Transfer Object for profile update requests
 */
public class ProfileUpdateRequest {

    private Integer userId;
    private String username;
    private String email;
    private String firstName;
    private String lastName;
    private String phone;
    private String dateOfBirth;

    // For password change
    private String currentPassword;
    private String newPassword;
    private String confirmPassword;

    // For avatar
    private String avatarUrl;
    private boolean removeAvatar;

    public ProfileUpdateRequest() {
        this.removeAvatar = false;
    }

    // Getters and Setters
    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username != null ? username.trim() : null;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email != null ? email.trim().toLowerCase() : null;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName != null ? firstName.trim() : null;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName != null ? lastName.trim() : null;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        if (phone != null && !phone.trim().isEmpty()) {
            this.phone = phone.trim().replaceAll("\\s+", "");
        } else {
            this.phone = null;
        }
    }

    public String getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(String dateOfBirth) {
        this.dateOfBirth = dateOfBirth != null ? dateOfBirth.trim() : null;
    }

    public String getCurrentPassword() {
        return currentPassword;
    }

    public void setCurrentPassword(String currentPassword) {
        this.currentPassword = currentPassword;
    }

    public String getNewPassword() {
        return newPassword;
    }

    public void setNewPassword(String newPassword) {
        this.newPassword = newPassword;
    }

    public String getConfirmPassword() {
        return confirmPassword;
    }

    public void setConfirmPassword(String confirmPassword) {
        this.confirmPassword = confirmPassword;
    }

    public String getAvatarUrl() {
        return avatarUrl;
    }

    public void setAvatarUrl(String avatarUrl) {
        this.avatarUrl = avatarUrl;
    }

    public boolean isRemoveAvatar() {
        return removeAvatar;
    }

    public void setRemoveAvatar(boolean removeAvatar) {
        this.removeAvatar = removeAvatar;
    }

    // Helper methods

    /**
     * Parse date of birth to LocalDate
     */
    public LocalDate getParsedDateOfBirth() {
        if (dateOfBirth == null || dateOfBirth.trim().isEmpty()) {
            return null;
        }

        try {
            return LocalDate.parse(dateOfBirth, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        } catch (DateTimeParseException e) {
            return null;
        }
    }


    /**
     * Check if this is a password change request
     */
    public boolean isPasswordChangeRequest() {
        return currentPassword != null && newPassword != null && confirmPassword != null;
    }

    /**
     * Check if passwords match
     */
    public boolean passwordsMatch() {
        return newPassword != null && newPassword.equals(confirmPassword);
    }

    /**
     * Check if any field has been modified
     */
    public boolean hasChanges() {
        return username != null || email != null || firstName != null ||
                lastName != null || phone != null || dateOfBirth != null ||
                avatarUrl != null || removeAvatar || isPasswordChangeRequest();
    }

    /**
     * Clear sensitive password fields
     */
    public void clearPasswords() {
        this.currentPassword = null;
        this.newPassword = null;
        this.confirmPassword = null;
    }

    /**
     * Validate that required fields for update are present
     */
    public boolean hasRequiredFields() {
        // At least one field should be updated
        return hasChanges();
    }


    @Override
    public String toString() {
        return "ProfileUpdateRequest{" +
                "userId=" + userId +
                ", username='" + username + '\'' +
                ", email='" + email + '\'' +
                ", firstName='" + firstName + '\'' +
                ", lastName='" + lastName + '\'' +
                ", phone='" + phone + '\'' +
                ", dateOfBirth='" + dateOfBirth + '\'' +
                ", hasPasswordChange=" + isPasswordChangeRequest() +
                ", avatarUrl='" + avatarUrl + '\'' +
                ", removeAvatar=" + removeAvatar +
                '}';
    }
}