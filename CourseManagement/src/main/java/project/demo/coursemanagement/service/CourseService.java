package project.demo.coursemanagement.service;

import project.demo.coursemanagement.dao.CourseDAO;
import project.demo.coursemanagement.dao.impl.CourseDAOImpl;
import project.demo.coursemanagement.dto.CourseStatsDTO;

import java.util.List;

/**
 * Service class for course management
 */
public class CourseService {

    private final CourseDAO courseDAO;

    public CourseService() {
        this.courseDAO = new CourseDAOImpl();
    }

    /**
     * Get all courses with extra statistics
     */
    public List<CourseStatsDTO> getAllCoursesWithStats() {
        return courseDAO.getAllCoursesWithStats();
    }
    public List<CourseStatsDTO> getCoursesByCategory(Long categoryId) {
        return courseDAO.getCoursesByCategory(categoryId);
    }

}
