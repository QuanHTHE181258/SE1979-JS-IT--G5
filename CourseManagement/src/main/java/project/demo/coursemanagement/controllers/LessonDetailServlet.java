package project.demo.coursemanagement.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import project.demo.coursemanagement.entities.Lesson;
import project.demo.coursemanagement.service.LessonService;
import project.demo.coursemanagement.service.QuizService;
import project.demo.coursemanagement.service.MaterialService;
import project.demo.coursemanagement.entities.Quiz;
import project.demo.coursemanagement.entities.Material;
import java.util.List;
import java.io.IOException;

@WebServlet(name = "LessonDetailServlet", urlPatterns = {"/lesson-details"})
public class LessonDetailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String lessonIdStr = request.getParameter("id");
        if (lessonIdStr == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing lesson id");
            return;
        }
        int lessonId;
        try {
            lessonId = Integer.parseInt(lessonIdStr);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid lesson id");
            return;
        }
        LessonService lessonService = new LessonService();
        Lesson lesson = lessonService.getLessonById(lessonId);
        QuizService quizService = new QuizService();
        MaterialService materialService = new MaterialService();
        List<Quiz> quizzes = quizService.getQuizzesByLessonId(lessonId);
        List<Material> materials = materialService.getMaterialsByLessonId(lessonId);
        request.setAttribute("lesson", lesson);
        request.setAttribute("quizzes", quizzes);
        request.setAttribute("materials", materials);
        // Lấy danh sách lesson cùng course để hiển thị lessonList
        List<Lesson> lessonList = null;
        if (lesson != null && lesson.getCourseID() != null) {
            lessonList = lessonService.getLessonsByCourseId(lesson.getCourseID().getId());
        }
        request.setAttribute("lessonList", lessonList);

        // Debug log
        System.out.println("lesson: " + lesson);
        System.out.println("lesson.getCourseID(): " + (lesson != null ? lesson.getCourseID() : null));
        System.out.println("lesson.getCourseID().getId(): " + (lesson != null && lesson.getCourseID() != null ? lesson.getCourseID().getId() : null));
        System.out.println("lessonList: " + lessonList);
        System.out.println("lessonList size: " + (lessonList == null ? "null" : lessonList.size()));

        // Xác định prevLessonId và nextLessonId
        Integer prevLessonId = null;
        Integer nextLessonId = null;
        if (lessonList != null && lesson != null) {
            for (int i = 0; i < lessonList.size(); i++) {
                if (lessonList.get(i).getId().equals(lesson.getId())) {
                    if (i > 0) prevLessonId = lessonList.get(i - 1).getId();
                    if (i < lessonList.size() - 1) nextLessonId = lessonList.get(i + 1).getId();
                    break;
                }
            }
        }
        request.setAttribute("prevLessonId", prevLessonId);
        request.setAttribute("nextLessonId", nextLessonId);

        request.getRequestDispatcher("WEB-INF/views/lesson-detail.jsp").forward(request, response);
    }
}
