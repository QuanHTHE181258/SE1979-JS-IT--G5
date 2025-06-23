package project.demo.coursemanagement.dao.impl;

import project.demo.coursemanagement.dao.MaterialDAO;
import project.demo.coursemanagement.entities.Material;
import project.demo.coursemanagement.entities.Lesson;
import java.sql.*;
import java.util.*;

public class MaterialDAOImpl implements MaterialDAO {
    @Override
    public List<Material> getMaterialsByLessonId(int lessonId) {
        List<Material> list = new ArrayList<>();
        String sql = "SELECT MaterialID, LessonID, Title, FileURL FROM materials WHERE LessonID = ? ORDER BY MaterialID";
        try (Connection conn = project.demo.coursemanagement.utils.DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, lessonId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Material material = new Material();
                    material.setId(rs.getInt("MaterialID"));
                    Lesson lesson = new Lesson();
                    lesson.setId(rs.getInt("LessonID"));
                    material.setLessonID(lesson);
                    material.setTitle(rs.getString("Title"));
                    material.setFileURL(rs.getString("FileURL"));
                    list.add(material);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}

