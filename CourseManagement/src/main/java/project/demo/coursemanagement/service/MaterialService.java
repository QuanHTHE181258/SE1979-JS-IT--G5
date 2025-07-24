package project.demo.coursemanagement.service;

import project.demo.coursemanagement.dao.MaterialDAO;
import project.demo.coursemanagement.dao.impl.MaterialDAOImpl;
import project.demo.coursemanagement.entities.Material;
import project.demo.coursemanagement.dto.MaterialDTO;
import java.util.List;
import project.demo.coursemanagement.entities.Lesson;

public class MaterialService {
    private final MaterialDAO materialDAO = new MaterialDAOImpl();

    public boolean addMaterial(Material material) {
        return materialDAO.addMaterial(material);
    }

    public MaterialDTO getMaterialById(int id) {
        Material entity = materialDAO.getMaterialById(id);
        if (entity == null) return null;
        MaterialDTO dto = new MaterialDTO();
        dto.setId(entity.getId());
        dto.setLessonId(entity.getLessonID().getId()); // Lấy id của lesson
        dto.setTitle(entity.getTitle());
        dto.setFileURL(entity.getFileURL());
        return dto;
    }

    public List<Material> getMaterialsByLessonId(int lessonId) {
        return materialDAO.getMaterialsByLessonId(lessonId);
    }

    public boolean deleteMaterial(int id) {
        return materialDAO.deleteMaterial(id);
    }

    public boolean updateMaterial(MaterialDTO dto) {
        Material entity = new Material();
        entity.setId(dto.getId());
        Lesson lesson = new Lesson();
        lesson.setId(dto.getLessonId());
        entity.setLessonID(lesson);
        entity.setTitle(dto.getTitle());
        entity.setFileURL(dto.getFileURL());
        return materialDAO.updateMaterial(entity);
    }
}

