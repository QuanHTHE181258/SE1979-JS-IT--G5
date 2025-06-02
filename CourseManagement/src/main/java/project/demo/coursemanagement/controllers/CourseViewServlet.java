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
        int page = 1;
        int size = 6; // số khóa học mỗi trang

        String pageParam = request.getParameter("page");
        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException ignored) {}
        }

        List<CourseDTO> courses = courseService.getCoursesByPage(page, size);
        int totalCourses = courseService.getTotalCourseCount();
        int totalPages = (int) Math.ceil((double) totalCourses / size);

        request.setAttribute("courses", courses);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);


        request.getRequestDispatcher("WEB-INF/views/view-course.jsp").forward(request, response);
    }
}

