package project.demo.coursemanagement.entities;

import java.sql.Timestamp;
import java.util.UUID;

/**
 * Entity class for password reset tokens
 */
public class PasswordResetToken {
    
    private Integer id;
    private Integer userId;
    private String token;
    private Timestamp expiryDate;
    private boolean used;
    
    // Default constructor
    public PasswordResetToken() {
    }
    
    // Constructor with user ID
    public PasswordResetToken(Integer userId) {
        this.userId = userId;
        this.token = UUID.randomUUID().toString();
        // Set expiry to 30 minutes from now
        this.expiryDate = new Timestamp(System.currentTimeMillis() + 30 * 60 * 1000);
        this.used = false;
    }
    
    // Getters and setters
    public Integer getId() {
        return id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }
    
    public Integer getUserId() {
        return userId;
    }
    
    public void setUserId(Integer userId) {
        this.userId = userId;
    }
    
    public String getToken() {
        return token;
    }
    
    public void setToken(String token) {
        this.token = token;
    }
    
    public Timestamp getExpiryDate() {
        return expiryDate;
    }
    
    public void setExpiryDate(Timestamp expiryDate) {
        this.expiryDate = expiryDate;
    }
    
    public boolean isUsed() {
        return used;
    }
    
    public void setUsed(boolean used) {
        this.used = used;
    }
    
    /**
     * Check if the token has expired
     * 
     * @return true if the token has expired, false otherwise
     */
    public boolean isExpired() {
        return expiryDate.before(new Timestamp(System.currentTimeMillis()));
    }
    
    /**
     * Check if the token is valid (not expired and not used)
     * 
     * @return true if the token is valid, false otherwise
     */
    public boolean isValid() {
        return !isExpired() && !used;
    }
}