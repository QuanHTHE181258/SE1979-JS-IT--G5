package project.demo.coursemanagement.dao.impl;

import project.demo.coursemanagement.dao.MaterialDAO;
import project.demo.coursemanagement.entities.Material;
import project.demo.coursemanagement.entities.Lesson;
import project.demo.coursemanagement.utils.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MaterialDAOImpl implements MaterialDAO {
    @Override
    public boolean addMaterial(Material material) {
        String sql = "INSERT INTO materials (LessonID, Title, FileURL) VALUES (?, ?, ?)";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, material.getLessonID().getId());
            stmt.setString(2, material.getTitle());
            stmt.setString(3, material.getFileURL());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public Material getMaterialById(int id) {
        String sql = "SELECT * FROM materials WHERE MaterialID = ?";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Material material = new Material();
                    material.setId(rs.getInt("MaterialID"));
                    Lesson lesson = new Lesson();
                    lesson.setId(rs.getInt("LessonID"));
                    material.setLessonId(rs.getInt("LessonID")); // Sửa từ setLessonID thành setLessonId
                    material.setTitle(rs.getString("Title"));
                    material.setFileURL(rs.getString("FileURL"));
                    return material;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Material> getMaterialsByLessonId(int lessonId) {
        List<Material> list = new ArrayList<>();
        String sql = "SELECT * FROM materials WHERE LessonID = ?";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, lessonId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Material material = new Material();
                    material.setId(rs.getInt("MaterialID"));
                    Lesson lesson = new Lesson();
                    lesson.setId(rs.getInt("LessonID"));
                    material.setLessonId(rs.getInt("LessonID")); // Sửa từ setLessonID thành setLessonId
                    material.setTitle(rs.getString("Title"));
                    material.setFileURL(rs.getString("FileURL"));
                    list.add(material);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public boolean deleteMaterial(int id) {
        String sql = "DELETE FROM materials WHERE MaterialID = ?";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean updateMaterial(Material material) {
        String sql = "UPDATE materials SET Title = ?, FileURL = ? WHERE MaterialID = ?";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, material.getTitle());
            stmt.setString(2, material.getFileURL());
            stmt.setInt(3, material.getId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
