package project.demo.coursemanagement.service;

import project.demo.coursemanagement.dao.HomeDAO;
import project.demo.coursemanagement.dao.HomeDAOimp;
import project.demo.coursemanagement.dto.CourseDTO;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public class HomeService {
    private HomeDAO homeDAO;

    public HomeService() {
        this.homeDAO = new HomeDAOimp();
    }

    // Get most popular courses (sorted by maxStudents, descending)
    public List<CourseDTO> getMostPopularCourses() {
        List<CourseDTO> allCourses = new ArrayList<>(homeDAO.getAllCourses());
        allCourses.sort((c1, c2) -> Integer.compare(c2.getMaxStudents(), c1.getMaxStudents()));
        return allCourses.size() > 3 ? new ArrayList<>(allCourses.subList(0, 3)) : new ArrayList<>(allCourses);
    }

    // Get paid courses (sorted by price, descending)
    public List<CourseDTO> getPaidCourses() {
        List<CourseDTO> allCourses = new ArrayList<>(homeDAO.getAllCourses());
        allCourses.removeIf(course -> course.getPrice().compareTo(BigDecimal.ZERO) == 0);
        allCourses.sort((c1, c2) -> c2.getPrice().compareTo(c1.getPrice()));
        return allCourses.size() > 3 ? new ArrayList<>(allCourses.subList(0, 3)) : new ArrayList<>(allCourses);
    }

    // Get free courses (price = 0)
    public List<CourseDTO> getFreeCourses() {
        List<CourseDTO> allCourses = new ArrayList<>(homeDAO.getAllCourses());
        allCourses.removeIf(course -> course.getPrice().compareTo(BigDecimal.ZERO) != 0);
        return allCourses.size() > 3 ? new ArrayList<>(allCourses.subList(0, 3)) : new ArrayList<>(allCourses);
    }
}