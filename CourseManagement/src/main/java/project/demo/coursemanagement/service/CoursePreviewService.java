package project.demo.coursemanagement.service;

import project.demo.coursemanagement.dao.CoursePreviewDAO;
import project.demo.coursemanagement.dao.impl.CoursePreviewDAOimp;
import project.demo.coursemanagement.dto.CourseDTO;
import project.demo.coursemanagement.dto.FeedbackDTO;
import project.demo.coursemanagement.dto.LessonDTO;

import java.util.List;

/**
 * Service class for course catalog operations
 */
public class CoursePreviewService {

    private static CoursePreviewService instance;
    private final CoursePreviewDAO coursePreviewDAO;

    private CoursePreviewService() {
        this.coursePreviewDAO = new CoursePreviewDAOimp();
    }

    public static CoursePreviewService getInstance() {
        if (instance == null) {
            instance = new CoursePreviewService();
        }
        return instance;
    }

    public CourseDTO getCourseById(int id) {
        return coursePreviewDAO.getCourseInfoById(id);
    }

    public List<LessonDTO> getLessonsByCourseId(int courseId) {
        return coursePreviewDAO.getLessonsByCourseId(courseId);
    }

    public List<FeedbackDTO> getFeedbacksByCourseId(int courseId) {
        return coursePreviewDAO.getFeedbacksByCourseId(courseId);
    }
}
