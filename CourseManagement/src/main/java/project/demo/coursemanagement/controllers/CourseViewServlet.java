package project.demo.coursemanagement.controllers;

import project.demo.coursemanagement.dto.CourseDTO;
import project.demo.coursemanagement.entities.Cours;
import project.demo.coursemanagement.service.CourseService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "CourseViewServlet", urlPatterns = {"/course"})
public class CourseViewServlet extends HttpServlet {
    private CourseService courseService = new CourseService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("CourseViewServlet: doGet() method called");
        List<CourseDTO> courses = courseService.getAllCourses();
        System.out.println("Number of courses in servlet: " + courses.size());
        request.setAttribute("courses", courses);
        request.getRequestDispatcher("WEB-INF/views/view-course.jsp").forward(request, response);
    }
}

