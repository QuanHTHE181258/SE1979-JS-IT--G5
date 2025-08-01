package project.demo.coursemanagement.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import project.demo.coursemanagement.dao.impl.LessonDAOImpl;
import project.demo.coursemanagement.entities.Cours;
import project.demo.coursemanagement.entities.Lesson;
import project.demo.coursemanagement.entities.User;

import java.io.IOException;
import java.time.Instant;

@WebServlet("/edit-lesson")
public class EditLessonServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("loggedInUser");
        if (user == null) {
            response.sendRedirect("login");
            return;
        }
        String lessonId = request.getParameter("id");
        if (lessonId != null && !lessonId.isEmpty()) {
            LessonDAOImpl dao = new LessonDAOImpl();
            Lesson lesson = dao.getLessonById(Integer.parseInt(lessonId));
            if (lesson != null) {
                request.setAttribute("lesson", lesson);
                request.getRequestDispatcher("WEB-INF/views/edit-lesson.jsp").forward(request, response);
                return;
            }
        }
        response.sendRedirect("list-lesson");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String title = request.getParameter("title");
            String content = request.getParameter("content");
            String status = request.getParameter("status");
            boolean isFreePreview = "on".equals(request.getParameter("isFreePreview"));
            int courseId = Integer.parseInt(request.getParameter("courseId"));

            LessonDAOImpl dao = new LessonDAOImpl();
            Lesson lesson = dao.getLessonById(id);

            if (lesson != null) {
                lesson.setTitle(title);
                lesson.setContent(content);
                lesson.setStatus(status);
                lesson.setIsFreePreview(isFreePreview);

                boolean success = dao.updateLesson(lesson);

                if (success) {
                    response.sendRedirect("course-lessons?id=" + courseId);
                } else {
                    request.setAttribute("error", "Failed to update lesson.");
                    request.setAttribute("lesson", lesson);
                    request.getRequestDispatcher("WEB-INF/views/edit-lesson.jsp").forward(request, response);
                }
            } else {
                response.sendRedirect("list-lesson");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("list-lesson");
        }
    }
}
