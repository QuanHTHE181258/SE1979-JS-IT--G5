package project.demo.coursemanagement.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import project.demo.coursemanagement.dto.CourseDTO;
import project.demo.coursemanagement.dto.UserDTO;
import project.demo.coursemanagement.service.InstructorInfoService;

import java.io.IOException;
import java.util.List;

@WebServlet("/instructorInfo")
public class InstructorInfoServlet extends HttpServlet {

    private final InstructorInfoService instructorService = InstructorInfoService.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        int page = 1;
        int size = 6;

        String pageParam = request.getParameter("page");
        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException ignored) {}
        }

        if (username != null && !username.isEmpty()) {
            UserDTO instructor = instructorService.getInstructorInfo(username);
            request.setAttribute("instructor", instructor);

            List<CourseDTO> courses = instructorService.getCoursesByInstructorUsernameAndPage(username, page, size);
            int totalCourses = instructorService.countCoursesByInstructor(username);
            int totalPages = (int) Math.ceil((double) totalCourses / size);

            request.setAttribute("courses", courses);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
        }

        request.getRequestDispatcher("WEB-INF/views/instructor-info.jsp").forward(request, response);
    }

}
