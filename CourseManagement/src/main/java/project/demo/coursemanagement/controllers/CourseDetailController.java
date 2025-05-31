package project.demo.coursemanagement.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.hibernate.Hibernate;
import project.demo.coursemanagement.entities.Course;
import project.demo.coursemanagement.service.CourseService;

import java.io.IOException;

@WebServlet("/course/detail")
public class CourseDetailController extends HttpServlet {

    private CourseService courseService;

    @Override
    public void init() throws ServletException {
        courseService = CourseService.getInstance();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get "id" from the query string and parse to int
            String courseIdParam = request.getParameter("id");

            if (courseIdParam == null || courseIdParam.isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Course ID is required.");
                return;
            }

            int courseId = Integer.parseInt(courseIdParam);

            // Get course from service
            Course course = courseService.getCourseBy(courseId);

            // Force load lazy fields
            Hibernate.initialize(course.getTeacher());
            Hibernate.initialize(course.getCategory());

            // Optionally, access their fields to ensure they’re not lazy proxies
            course.getTeacher().getFirstName(); // or .getName() if that's your method
            course.getCategory().getCategoryName();
            if (course == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Course not found.");
                return;
            }

            // Set course as request attribute and forward to JSP
            request.setAttribute("course", course);
            request.getRequestDispatcher("view-course.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid course ID format.");
        } catch (Exception e) {
            // Optional: log exception
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while retrieving the course.");
        }
    }

}

