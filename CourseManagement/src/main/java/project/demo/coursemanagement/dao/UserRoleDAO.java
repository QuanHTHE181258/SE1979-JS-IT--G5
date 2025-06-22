package project.demo.coursemanagement.dao;

import project.demo.coursemanagement.entities.Role;
import project.demo.coursemanagement.entities.UserRole;

import java.util.List;

/**
 * Data Access Object for UserRole entity
 */
public interface UserRoleDAO {

    List<Role> findRolesByUserId(Integer userId);

    Role findPrimaryRoleByUserId(Integer userId);

    boolean assignRoleToUser(Integer userId, Integer roleId);

    boolean removeRoleFromUser(Integer userId, Integer roleId);

    boolean removeAllRolesFromUser(Integer userId);

    boolean hasRole(Integer userId, String roleName);
}