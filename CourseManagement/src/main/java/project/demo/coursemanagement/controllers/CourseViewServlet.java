package project.demo.coursemanagement.controllers;

import project.demo.coursemanagement.dto.CourseDTO;
import project.demo.coursemanagement.service.CourseService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
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

        // Get full list first
        List<CourseDTO> courses = courseService.getAllCourses();
        System.out.println("Total courses: " + courses.size());

        // Filter based on search keyword
        if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
            String keywordLower = searchKeyword.trim().toLowerCase();
            courses = courses.stream()
                    .filter(
                            course -> course.getTitle().toLowerCase().contains(keywordLower)
                            || course.getCourseCode().toLowerCase().contains(keywordLower)
                            || course.getShortDescription().toLowerCase().contains(keywordLower))
                    .collect(Collectors.toList());
        }

        System.out.println("Filtered courses: " + courses.size());

        request.setAttribute("courses", courses);
        request.getRequestDispatcher("WEB-INF/views/view-course.jsp").forward(request, response);
    }
}

