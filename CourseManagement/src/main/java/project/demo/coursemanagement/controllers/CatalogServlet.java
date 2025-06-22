package project.demo.coursemanagement.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import project.demo.coursemanagement.dto.CourseDTO;
import project.demo.coursemanagement.entities.Cours;
import project.demo.coursemanagement.service.CourseCatalogService;

import java.io.IOException;

@WebServlet("/catalog")
public class CatalogServlet extends HttpServlet {
    private final CourseCatalogService courseCatalogService = CourseCatalogService.getInstance();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idParam = req.getParameter("courseID");

        if (idParam != null && !idParam.trim().isEmpty()) {
            try {
                int courseId = Integer.parseInt(idParam);
                CourseDTO course = courseCatalogService.getCourseById(courseId);
                if (course != null) {
                    req.setAttribute("course", course);
                } else {
                    req.setAttribute("error", "Course not found.");
                    resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
                }
            } catch (NumberFormatException e) {
                req.setAttribute("error", "Invalid course ID.");
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            }
        } else {
            req.setAttribute("error", "Course ID is required.");
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        }

        req.getRequestDispatcher("/WEB-INF/views/course-catalog.jsp").forward(req, resp);
    }
}