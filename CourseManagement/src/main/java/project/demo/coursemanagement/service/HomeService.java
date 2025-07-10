package project.demo.coursemanagement.service;

import project.demo.coursemanagement.dao.HomeDAO;
import project.demo.coursemanagement.dao.impl.HomeDAOimp;
import project.demo.coursemanagement.dto.CourseDTO;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class HomeService {
    private HomeDAO homeDAO;

    public HomeService() {
        this.homeDAO = new HomeDAOimp();
    }

    // Get highest rated courses (sorted by rating, descending)
    public List<CourseDTO> getHighestRatedCourses() {
        List<CourseDTO> allCourses = new ArrayList<>(homeDAO.getAllCourses());

        // Remove duplicates based on courseID
        Map<Integer, CourseDTO> uniqueCourses = new LinkedHashMap<>();
        for (CourseDTO course : allCourses) {
            uniqueCourses.putIfAbsent(course.getCourseID(), course);
        }
        allCourses = new ArrayList<>(uniqueCourses.values());

        // Sort by rating in descending order (handle null ratings)
        allCourses.sort((c1, c2) -> {
            Double r1 = c1.getRating() != null ? c1.getRating() : 0.0;
            Double r2 = c2.getRating() != null ? c2.getRating() : 0.0;
            return r2.compareTo(r1);
        });

        // Return up to 3 courses
        return allCourses.size() > 3 ? new ArrayList<>(allCourses.subList(0, 3)) : new ArrayList<>(allCourses);
    }

    // Get paid courses (sorted by price, descending)
    public List<CourseDTO> getPaidCourses() {
        List<CourseDTO> allCourses = new ArrayList<>(homeDAO.getAllCourses());

        // Remove duplicates based on courseID
        Map<Integer, CourseDTO> uniqueCourses = new LinkedHashMap<>();
        for (CourseDTO course : allCourses) {
            uniqueCourses.putIfAbsent(course.getCourseID(), course);
        }
        allCourses = new ArrayList<>(uniqueCourses.values());

        // Remove free courses
        allCourses.removeIf(course -> course.getPrice() == null || course.getPrice().compareTo(BigDecimal.ZERO) == 0);

        // Sort by price in descending order
        allCourses.sort((c1, c2) -> c2.getPrice().compareTo(c1.getPrice()));

        // Return up to 3 courses
        return allCourses.size() > 3 ? new ArrayList<>(allCourses.subList(0, 3)) : new ArrayList<>(allCourses);
    }

    // Get free courses (price = 0)
    public List<CourseDTO> getFreeCourses() {
        List<CourseDTO> allCourses = new ArrayList<>(homeDAO.getAllCourses());

        // Remove duplicates based on courseID
        Map<Integer, CourseDTO> uniqueCourses = new LinkedHashMap<>();
        for (CourseDTO course : allCourses) {
            uniqueCourses.putIfAbsent(course.getCourseID(), course);
        }
        allCourses = new ArrayList<>(uniqueCourses.values());

        // Keep only free courses
        allCourses.removeIf(course -> course.getPrice() == null || course.getPrice().compareTo(BigDecimal.ZERO) != 0);

        // Return up to 3 courses
        return allCourses.size() > 3 ? new ArrayList<>(allCourses.subList(0, 3)) : new ArrayList<>(allCourses);
    }
}