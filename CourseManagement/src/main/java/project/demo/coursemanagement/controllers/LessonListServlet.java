package project.demo.coursemanagement.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import project.demo.coursemanagement.dao.LessonDAO;
import project.demo.coursemanagement.dao.impl.LessonDAOImpl;
import project.demo.coursemanagement.dto.LessonStats;
import project.demo.coursemanagement.entities.User;

import java.io.IOException;
import java.util.List;

@WebServlet("/lessons")
public class LessonListServlet extends HttpServlet {
    private LessonDAO lessonDAO;

    @Override
    public void init() throws ServletException {
        lessonDAO = new LessonDAOImpl();
        System.out.println("LessonListServlet initialized"); // Debug log
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("loggedInUser");
        if (user == null) {
            response.sendRedirect("login");
            return;
        }
        System.out.println("LessonListServlet doGet called"); // Debug log

        String courseIdStr = request.getParameter("courseId");
        System.out.println("Course ID parameter: " + courseIdStr); // Debug log

        if (courseIdStr == null || courseIdStr.trim().isEmpty()) {
            System.out.println("Course ID is missing"); // Debug log
            request.setAttribute("errorMessage", "Vui lòng cung cấp ID khóa học");
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
            return;
        }

        try {
            int courseId = Integer.parseInt(courseIdStr);
            System.out.println("Getting lessons for courseId: " + courseId); // Debug log

            List<LessonStats> lessons = lessonDAO.getLessonSummaryByCourseId(courseId);
            System.out.println("Found " + (lessons != null ? lessons.size() : "null") + " lessons"); // Debug log

            if (lessons != null) {
                System.out.println("First lesson title: " +
                        (lessons.isEmpty() ? "no lessons" :
                                (lessons.get(0).getLesson() != null ? lessons.get(0).getLesson().getTitle() : "null lesson")));
            }

            request.setAttribute("lessons", lessons);
            request.setAttribute("courseId", courseId);

            System.out.println("Forwarding to lesson-summary.jsp"); // Debug log
            request.getRequestDispatcher("/WEB-INF/views/lesson-summary.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            System.out.println("Invalid course ID format: " + courseIdStr); // Debug log
            request.setAttribute("errorMessage", "ID khóa học không hợp lệ");
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
        } catch (Exception e) {
            System.out.println("Error in LessonListServlet: " + e.getMessage()); // Debug log
            e.printStackTrace();
            request.setAttribute("errorMessage", "Có lỗi xảy ra khi tải danh sách bài học: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
        }
    }
}
