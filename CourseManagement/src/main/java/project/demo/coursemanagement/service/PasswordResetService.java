package project.demo.coursemanagement.service;

import project.demo.coursemanagement.dao.UserDAO;
import project.demo.coursemanagement.dto.PasswordResetRequest;
import project.demo.coursemanagement.entities.User;
import project.demo.coursemanagement.utils.EmailUtil;
import project.demo.coursemanagement.utils.PasswordUtil;

import java.util.Base64;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;
import java.util.logging.Logger;
import java.util.logging.Level;

/**
 * Simple password reset service for college project
 * Uses in-memory storage for tokens (not suitable for production)
 */
public class PasswordResetService {

    private static final Logger LOGGER = Logger.getLogger(PasswordResetService.class.getName());
    private static final long TOKEN_VALIDITY_MINUTES = 30; // 30 minutes

    // In-memory storage for reset tokens (simple for college project)
    private static final Map<String, TokenInfo> activeTokens = new HashMap<>();

    private final UserDAO userDAO;

    /**
     * Default constructor
     */
    public PasswordResetService() {
        this.userDAO = new UserDAOImpl();
    }

    /**
     * Request a password reset for the specified email
     *
     * @param email The email address of the user requesting a password reset
     * @param baseUrl The base URL for the reset link
     * @return true if the request was successful, false otherwise
     */
    public boolean requestPasswordReset(String email, String baseUrl) {
        LOGGER.info("Password reset requested for email: " + email);

        // Input validation
        if (email == null || email.trim().isEmpty()) {
            LOGGER.warning("Empty email provided for password reset");
            return false;
        }

        if (baseUrl == null || baseUrl.trim().isEmpty()) {
            LOGGER.warning("Empty base URL provided for password reset");
            return false;
        }

        try {
            // Find user by email
            User user = userDAO.findUserByUsernameOrEmail(email.trim());
            if (user == null) {
                LOGGER.warning("Password reset requested for non-existent email: " + email);
                // Return true anyway to prevent email enumeration attacks
                return true;
            }

            // Clean up expired tokens first
            cleanupExpiredTokens();

            // Generate simple token
            String token = generateSimpleToken();

            // Store token in memory
            TokenInfo tokenInfo = new TokenInfo(user.getId(), user.getEmail(), System.currentTimeMillis());
            activeTokens.put(token, tokenInfo);

            // Generate reset link
            String resetLink = baseUrl + "/reset-password?token=" + token;

            // Send email
            boolean emailSent = EmailUtil.sendPasswordResetEmail(user.getEmail(), token, resetLink);

            if (emailSent) {
                LOGGER.info("Password reset email sent successfully to: " + email);
                return true;
            } else {
                LOGGER.severe("Failed to send password reset email to: " + email);
                // Remove token if email failed
                activeTokens.remove(token);
                return false;
            }

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Unexpected error during password reset request", e);
            return false;
        }
    }

    /**
     * Validate a password reset token
     *
     * @param tokenString The token string to validate
     * @return true if the token is valid, false otherwise
     */
    public boolean validateToken(String tokenString) {
        if (tokenString == null || tokenString.trim().isEmpty()) {
            LOGGER.warning("Token validation attempted with null/empty token");
            return false;
        }

        try {
            // Clean up expired tokens first
            cleanupExpiredTokens();

            tokenString = tokenString.trim();
            TokenInfo tokenInfo = activeTokens.get(tokenString);

            if (tokenInfo == null) {
                LOGGER.warning("Token not found or expired: " + tokenString);
                return false;
            }

            // Check if token has expired
            long currentTime = System.currentTimeMillis();
            long tokenAge = currentTime - tokenInfo.createdTime;
            long maxAge = TOKEN_VALIDITY_MINUTES * 60 * 1000; // Convert to milliseconds

            if (tokenAge > maxAge) {
                LOGGER.warning("Token expired: " + tokenString);
                activeTokens.remove(tokenString); // Remove expired token
                return false;
            }

            return true;

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error validating token", e);
            return false;
        }
    }

    /**
     * Reset a user's password using a token
     *
     * @param request The password reset request containing the token and new password
     * @return true if the password was reset successfully, false otherwise
     */
    public boolean resetPassword(PasswordResetRequest request) {
        if (request == null) {
            LOGGER.warning("Null request provided for password reset");
            return false;
        }

        if (!request.validateConfirmationRequest()) {
            LOGGER.warning("Invalid request validation for password reset");
            return false;
        }

        LOGGER.info("Password reset attempt with token");

        try {
            // Validate token first
            if (!validateToken(request.getToken())) {
                LOGGER.warning("Invalid or expired token used for password reset");
                return false;
            }

            // Get token info
            TokenInfo tokenInfo = activeTokens.get(request.getToken());
            if (tokenInfo == null) {
                LOGGER.warning("Token not found during password reset");
                return false;
            }

            // Find user by ID
            User user = userDAO.findUserById(tokenInfo.userId);
            if (user == null) {
                LOGGER.severe("User not found for token");
                // Remove invalid token
                activeTokens.remove(request.getToken());
                return false;
            }

            // Additional security: verify email matches
            if (!user.getEmail().equals(tokenInfo.email)) {
                LOGGER.severe("Email mismatch in token for user: " + user.getId());
                activeTokens.remove(request.getToken());
                return false;
            }

            // Hash new password
            String hashedPassword = PasswordUtil.hashPassword(request.getNewPassword());

            // Update password
            boolean passwordUpdated = userDAO.updatePassword(user.getId(), hashedPassword);

            if (passwordUpdated) {
                LOGGER.info("Password reset successful for user: " + user.getEmail());
                // Remove used token
                activeTokens.remove(request.getToken());
                return true;
            } else {
                LOGGER.severe("Failed to update password for user: " + user.getId());
                return false;
            }

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Unexpected error during password reset", e);
            return false;
        }
    }

    /**
     * Generate a simple random token
     */
    private String generateSimpleToken() {
        // Generate UUID and encode it
        String uuid = UUID.randomUUID().toString().replace("-", "");
        return Base64.getUrlEncoder().withoutPadding().encodeToString(uuid.getBytes());
    }

    /**
     * Clean up expired tokens from memory
     */
    private void cleanupExpiredTokens() {
        long currentTime = System.currentTimeMillis();
        long maxAge = TOKEN_VALIDITY_MINUTES * 60 * 1000;

        activeTokens.entrySet().removeIf(entry -> {
            long tokenAge = currentTime - entry.getValue().createdTime;
            return tokenAge > maxAge;
        });
    }

    /**
     * Get the number of active tokens (for debugging/monitoring)
     */
    public int getActiveTokenCount() {
        cleanupExpiredTokens();
        return activeTokens.size();
    }

    /**
     * Clear all tokens (for testing purposes)
     */
    public void clearAllTokens() {
        activeTokens.clear();
        LOGGER.info("All reset tokens cleared");
    }

    /**
     * Simple class to hold token information
     */
    private static class TokenInfo {
        final Integer userId;
        final String email;
        final long createdTime;

        TokenInfo(Integer userId, String email, long createdTime) {
            this.userId = userId;
            this.email = email;
            this.createdTime = createdTime;
        }
    }
}