package project.demo.coursemanagement.dao.impl;

import project.demo.coursemanagement.dao.UserRoleDAO;
import project.demo.coursemanagement.entities.Role;
import project.demo.coursemanagement.entities.UserRole;
import project.demo.coursemanagement.entities.UserRoleId;
import project.demo.coursemanagement.utils.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Implementation of UserRoleDAO
 */
public class UserRoleDAOImpl implements UserRoleDAO {
    @Override
    public Integer getRoleIdByUserId(Integer userId) {
        Integer roleId = null;
        String sql = "SELECT RoleID FROM user_roles WHERE UserID = ?";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                roleId = rs.getInt("RoleID");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return roleId;
    }
    @Override
    public List<Role> findRolesByUserId(Integer userId) {
        List<Role> roles = new ArrayList<>();
        String sql = "SELECT r.RoleID, r.RoleName FROM roles r " +
                "JOIN user_roles ur ON r.RoleID = ur.RoleID " +
                "WHERE ur.UserID = ?";
        
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Role role = new Role();
                    role.setId(rs.getInt("RoleID"));
                    role.setRoleName(rs.getString("RoleName"));
                    roles.add(role);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error finding roles for user: " + e.getMessage());
            e.printStackTrace();
        }
        
        return roles;
    }

    @Override
    public Role findPrimaryRoleByUserId(Integer userId) {
        String sql = "SELECT r.RoleID, r.RoleName FROM roles r " +
                "JOIN user_roles ur ON r.RoleID = ur.RoleID " +
                "WHERE ur.UserID = ? " +
                "ORDER BY r.RoleID DESC";
        
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Role role = new Role();
                    role.setId(rs.getInt("RoleID"));
                    role.setRoleName(rs.getString("RoleName"));
                    return role;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error finding primary role for user: " + e.getMessage());
            e.printStackTrace();
        }
        
        return null;
    }

    @Override
    public boolean assignRoleToUser(Integer userId, Integer roleId) {
        String sql = "INSERT INTO user_roles (UserID, RoleID) VALUES (?, ?)";
        
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            stmt.setInt(2, roleId);
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error assigning role to user: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean removeRoleFromUser(Integer userId, Integer roleId) {
        String sql = "DELETE FROM user_roles WHERE UserID = ? AND RoleID = ?";
        
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            stmt.setInt(2, roleId);
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error removing role from user: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean removeAllRolesFromUser(Integer userId) {
        String sql = "DELETE FROM user_roles WHERE UserID = ?";
        
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error removing all roles from user: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean hasRole(Integer userId, String roleName) {
        String sql = "SELECT 1 FROM user_roles ur " +
                "JOIN roles r ON ur.RoleID = r.RoleID " +
                "WHERE ur.UserID = ? AND r.RoleName = ?";
        
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            stmt.setString(2, roleName);
            
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            System.err.println("Error checking if user has role: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}