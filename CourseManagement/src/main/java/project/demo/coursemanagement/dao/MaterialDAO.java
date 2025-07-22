package project.demo.coursemanagement.dao;

import project.demo.coursemanagement.entities.Material;
import java.util.List;

public interface MaterialDAO {
    boolean addMaterial(Material material);
    Material getMaterialById(int id);
    List<Material> getMaterialsByLessonId(int lessonId);
    boolean deleteMaterial(int id);
    boolean updateMaterial(Material material);
}

