package project.demo.coursemanagement.controllers;

import project.demo.coursemanagement.dao.impl.LessonDAOImpl;
import project.demo.coursemanagement.entities.Lesson;
import project.demo.coursemanagement.entities.Cours;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.Instant;

@WebServlet(name = "AddLessonServlet", urlPatterns = {"/add-lesson"})
public class AddLessonServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String status = request.getParameter("status");
        boolean isFreePreview = Boolean.parseBoolean(request.getParameter("isFreePreview"));
        int courseId = Integer.parseInt(request.getParameter("courseId"));

        Lesson lesson = new Lesson();
        lesson.setTitle(title);
        lesson.setContent(content);
        lesson.setStatus(status);
        lesson.setIsFreePreview(isFreePreview);
        lesson.setCreatedAt(Instant.now());
        Cours course = new Cours();
        course.setId(courseId);
        lesson.setCourseID(course);

        LessonDAOImpl dao = new LessonDAOImpl();
        boolean success = dao.addLesson(lesson);

        if (success) {
            response.sendRedirect("course-lessons?id=" + courseId);
        } else {
            request.setAttribute("error", "Failed to add lesson.");
            request.getRequestDispatcher("WEB-INF/views/add-lesson.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("WEB-INF/views/add-lesson.jsp").forward(request, response);
    }
}

