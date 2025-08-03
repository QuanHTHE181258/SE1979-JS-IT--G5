package project.demo.coursemanagement.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import project.demo.coursemanagement.dao.CompletedLessonDAO;
import project.demo.coursemanagement.dao.EnrollmentDAO;
import project.demo.coursemanagement.dao.impl.LessonDAOImpl;
import project.demo.coursemanagement.entities.Lesson;
import project.demo.coursemanagement.entities.User;

import java.io.IOException;

@WebServlet("/complete-lesson")
public class CompleteLessonServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int lessonId = Integer.parseInt(request.getParameter("lessonId"));

            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("loggedInUser");
            if (user == null) {
                response.sendRedirect("login");
                return;
            }

            LessonDAOImpl lessonDAO = new LessonDAOImpl();
            Lesson lesson = lessonDAO.getLessonById(lessonId);

            if (lesson == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }

            int userId = user.getId();
            int courseId = lesson.getCourseId();
            CompletedLessonDAO.markLessonCompleted(userId, lessonId);

            // Tổng số bài học
            int totalLessons = LessonDAOImpl.getTotalLessonsByCourse(courseId);

            // Lấy tiến độ hiện tại
            int currentProgress = EnrollmentDAO.getCurrentProgress(userId, courseId);

            // Tăng lên 1 nếu chưa hoàn thành 100%
            int newProgress = Math.min(100, currentProgress + (100 / totalLessons));

            // Cập nhật lại tiến độ
            EnrollmentDAO.updateProgressPercentage(userId, courseId, newProgress);

            response.sendRedirect("learning?lessonId=" + lessonId);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
