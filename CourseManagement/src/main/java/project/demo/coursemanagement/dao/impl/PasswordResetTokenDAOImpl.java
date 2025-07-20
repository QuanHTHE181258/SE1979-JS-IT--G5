package project.demo.coursemanagement.dao.impl;

import project.demo.coursemanagement.dao.PasswordResetTokenDAO;
import project.demo.coursemanagement.entities.PasswordResetToken;
import project.demo.coursemanagement.utils.DatabaseConnection;

import java.sql.*;

/**
 * Implementation of the PasswordResetTokenDAO interface
 */
public class PasswordResetTokenDAOImpl implements PasswordResetTokenDAO {

    @Override
    public boolean createToken(PasswordResetToken token) {
        String sql = "INSERT INTO password_reset_tokens (UserID, Token, ExpiryDate, Used) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setInt(1, token.getUserId());
            stmt.setString(2, token.getToken());
            stmt.setTimestamp(3, token.getExpiryDate());
            stmt.setBoolean(4, token.isUsed());
            
            int rowsAffected = stmt.executeUpdate();
            
            if (rowsAffected > 0) {
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        token.setId(rs.getInt(1));
                    }
                }
            }
            
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error creating password reset token: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public PasswordResetToken findByToken(String tokenString) {
        String sql = "SELECT TokenID, UserID, Token, ExpiryDate, Used FROM password_reset_tokens WHERE Token = ?";
        
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, tokenString);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToToken(rs);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error finding password reset token: " + e.getMessage());
            e.printStackTrace();
        }
        
        return null;
    }

    @Override
    public PasswordResetToken findLatestByUserId(Integer userId) {
        String sql = "SELECT TOP 1 TokenID, UserID, Token, ExpiryDate, Used FROM password_reset_tokens WHERE UserID = ? ORDER BY ExpiryDate DESC";
        
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToToken(rs);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error finding latest password reset token: " + e.getMessage());
            e.printStackTrace();
        }
        
        return null;
    }

    @Override
    public boolean markTokenAsUsed(Integer tokenId) {
        String sql = "UPDATE password_reset_tokens SET Used = 1 WHERE TokenID = ?";
        
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, tokenId);
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error marking password reset token as used: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public int deleteExpiredTokens() {
        String sql = "DELETE FROM password_reset_tokens WHERE ExpiryDate < GETDATE() OR Used = 1";
        
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            return stmt.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Error deleting expired password reset tokens: " + e.getMessage());
            e.printStackTrace();
            return 0;
        }
    }
    
    /**
     * Map a ResultSet to a PasswordResetToken object
     * 
     * @param rs The ResultSet to map
     * @return The mapped PasswordResetToken object
     * @throws SQLException If an error occurs while accessing the ResultSet
     */
    private PasswordResetToken mapResultSetToToken(ResultSet rs) throws SQLException {
        PasswordResetToken token = new PasswordResetToken();
        token.setId(rs.getInt("TokenID"));
        token.setUserId(rs.getInt("UserID"));
        token.setToken(rs.getString("Token"));
        token.setExpiryDate(rs.getTimestamp("ExpiryDate"));
        token.setUsed(rs.getBoolean("Used"));
        return token;
    }
}