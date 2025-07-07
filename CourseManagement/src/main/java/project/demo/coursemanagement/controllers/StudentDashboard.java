package project.demo.coursemanagement.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
//import project.demo.coursemanagement.dto.EnrolledCourse;
import project.demo.coursemanagement.entities.User;
//import project.demo.coursemanagement.service.EnrollmentService;
import project.demo.coursemanagement.utils.SessionUtil;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "StudentDashboard", urlPatterns = "/student-dashboard")
public class StudentDashboard extends HttpServlet {

//    private EnrollmentService enrollmentService;

    @Override
    public void init() {
//        enrollmentService = EnrollmentService.getInstance();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User currentUser = SessionUtil.getUserFromSession(req);

        if (currentUser != null) {
//            List<EnrolledCourse> enrolledCourses = enrollmentService.getEnrollmentsByUser(currentUser.getId());
//            req.setAttribute("enrolledCourses", enrolledCourses);
            req.getRequestDispatcher("/WEB-INF/views/student-dashboard.jsp").forward(req, resp);
        } else {
            SessionUtil.setFlashMessage(req, "info", "You must be logged in to view your enrollments.");
            resp.sendRedirect(req.getContextPath() + "/login");
        }
    }
}
    