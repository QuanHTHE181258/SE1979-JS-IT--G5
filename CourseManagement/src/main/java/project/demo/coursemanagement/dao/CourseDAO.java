package project.demo.coursemanagement.dao;

import project.demo.coursemanagement.dto.CourseStatsDTO;

import java.util.List;

public interface CourseDAO {
    List<CourseStatsDTO> getAllCoursesWithStats();
    List<CourseStatsDTO> getCoursesByCategory(Long categoryId);
    boolean insertCourse(project.demo.coursemanagement.entities.Cours course);

}
