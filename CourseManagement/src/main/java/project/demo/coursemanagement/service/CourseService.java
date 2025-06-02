package project.demo.coursemanagement.service;

import project.demo.coursemanagement.dao.CourseViewDAOimp;
import project.demo.coursemanagement.dto.CourseDTO;
import project.demo.coursemanagement.entities.Cours;
import java.util.List;

public class CourseService {
    private CourseViewDAOimp courseDAO;

    public CourseService() {
        this.courseDAO = new CourseViewDAOimp();
    }

    public List<CourseDTO> getAllCourses() {
        System.out.println("CourseService: getAllCourses() method called");
        return courseDAO.getAllCourses();
    }

    public List<CourseDTO> getCoursesByPage(int page, int size) {
        return courseDAO.getCoursesByPage(page, size);
    }

    public int getTotalCourseCount() {
        return courseDAO.getTotalCourseCount();
    }
}