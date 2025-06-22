package project.demo.coursemanagement.dao.impl;

import project.demo.coursemanagement.dao.CategoryDAO;
import project.demo.coursemanagement.dto.CategoryDTO;
import project.demo.coursemanagement.utils.DatabaseConnection;

import java.sql.*;
import java.time.Instant;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAOImpl implements CategoryDAO {

    @Override
    public List<CategoryDTO> getAllCategories() {
        List<CategoryDTO> categories = new ArrayList<>();
        String sql = "SELECT CategoryID, Name, Description, CreatedAt FROM Categories ORDER BY Name";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                CategoryDTO category = new CategoryDTO(
                        rs.getLong("CategoryID"),
                        rs.getString("Name"),
                        rs.getString("Description"),
                        rs.getTimestamp("CreatedAt").toInstant()
                );
                categories.add(category);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return categories;
    }

    @Override
    public CategoryDTO getCategoryById(Long id) {
        String sql = "SELECT CategoryID, Name, Description, CreatedAt FROM Categories WHERE CategoryID = ?";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setLong(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new CategoryDTO(
                            rs.getLong("CategoryID"),
                            rs.getString("Name"),
                            rs.getString("Description"),
                            rs.getTimestamp("CreatedAt").toInstant()
                    );
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    @Override
    public Long createCategory(CategoryDTO category) {
        String sql = "INSERT INTO Categories (Name, Description, CreatedAt) VALUES (?, ?, ?)";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, category.getName());
            stmt.setString(2, category.getDescription());
            stmt.setTimestamp(3, Timestamp.from(Instant.now()));

            int affectedRows = stmt.executeUpdate();

            if (affectedRows > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        return generatedKeys.getLong(1);
                    }
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    @Override
    public boolean updateCategory(CategoryDTO category) {
        String sql = "UPDATE Categories SET Name = ?, Description = ? WHERE CategoryID = ?";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, category.getName());
            stmt.setString(2, category.getDescription());
            stmt.setLong(3, category.getId());

            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public boolean deleteCategory(Long id) {
        String sql = "DELETE FROM Categories WHERE CategoryID = ?";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setLong(1, id);

            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }
}
