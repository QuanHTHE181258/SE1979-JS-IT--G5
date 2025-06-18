package project.demo.coursemanagement.dao;

import project.demo.coursemanagement.entities.Role;
import project.demo.coursemanagement.entities.UserRole;

import java.util.List;

/**
 * Data Access Object for UserRole entity
 */
public interface UserRoleDAO {
    
    /**
     * Find all roles for a user
     * @param userId The user ID
     * @return List of roles
     */
    List<Role> findRolesByUserId(Integer userId);
    
    /**
     * Find the primary role for a user (first role found)
     * @param userId The user ID
     * @return The primary role, or null if no roles found
     */
    Role findPrimaryRoleByUserId(Integer userId);
    
    /**
     * Assign a role to a user
     * @param userId The user ID
     * @param roleId The role ID
     * @return true if successful, false otherwise
     */
    boolean assignRoleToUser(Integer userId, Integer roleId);
    
    /**
     * Remove a role from a user
     * @param userId The user ID
     * @param roleId The role ID
     * @return true if successful, false otherwise
     */
    boolean removeRoleFromUser(Integer userId, Integer roleId);
    
    /**
     * Remove all roles from a user
     * @param userId The user ID
     * @return true if successful, false otherwise
     */
    boolean removeAllRolesFromUser(Integer userId);
    
    /**
     * Check if a user has a specific role
     * @param userId The user ID
     * @param roleName The role name
     * @return true if the user has the role, false otherwise
     */
    boolean hasRole(Integer userId, String roleName);
}