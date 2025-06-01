package project.demo.coursemanagement.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import project.demo.coursemanagement.entities.Role;
import project.demo.coursemanagement.utils.DatabaseConnection; // Assuming DatabaseConnection is your DB utility

public class RoleDAOImpl implements RoleDAO {

    @Override
    public Role findByRoleName(String roleName) {
        String sql = "SELECT role_id, role_name, description FROM Roles WHERE role_name = ?";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, roleName);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToRole(rs);
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
        String sql = "SELECT role_id, role_name, description FROM Roles WHERE role_id = ?";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, roleId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToRole(rs);
                }
            }
        } catch (SQLException e) {
             System.err.println("Error finding role by id: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Role> findAll() {
        List<Role> roles = new ArrayList<>();
        String sql = "SELECT role_id, role_name, description FROM Roles ORDER BY role_id";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                roles.add(mapResultSetToRole(rs));
            }
        } catch (SQLException e) {
             System.err.println("Error finding all roles: " + e.getMessage());
            e.printStackTrace();
        }
        return roles;
    }

    private Role mapResultSetToRole(ResultSet rs) throws SQLException {
        Role role = new Role();
        role.setId(rs.getInt("role_id"));
        role.setRoleName(rs.getString("role_name"));
        role.setDescription(rs.getString("description"));
        return role;
    }
} 