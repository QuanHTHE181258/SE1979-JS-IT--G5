package project.demo.coursemanagement.service;

import project.demo.coursemanagement.dao.CourseCatalogDAO;
import project.demo.coursemanagement.dao.impl.CourseCatalogDAOimp;
import project.demo.coursemanagement.dto.CourseDTO;
import project.demo.coursemanagement.entities.Cours;

/**
 * Service class for course catalog operations
 */
public class CourseCatalogService {

    private static CourseCatalogService instance;
    private final CourseCatalogDAO courseCatalogDAO;

    private CourseCatalogService() {
        this.courseCatalogDAO = new CourseCatalogDAOimp();
    }

    public static CourseCatalogService getInstance() {
        if (instance == null) {
            instance = new CourseCatalogService();
        }
        return instance;
    }

    /**
     * Get a course by its ID
     * @param id the ID of the course
     * @return the course object or null if not found
     */
    public CourseDTO getCourseById(int id) {
        return courseCatalogDAO.getCourseInfoById(id);
    }
}
