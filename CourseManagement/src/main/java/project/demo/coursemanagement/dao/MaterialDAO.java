package project.demo.coursemanagement.dao;

import project.demo.coursemanagement.entities.Material;
import java.util.List;

public interface MaterialDAO {
    List<Material> getMaterialsByLessonId(int lessonId);
}

