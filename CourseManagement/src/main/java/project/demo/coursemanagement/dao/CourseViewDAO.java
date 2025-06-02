package project.demo.coursemanagement.dao;

import project.demo.coursemanagement.dto.CourseDTO;
import project.demo.coursemanagement.entities.Cours;

import java.util.List;

/**
 * Data Access Object interface for course view operations
 */
public interface CourseViewDAO {

    /**
     * Get a course by its ID
     * @param id the ID of the course
     * @return the course object or null if not found
     */
    Cours getCourseById(int id);

    /**
     * Get all courses
     * @return a list of all courses
     */
    List<CourseDTO> getAllCourses();

    /**
     * Get courses by page
     * @param page the page number
     * @param size the page size
     * @return a list of courses for the specified page
     */
    List<CourseDTO> getCoursesByPage(int page, int size);

    /**
     * Get the total number of courses
     * @return the total number of courses
     */
    int getTotalCourseCount();
}
