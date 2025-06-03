package project.demo.coursemanagement.dao;

import java.util.List;
import project.demo.coursemanagement.entities.Role;

public interface RoleDAO {
    Role findByRoleName(String roleName);
    Role findById(int roleId);
    List<Role> findAll();
} 