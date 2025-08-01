package project.demo.coursemanagement.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import project.demo.coursemanagement.dao.LessonDAO;
import project.demo.coursemanagement.dao.impl.LessonDAOImpl;
import project.demo.coursemanagement.dto.LessonStats;
import project.demo.coursemanagement.entities.Lesson;
import project.demo.coursemanagement.entities.User;

import java.io.IOException;
import java.util.List;

@WebServlet("/learning")
public class LearningPageServlet extends HttpServlet {
    private LessonDAO lessonDAO;

    @Override
    public void init() throws ServletException {
        lessonDAO = new LessonDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("loggedInUser");
        if (user == null) {
            response.sendRedirect("login");
            return;
        }
        String lessonIdStr = request.getParameter("lessonId");
        if (lessonIdStr == null || lessonIdStr.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Lesson ID is required.");
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
            return;
        }
        try {
            int lessonId = Integer.parseInt(lessonIdStr);
            Lesson lesson = lessonDAO.getLessonById(lessonId);
            if (lesson == null) {
                request.setAttribute("errorMessage", "Lesson not found.");
                request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
                return;
            }
            // Load quizzes and materials for this lesson
            request.setAttribute("lesson", lesson);
            request.setAttribute("quizzes", lessonDAO.getQuizzesByLessonId(lessonId));
            request.setAttribute("materials", lessonDAO.getMaterialsByLessonId(lessonId));
            // Load all lessons for the course for navigation
            List<LessonStats> lessons = lessonDAO.getLessonSummaryByCourseId(lesson.getCourseId());
            request.setAttribute("lessons", lessons);
            // Also set lessonList for sidebar compatibility
            List<Lesson> lessonList = lessonDAO.getLessonsByCourseId(lesson.getCourseId());
            request.setAttribute("lessonList", lessonList);
            // Find previous and next lessonId
            Integer prevLessonId = null;
            Integer nextLessonId = null;
            for (int i = 0; i < lessonList.size(); i++) {
                if (lessonList.get(i).getId() == lessonId) {
                    if (i > 0) prevLessonId = lessonList.get(i - 1).getId();
                    if (i < lessonList.size() - 1) nextLessonId = lessonList.get(i + 1).getId();
                    break;
                }
            }
            request.setAttribute("prevLessonId", prevLessonId);
            request.setAttribute("nextLessonId", nextLessonId);
            request.getRequestDispatcher("/WEB-INF/views/learning-page.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid lesson ID format.");
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error loading lesson: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
        }
    }
}
