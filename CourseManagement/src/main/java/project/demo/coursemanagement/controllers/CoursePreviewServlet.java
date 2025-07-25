package project.demo.coursemanagement.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import project.demo.coursemanagement.dto.CourseDTO;
import project.demo.coursemanagement.dto.FeedbackDTO;
import project.demo.coursemanagement.dto.LessonDTO;
import project.demo.coursemanagement.entities.Cours;
import project.demo.coursemanagement.service.CoursePreviewService;

import java.io.IOException;
import java.util.List;

@WebServlet("/courseDetails")
public class CoursePreviewServlet extends HttpServlet {
    private final CoursePreviewService courseCatalogService = CoursePreviewService.getInstance();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idParam = req.getParameter("courseID");

        if (idParam != null && !idParam.trim().isEmpty()) {
            try {
                int courseId = Integer.parseInt(idParam);
                CourseDTO course = courseCatalogService.getCourseById(courseId);
                List<LessonDTO> lessons = courseCatalogService.getLessonsByCourseId(courseId);
                List<FeedbackDTO> feedbacks = courseCatalogService.getFeedbacksByCourseId(courseId);

                if (course != null) {
                    req.setAttribute("course", course);
                    req.setAttribute("lessons", lessons);
                    req.setAttribute("feedbacks", feedbacks);
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

        req.getRequestDispatcher("/WEB-INF/views/course-details.jsp").forward(req, resp);
    }
}