package project.demo.coursemanagement.dao;

import project.demo.coursemanagement.dto.CourseDTO;
import java.util.List;

public interface CourseDAO {
    void deleteCourseByCode(String courseCode);
    List<CourseDTO> getCoursesForManager(String keyword, Integer categoryId, int page, int pageSize);
    int countCourses(String keyword, Integer categoryId);
    List<CourseDTO> getRecentCourses(int limit);
    CourseDTO getCourseByCode(String courseCode);
    boolean updateCourse(CourseDTO course);
    List<CourseDTO> searchRecentCourses(String keyword, int limit);
    List<CourseDTO> getTopCourses(int limit);
}
