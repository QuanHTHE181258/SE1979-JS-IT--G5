package project.demo.coursemanagement.dto;

/**
 * Data Transfer Object for password reset requests
 */
public class PasswordResetRequest {

    private String email;
    private String token;
    private String newPassword;
    private String confirmPassword;

    // Default constructor
    public PasswordResetRequest() {
    }

    // Constructor for initial password reset request (email only)
    public PasswordResetRequest(String email) {
        this.email = email;
    }

    // Constructor for password reset confirmation (token and new passwords)
    public PasswordResetRequest(String token, String newPassword, String confirmPassword) {
        this.token = token;
        this.newPassword = newPassword;
        this.confirmPassword = confirmPassword;
    }

    // Getters and setters
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
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

    /**
     * Validate the password reset request for the initial step (email only)
     *
     * @return true if the request is valid, false otherwise
     */


    /**
     * Validate the password reset request for the confirmation step (token and new passwords)
     *
     * @return true if the request is valid, false otherwise
     */
    public boolean validateConfirmationRequest() {
        return token != null && !token.trim().isEmpty() &&
                newPassword != null && !newPassword.trim().isEmpty() &&
                confirmPassword != null && !confirmPassword.trim().isEmpty() &&
                newPassword.equals(confirmPassword);
    }
}