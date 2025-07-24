package project.demo.coursemanagement.controllers;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.*;
import java.util.stream.Collectors;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import project.demo.coursemanagement.dto.CourseDTO;
import project.demo.coursemanagement.service.HomeService;

@WebServlet(name = "HomeServlet",urlPatterns = {"/home"})
public class HomeServlet extends HttpServlet {
    private HomeService homeService;

    @Override
    public void init() throws ServletException {
        super.init();
        this.homeService = new HomeService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<CourseDTO> allCourses = new ArrayList<>(homeService.getAllCourses());

        // Remove duplicates (CourseID-based)
        Map<Integer, CourseDTO> uniqueCourses = new LinkedHashMap<>();
        for (CourseDTO course : allCourses) {
            uniqueCourses.putIfAbsent(course.getCourseID(), course);
        }
        List<CourseDTO> filteredCourses = new ArrayList<>(uniqueCourses.values());

        // Highest Rated Courses
        List<CourseDTO> highestRatedCourses = filteredCourses.stream()
                .sorted(Comparator.comparing(
                        c -> c.getRating() != null ? -c.getRating() : 0.0
                ))
                .limit(3)
                .collect(Collectors.toList());

        // Paid Courses
        List<CourseDTO> paidCourses = filteredCourses.stream()
                .filter(c -> c.getPrice() != null && c.getPrice().compareTo(BigDecimal.ZERO) > 0)
                .sorted(Comparator.comparing(CourseDTO::getPrice).reversed())
                .limit(3)
                .collect(Collectors.toList());

        // Free Courses
        List<CourseDTO> freeCourses = filteredCourses.stream()
                .filter(c -> c.getPrice() != null && c.getPrice().compareTo(BigDecimal.ZERO) == 0)
                .limit(3)
                .collect(Collectors.toList());

        request.setAttribute("highestRatedCourses", highestRatedCourses);
        request.setAttribute("paidCourses", paidCourses);
        request.setAttribute("freeCourses", freeCourses);

        request.getRequestDispatcher("/WEB-INF/views/home.jsp").forward(request, response);
    }
}
