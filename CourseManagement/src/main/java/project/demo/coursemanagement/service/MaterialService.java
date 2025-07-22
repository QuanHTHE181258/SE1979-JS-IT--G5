package project.demo.coursemanagement.service;

import project.demo.coursemanagement.dao.MaterialDAO;
import project.demo.coursemanagement.dao.impl.MaterialDAOImpl;
import project.demo.coursemanagement.entities.Material;
import java.util.List;

public class MaterialService {
    private final MaterialDAO materialDAO = new MaterialDAOImpl();

    public boolean addMaterial(Material material) {
        return materialDAO.addMaterial(material);
    }

    public Material getMaterialById(int id) {
        return materialDAO.getMaterialById(id);
    }

    public List<Material> getMaterialsByLessonId(int lessonId) {
        return materialDAO.getMaterialsByLessonId(lessonId);
    }

    public boolean deleteMaterial(int id) {
        return materialDAO.deleteMaterial(id);
    }

    public boolean updateMaterial(Material material) {
        return materialDAO.updateMaterial(material);
    }
}

