package project.demo.coursemanagement.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import project.demo.coursemanagement.entities.Cours; // Đổi từ Course → Cours (theo Entity bạn dùng)
import project.demo.coursemanagement.entities.User;
import project.demo.coursemanagement.service.CourseService;
import project.demo.coursemanagement.service.EnrollmentService;
import project.demo.coursemanagement.utils.SessionUtil;

import java.io.IOException;

@WebServlet(name = "EnrollmentController", urlPatterns = {"/enrollment"})
public class EnrollmentController extends HttpServlet {

    private CourseService courseService;
    private EnrollmentService enrollmentService;

    @Override
    public void init() {
        courseService = CourseService.getInstance();
        enrollmentService = EnrollmentService.getInstance();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Optional: handle view enrolled courses (not required in your current scope)
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User currentUser = SessionUtil.getUserFromSession(req);

        if (currentUser == null) {
            resp.sendError(HttpServletResponse.SC_UNAUTHORIZED, "You must be logged in to enroll.");
            return;
        }

        String courseIdParam = req.getParameter("courseId");
        if (courseIdParam == null || courseIdParam.trim().isEmpty()) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Course ID is required.");
            return;
        }

        try {
            int courseId = Integer.parseInt(courseIdParam.trim());
            Cours course = courseService.getCourseById(courseId); // Sửa tên phương thức nếu cần

            if (course == null) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Course not found.");
                return;
            }

            boolean success = enrollmentService.enrollUserInCourse(currentUser.getId(), courseId);
            if (success) {
                SessionUtil.setFlashMessage(req, "success", "Successfully enrolled in the course.");
                resp.sendRedirect(req.getContextPath() + "/student-dashboard");
            } else {
                SessionUtil.setFlashMessage(req, "error", "You are already enrolled in this course.");
                resp.sendRedirect(req.getContextPath() + "/course");
            }

        } catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid course ID format.");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An unexpected error occurred.");
        }
    }
}
