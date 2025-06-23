package project.demo.coursemanagement.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import project.demo.coursemanagement.service.LessonService;
import java.io.IOException;

@WebServlet(name = "ViewListLessonServlet", urlPatterns = {"/course-lessons"})
public class ViewListLessonServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String courseIdStr = request.getParameter("id");
        if (courseIdStr == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing course id");
            return;
        }
        int courseId;
        try {
            courseId = Integer.parseInt(courseIdStr);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid course id");
            return;
        }
        LessonService lessonService = new LessonService();
        var lessons = lessonService.getLessonsWithStatsByCourseId(courseId);
        request.setAttribute("lessons", lessons);
        request.setAttribute("courseId", courseId);
        request.getRequestDispatcher("WEB-INF/views/list-lesson.jsp").forward(request, response);
    }
}
