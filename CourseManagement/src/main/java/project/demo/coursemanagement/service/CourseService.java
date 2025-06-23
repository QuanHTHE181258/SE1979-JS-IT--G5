package project.demo.coursemanagement.service;

import project.demo.coursemanagement.dao.CourseDAO;
import project.demo.coursemanagement.dao.impl.CourseDAOImpl;
import project.demo.coursemanagement.dto.CourseStatsDTO;
import project.demo.coursemanagement.dto.CourseDTO;

import java.util.List;

/**
 * Service class for course management
 * Combines functionality from both HEAD and origin/Minhdd commits
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

    /**
     * Get courses by category with statistics
     */
    public List<CourseStatsDTO> getCoursesByCategory(Long categoryId) {
        return courseDAO.getCoursesByCategory(categoryId);
    }

    /**
     * Delete course by course code
     */
    public void deleteCourseByCode(String courseCode) {
        courseDAO.deleteCourseByCode(courseCode);
    }

    /**
     * Get paginated courses for manager with optional filtering
     */
    public List<CourseDTO> getCoursesForManager(String keyword, Integer categoryId, int page, int pageSize) {
        return courseDAO.getCoursesForManager(keyword, categoryId, page, pageSize);
    }

    /**
     * Count courses with optional filtering
     */
    public int countCourses(String keyword, Integer categoryId) {
        return courseDAO.countCourses(keyword, categoryId);
    }

    /**
     * Get recent courses limited by count
     */
    public List<CourseDTO> getRecentCourses(int limit) {
        return courseDAO.getRecentCourses(limit);
    }

    /**
     * Get single course by course code
     */
    public CourseDTO getCourseByCode(String courseCode) {
        return courseDAO.getCourseByCode(courseCode);
    }

    /**
     * Update course using CourseDTO
     */
    public boolean updateCourse(CourseDTO course) {
        return courseDAO.updateCourse(course);
    }

    /**
     * Search recent courses by keyword
     */
    public List<CourseDTO> searchRecentCourses(String keyword, int limit) {
        return courseDAO.searchRecentCourses(keyword, limit);
    }

    /**
     * Get top courses by enrollment count
     */
    public List<CourseDTO> getTopCourses(int limit) {
        return courseDAO.getTopCourses(limit);
    }
}