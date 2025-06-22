package project.demo.coursemanagement.service;

import project.demo.coursemanagement.dao.CourseCatalogDAO;
import project.demo.coursemanagement.dao.impl.CourseCatalogDAOimp;
import project.demo.coursemanagement.dto.CourseDTO;
import project.demo.coursemanagement.dto.FeedbackDTO;
import project.demo.coursemanagement.dto.LessonDTO;
import project.demo.coursemanagement.entities.Cours;

import java.util.List;

/**
 * Service class for course catalog operations
 */
public class CourseCatalogService {

    private static CourseCatalogService instance;
    private final CourseCatalogDAO courseCatalogDAO;

    private CourseCatalogService() {
        this.courseCatalogDAO = new CourseCatalogDAOimp();
    }

    public static CourseCatalogService getInstance() {
        if (instance == null) {
            instance = new CourseCatalogService();
        }
        return instance;
    }

    public CourseDTO getCourseById(int id) {
        return courseCatalogDAO.getCourseInfoById(id);
    }

    public List<LessonDTO> getLessonsByCourseId(int courseId) {
        return courseCatalogDAO.getLessonsByCourseId(courseId);
    }

    public List<FeedbackDTO> getFeedbacksByCourseId(int courseId) {
        return courseCatalogDAO.getFeedbacksByCourseId(courseId);
    }
}
