package project.demo.coursemanagement.controllers;

import project.demo.coursemanagement.entities.Enrollment;
import project.demo.coursemanagement.dao.impl.EnrollmentDAOImpl;
import project.demo.coursemanagement.entities.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/enrollments")
public class StudentEnrollmentServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("loggedInUser");
        if (user == null) {
            resp.sendRedirect("login");
            return;
        }
        Integer studentId = user.getId();
        EnrollmentDAOImpl enrollmentDAO = new EnrollmentDAOImpl();
        List<Enrollment> enrollments = enrollmentDAO.getEnrollmentsByStudentId(studentId);
        req.setAttribute("enrollments", enrollments);
        req.getRequestDispatcher("/WEB-INF/views/student_enrollments.jsp").forward(req, resp);

        System.out.println("[DEBUG] StudentEnrollmentServlet: studentId=" + studentId);
        System.out.println("[DEBUG] Enrollment count: " + (enrollments != null ? enrollments.size() : "null"));
        if (enrollments != null) {
            for (Enrollment e : enrollments) {
                System.out.println("[DEBUG] Enrollment: id=" + e.getId() + ", course=" + (e.getCourse() != null ? e.getCourse().getTitle() : "null"));
            }
        }
    }
}
