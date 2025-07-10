package project.demo.coursemanagement.dao;

import project.demo.coursemanagement.dto.CourseDTO;
import project.demo.coursemanagement.dto.CourseStatsDTO;

import java.util.List;

public interface CourseDAO {
    List<CourseStatsDTO> getAllCoursesWithStats();
    List<CourseStatsDTO> getCoursesByCategory(Long categoryId);
    boolean insertCourse(project.demo.coursemanagement.entities.Cours course);
    boolean updateCourse(project.demo.coursemanagement.entities.Cours course);
    void deleteCourseByCode(String courseCode);
    List<CourseDTO> getCoursesForManager(String keyword, Integer categoryId, int page, int pageSize);
    int countCourses(String keyword, Integer categoryId);
    List<CourseDTO> getRecentCourses(int limit);
    CourseDTO getCourseByCode(String courseCode);
    boolean updateCourse(CourseDTO course);
    List<CourseDTO> searchRecentCourses(String keyword, int limit);
    List<CourseDTO> getTopCourses(int limit);

}
