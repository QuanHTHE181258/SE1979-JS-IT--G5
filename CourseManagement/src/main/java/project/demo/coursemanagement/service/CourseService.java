package project.demo.coursemanagement.service;

import project.demo.coursemanagement.dao.CourseDAO;
import project.demo.coursemanagement.dao.impl.CourseDAOImpl;
import project.demo.coursemanagement.dao.CourseViewDAO;
import project.demo.coursemanagement.dao.impl.CourseViewDAOimp;
import project.demo.coursemanagement.dto.CourseStatsDTO;
import project.demo.coursemanagement.dto.CourseDTO;
import project.demo.coursemanagement.entities.Cours;

import java.util.List;

public class CourseService {

    private static CourseService instance;
    private final CourseDAO courseDAO;
    private final CourseViewDAO courseViewDAO;

    public CourseService() {
        this.courseDAO = new CourseDAOImpl();
        this.courseViewDAO = new CourseViewDAOimp();
    }

    public static CourseService getInstance() {
        if (instance == null) {
            instance = new CourseService();
        }
        return instance;
    }

    public List<CourseStatsDTO> getAllCoursesWithStats() {
        return courseDAO.getAllCoursesWithStats();
    }

    public List<CourseStatsDTO> getCoursesByCategory(Long categoryId) {
        return courseDAO.getCoursesByCategory(categoryId);
    }

    public void deleteCourseByCode(String courseCode) {
        courseDAO.deleteCourseByCode(courseCode);
    }

    public List<CourseDTO> getCoursesForManager(String keyword, Integer categoryId, int page, int pageSize) {
        return courseDAO.getCoursesForManager(keyword, categoryId, page, pageSize);
    }

    public int countCourses(String keyword, Integer categoryId) {
        return courseDAO.countCourses(keyword, categoryId);
    }

    public List<CourseDTO> getAllCourses() {
        List<CourseDTO> courses = courseDAO.getAllCourses();
        if (courses == null || courses.isEmpty()) {
            courses = courseViewDAO.getAllCourses();
        }
        return courses;
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

    // HoangQL's Commit
    public List<CourseDTO> getTopCourses(int limit) {
        return courseDAO.getTopCourses(limit);
    }

    public List<CourseDTO> getCoursesByPage(int page, int size) {
        return courseViewDAO.getCoursesByPage(page, size);
    }

    public int getTotalCourseCount() {
        return courseViewDAO.getTotalCourseCount();
    }
}
