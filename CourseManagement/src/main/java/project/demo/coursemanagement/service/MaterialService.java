package project.demo.coursemanagement.service;

import project.demo.coursemanagement.dao.MaterialDAO;
import project.demo.coursemanagement.dao.impl.MaterialDAOImpl;
import project.demo.coursemanagement.entities.Material;
import java.util.List;

public class MaterialService {
    public List<Material> getMaterialsByLessonId(int lessonId) {
        MaterialDAO materialDAO = new MaterialDAOImpl();
        return materialDAO.getMaterialsByLessonId(lessonId);
    }
}

