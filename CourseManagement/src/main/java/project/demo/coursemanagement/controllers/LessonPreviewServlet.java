package project.demo.coursemanagement.controllers;

import project.demo.coursemanagement.dto.LessonDTO;
import project.demo.coursemanagement.service.LessonPreviewService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;

@WebServlet("/lessonPreview")
public class LessonPreviewServlet extends HttpServlet {
    private final LessonPreviewService lessonService = new LessonPreviewService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int lessonId = Integer.parseInt(request.getParameter("lessonID"));
            BigDecimal price = lessonService.getCoursePriceByLessonID(lessonId);

            LessonDTO lesson = lessonService.getLesson(lessonId);
            if (lesson != null) {
                request.setAttribute("lesson", lesson);
                request.getRequestDispatcher("WEB-INF/views/lesson-preview.jsp").forward(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Lesson not found");
            }
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid lesson ID");
        }
    }
}
