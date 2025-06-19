package project.demo.coursemanagement.service;

import project.demo.coursemanagement.dao.CourseViewDAO;
import project.demo.coursemanagement.dao.impl.CourseViewDAOimp;
import project.demo.coursemanagement.dto.CourseDTO;
import project.demo.coursemanagement.entities.Cours;
import java.util.List;

/**
 * Service class for course-related operations
 */
public class CourseService {

    private static CourseService instance;
    private final CourseViewDAO courseViewDAO;

    private CourseService(){
        this.courseViewDAO = new CourseViewDAOimp();
    }

    public static CourseService getInstance(){
        if(instance == null){
            instance = new CourseService();
        }
        return instance;
    }

    /**
     * Get all courses
     * @return a list of all courses
     */
    public List<CourseDTO> getAllCourses() {
        return courseViewDAO.getAllCourses();
    }

    /**
     * Get courses by page
     * @param page the page number
     * @param size the page size
     * @return a list of courses for the specified page
     */
    public List<CourseDTO> getCoursesByPage(int page, int size) {
        return courseViewDAO.getCoursesByPage(page, size);
    }

    /**
     * Get the total number of courses
     * @return the total number of courses
     */
    public int getTotalCourseCount() {
        return courseViewDAO.getTotalCourseCount();
    }
}
