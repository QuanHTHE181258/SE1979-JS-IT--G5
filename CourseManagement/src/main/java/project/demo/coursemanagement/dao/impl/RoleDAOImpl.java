package project.demo.coursemanagement.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import project.demo.coursemanagement.dao.RoleDAO;
import project.demo.coursemanagement.entities.Role;
import project.demo.coursemanagement.utils.DatabaseConnection; // Assuming DatabaseConnection is your DB utility

public class RoleDAOImpl implements RoleDAO {

    @Override
    public Role findByRoleName(String roleName) {
        System.out.println("Looking up role by name: " + roleName);
        String sql = "SELECT RoleID, RoleName FROM roles WHERE RoleName = ?";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, roleName);
            System.out.println("Executing SQL: " + sql + " with parameter: " + roleName);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Role role = new Role();
                    role.setId(rs.getInt("RoleID"));
                    role.setRoleName(rs.getString("RoleName"));
                    System.out.println("Found role: ID=" + role.getId() + ", Name=" + role.getRoleName());
                    return role;
                } else {
                    System.out.println("No role found with name: " + roleName);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error finding role by name: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public Role findById(int roleId) {
        System.out.println("Looking up role by ID: " + roleId);
        String sql = "SELECT RoleID, RoleName FROM roles WHERE RoleID = ?";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, roleId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Role role = new Role();
                    role.setId(rs.getInt("RoleID"));
                    role.setRoleName(rs.getString("RoleName"));
                    System.out.println("Found role: ID=" + role.getId() + ", Name=" + role.getRoleName());
                    return role;
                }
                System.out.println("No role found with ID: " + roleId);
            }
        } catch (SQLException e) {
            System.err.println("Error finding role by ID: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Role> findAll() {
        System.out.println("Fetching all roles");
        List<Role> roles = new ArrayList<>();
        String sql = "SELECT RoleID, RoleName FROM roles ORDER BY RoleID";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Role role = new Role();
                role.setId(rs.getInt("RoleID"));
                role.setRoleName(rs.getString("RoleName"));
                roles.add(role);
            }
            System.out.println("Found " + roles.size() + " roles");
            roles.forEach(role -> System.out.println("Role: ID=" + role.getId() + ", Name=" + role.getRoleName()));
        } catch (SQLException e) {
            System.err.println("Error finding all roles: " + e.getMessage());
            e.printStackTrace();
        }
        return roles;
    }
}
