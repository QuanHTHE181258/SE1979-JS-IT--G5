package project.demo.coursemanagement.dao;

import project.demo.coursemanagement.dto.CourseDTO;
import project.demo.coursemanagement.entities.Cours;

import java.util.List;

/**
 * Data Access Object interface for course view operations
 */
public interface CourseViewDAO {

    Cours getCourseById(int id);

    List<CourseDTO> getAllCourses();

    List<CourseDTO> getCoursesByPage(int page, int size);

    int getTotalCourseCount();
}
