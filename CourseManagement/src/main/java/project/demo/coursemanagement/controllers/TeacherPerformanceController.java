package project.demo.coursemanagement.controllers;

import project.demo.coursemanagement.dto.StudentPerformanceDTO;
import project.demo.coursemanagement.service.TeacherPerformanceService;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.List;

@WebServlet("/teacher-performance")
public class TeacherPerformanceController extends HttpServlet {
    private TeacherPerformanceService service = new TeacherPerformanceService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Lấy teacherId từ session hoặc request
        Integer teacherId = (Integer) req.getSession().getAttribute("userId");
        String userRole = (String) req.getSession().getAttribute("userRole");
        if (teacherId == null || userRole == null || !(userRole.equals("2") || userRole.equalsIgnoreCase("TEACHER"))) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied. Only teachers can access this page.");
            return;
        }

        String courseIdStr = req.getParameter("courseId");
        List<Integer> courses = service.getCoursesByTeacher(teacherId);
        req.setAttribute("courses", courses);

        if (courseIdStr != null && !courseIdStr.isEmpty()) {
            int courseId = Integer.parseInt(courseIdStr);
            List<StudentPerformanceDTO> students = service.getStudentPerformanceByCourse(courseId);
            req.setAttribute("students", students);
            req.setAttribute("selectedCourseId", courseId);
        }

        RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/teacher_performance.jsp");
        dispatcher.forward(req, resp);
    }
} 