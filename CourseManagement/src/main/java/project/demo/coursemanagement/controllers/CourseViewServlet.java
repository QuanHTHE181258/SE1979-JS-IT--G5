package project.demo.coursemanagement.controllers;

import project.demo.coursemanagement.dto.CourseDTO;
import project.demo.coursemanagement.service.CourseService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet(name = "CourseViewServlet", urlPatterns = {"/course"})
public class CourseViewServlet extends HttpServlet {
    private CourseService courseService = CourseService.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("CourseViewServlet: doGet() method called");

        // Get optional search/filter parameters
        String searchKeyword = request.getParameter("search");

        // Get pagination parameters
        int page = 1;
        int size = 6; // number of courses per page
        String pageParam = request.getParameter("page");
        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException ignored) {}
        }

        List<CourseDTO> courses;
        int totalCourses;
        int totalPages;

        // If search is provided, use search functionality
        if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
            // Get full list first for searching
            List<CourseDTO> allCourses = courseService.getAllCourses();
            System.out.println("Total courses before filtering: " + allCourses.size());

            // Filter based on search keyword
            String keywordLower = searchKeyword.trim().toLowerCase();
            courses = allCourses.stream()
                    .filter(
                            course -> course.getCourseTitle().toLowerCase().contains(keywordLower)
                            || course.getCourseDescription().toLowerCase().contains(keywordLower))
                    .collect(Collectors.toList());

            totalCourses = courses.size();

            // Apply pagination to filtered results
            int fromIndex = (page - 1) * size;
            int toIndex = Math.min(fromIndex + size, courses.size());

            if (fromIndex < courses.size()) {
                courses = courses.subList(fromIndex, toIndex);
            } else {
                courses = new ArrayList<>();
            }
        } else {
            // Use pagination directly from database if no search
            courses = courseService.getCoursesByPage(page, size);
            totalCourses = courseService.getTotalCourseCount();
        }

        totalPages = (int) Math.ceil((double) totalCourses / size);

        // Set attributes for the view
        request.setAttribute("courses", courses);
        request.setAttribute("listCourseDto", courses);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("searchKeyword", searchKeyword);
        request.getRequestDispatcher("WEB-INF/views/view-course.jsp").forward(request, response);
    }
}
