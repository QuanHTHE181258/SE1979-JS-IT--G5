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

        if (username != null && !username.isEmpty()) {
            UserDTO instructor = instructorService.getInstructorInfo(username);
            request.setAttribute("instructor", instructor);
            List<CourseDTO> courses = instructorService.getCoursesByInstructorUsername(username);
            request.setAttribute("courses", courses);
        }

        request.getRequestDispatcher("WEB-INF/views/instructorInfo.jsp").forward(request, response);
    }
}
