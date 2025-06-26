package project.demo.coursemanagement.controllers;

import project.demo.coursemanagement.dto.StudentPerformanceDTO;
import project.demo.coursemanagement.service.TeacherPerformanceService;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class TeacherPerformanceController extends HttpServlet {
    private TeacherPerformanceService service = new TeacherPerformanceService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Lấy teacherId từ session hoặc request
        Integer teacherId = (Integer) req.getSession().getAttribute("userId");
        if (teacherId == null) {
            resp.sendRedirect("login.jsp");
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