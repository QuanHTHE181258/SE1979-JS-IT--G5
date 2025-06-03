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

    // Get most popular courses (sorted by maxStudents, descending)
    public List<CourseDTO> getMostPopularCourses() {
        List<CourseDTO> allCourses = new ArrayList<>(homeDAO.getAllCourses());

        // Loại bỏ trùng lặp dựa trên courseCode
        Map<String, CourseDTO> uniqueCourses = new LinkedHashMap<>();
        for (CourseDTO course : allCourses) {
            uniqueCourses.putIfAbsent(course.getCourseCode(), course);
        }
        allCourses = new ArrayList<>(uniqueCourses.values());

        // Sắp xếp theo maxStudents giảm dần
        allCourses.sort((c1, c2) -> Integer.compare(c2.getMaxStudents(), c1.getMaxStudents()));

        // Trả về tối đa 3 khóa học
        return allCourses.size() > 3 ? new ArrayList<>(allCourses.subList(0, 3)) : new ArrayList<>(allCourses);
    }

    // Get paid courses (sorted by price, descending)
    public List<CourseDTO> getPaidCourses() {
        List<CourseDTO> allCourses = new ArrayList<>(homeDAO.getAllCourses());

        // Loại bỏ trùng lặp dựa trên courseCode
        Map<String, CourseDTO> uniqueCourses = new LinkedHashMap<>();
        for (CourseDTO course : allCourses) {
            uniqueCourses.putIfAbsent(course.getCourseCode(), course);
        }
        allCourses = new ArrayList<>(uniqueCourses.values());

        // Loại bỏ các khóa học miễn phí
        allCourses.removeIf(course -> course.getPrice().compareTo(BigDecimal.ZERO) == 0);

        // Sắp xếp theo giá giảm dần
        allCourses.sort((c1, c2) -> c2.getPrice().compareTo(c1.getPrice()));

        // Trả về tối đa 3 khóa học
        return allCourses.size() > 3 ? new ArrayList<>(allCourses.subList(0, 3)) : new ArrayList<>(allCourses);
    }

    // Get free courses (price = 0)
    public List<CourseDTO> getFreeCourses() {
        List<CourseDTO> allCourses = new ArrayList<>(homeDAO.getAllCourses());

        // Loại bỏ trùng lặp dựa trên courseCode
        Map<String, CourseDTO> uniqueCourses = new LinkedHashMap<>();
        for (CourseDTO course : allCourses) {
            uniqueCourses.putIfAbsent(course.getCourseCode(), course);
        }
        allCourses = new ArrayList<>(uniqueCourses.values());

        // Loại bỏ các khóa học có giá khác 0
        allCourses.removeIf(course -> course.getPrice().compareTo(BigDecimal.ZERO) != 0);

        // Trả về tối đa 3 khóa học
        return allCourses.size() > 3 ? new ArrayList<>(allCourses.subList(0, 3)) : new ArrayList<>(allCourses);
    }
}