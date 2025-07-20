package project.demo.coursemanagement.dao;

import project.demo.coursemanagement.entities.PasswordResetToken;

/**
 * Data Access Object interface for password reset tokens
 */
public interface PasswordResetTokenDAO {
    
    /**
     * Create a new password reset token
     * 
     * @param token The password reset token to create
     * @return true if the token was created successfully, false otherwise
     */
    boolean createToken(PasswordResetToken token);
    
    /**
     * Find a password reset token by its token string
     * 
     * @param tokenString The token string to search for
     * @return The password reset token if found, null otherwise
     */
    PasswordResetToken findByToken(String tokenString);
    
    /**
     * Find the most recent password reset token for a user
     * 
     * @param userId The user ID to search for
     * @return The most recent password reset token if found, null otherwise
     */
    PasswordResetToken findLatestByUserId(Integer userId);
    
    /**
     * Mark a password reset token as used
     * 
     * @param tokenId The ID of the token to mark as used
     * @return true if the token was marked as used successfully, false otherwise
     */
    boolean markTokenAsUsed(Integer tokenId);
    
    /**
     * Delete expired tokens
     * 
     * @return The number of tokens deleted
     */
    int deleteExpiredTokens();
}