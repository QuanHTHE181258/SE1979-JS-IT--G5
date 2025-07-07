package project.demo.coursemanagement.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import project.demo.coursemanagement.entities.User;
import project.demo.coursemanagement.dto.CourseDTO;
import project.demo.coursemanagement.service.UserService;
import project.demo.coursemanagement.service.CourseService;
import project.demo.coursemanagement.service.RegisterService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.io.IOException;

@WebServlet("/admin/*")
public class AdminController extends HttpServlet {
    private final UserService userService = new UserService();
    private final RegisterService registerService = new RegisterService();
    private final CourseService courseService = new CourseService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get search parameters
        String courseSearch = request.getParameter("courseSearch");
        String activitySearch = request.getParameter("activitySearch");

        // Get limit parameters with default values
        int activityLimit = 5;
        int courseLimit = 5;

        try {
            String activityLimitStr = request.getParameter("activityLimit");
            if (activityLimitStr != null && !activityLimitStr.trim().isEmpty()) {
                activityLimit = Integer.parseInt(activityLimitStr);
                if (activityLimit != 5 && activityLimit != 10) {
                    activityLimit = 5;
                }
            }

            String courseLimitStr = request.getParameter("courseLimit");
            if (courseLimitStr != null && !courseLimitStr.trim().isEmpty()) {
                courseLimit = Integer.parseInt(courseLimitStr);
                if (courseLimit != 5 && courseLimit != 10) {
                    courseLimit = 5;
                }
            }
        } catch (NumberFormatException e) {
            // If parsing fails, use default values
        }

        String activityRole = request.getParameter("activityRole");
        if (activityRole == null || (!activityRole.equalsIgnoreCase("student") && !activityRole.equalsIgnoreCase("teacher"))) {
            activityRole = "student";
        }

        // Get recent courses with search and limit
        List<CourseDTO> recentCourses;
        if (courseSearch != null && !courseSearch.trim().isEmpty()) {
            recentCourses = courseService.searchRecentCourses(courseSearch, courseLimit);
        } else {
            recentCourses = courseService.getRecentCourses(courseLimit);
        }

        // Get recent activities with search, limit, and role
        List<User> recentActivities;
        if (activitySearch != null && !activitySearch.trim().isEmpty()) {
            recentActivities = userService.searchRecentActivities(activitySearch, activityLimit, activityRole);
        } else {
            recentActivities = userService.getRecentUsersByRole(activityLimit, activityRole);
        }

        // Lấy thống kê user
        RegisterService.RegistrationStatistics stats = registerService.getRegistrationStatistics();

        // Lấy tổng số khóa học
        int totalCourses = courseService.countCourses(null, null);

        Map<String, Object> dashboardStats = new HashMap<>();
        dashboardStats.put("totalUsers", stats.getTotalRegistrations());
        dashboardStats.put("totalCourses", totalCourses);
        dashboardStats.put("activeEnrollments", 0); // TODO: Implement enrollment counting
        dashboardStats.put("totalRevenue", 0.0); // TODO: Implement revenue calculation

        request.setAttribute("dashboardStats", dashboardStats);
        request.setAttribute("recentUsers", stats.getTodayRegistrations()); // Hoặc lấy từ service khác nếu cần
        request.setAttribute("recentActivities", recentActivities);
        request.setAttribute("recentCourses", recentCourses);
        request.setAttribute("topCourses", courseService.getTopCourses(5));

        request.getRequestDispatcher("/WEB-INF/views/admin.jsp")
                .forward(request, response);
    }
}
