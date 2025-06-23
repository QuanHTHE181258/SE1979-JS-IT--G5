package project.demo.coursemanagement.service;

import project.demo.coursemanagement.dao.CourseDAO;
import project.demo.coursemanagement.dao.impl.CourseDAOImpl;
import project.demo.coursemanagement.dto.CourseDTO;
import java.util.List;

public class CourseService {
    private final CourseDAO courseDAO = new CourseDAOImpl();

    public void deleteCourseByCode(String courseCode) {
        courseDAO.deleteCourseByCode(courseCode);
    }

    public List<CourseDTO> getCoursesForManager(String keyword, Integer categoryId, int page, int pageSize) {
        return courseDAO.getCoursesForManager(keyword, categoryId, page, pageSize);
    }

    public int countCourses(String keyword, Integer categoryId) {
        return courseDAO.countCourses(keyword, categoryId);
    }

    public List<CourseDTO> getRecentCourses(int limit) {
        return courseDAO.getRecentCourses(limit);
    }

    public CourseDTO getCourseByCode(String courseCode) {
        return courseDAO.getCourseByCode(courseCode);
    }

    public boolean updateCourse(CourseDTO course) {
        return courseDAO.updateCourse(course);
    }

    public List<CourseDTO> searchRecentCourses(String keyword, int limit) {
        return courseDAO.searchRecentCourses(keyword, limit);
    }

    public List<CourseDTO> getTopCourses(int limit) {
        return courseDAO.getTopCourses(limit);
    }
} 