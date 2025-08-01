package project.demo.coursemanagement.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import project.demo.coursemanagement.entities.Role;
import project.demo.coursemanagement.entities.User;
import project.demo.coursemanagement.dto.CourseDTO;
import project.demo.coursemanagement.service.UserService;
import project.demo.coursemanagement.service.CourseService;
import project.demo.coursemanagement.service.RegisterService;
import project.demo.coursemanagement.service.OrderService;
import project.demo.coursemanagement.dto.OrderAnalyticsDTO;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/admin/*")
public class AdminController extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(AdminController.class.getName());
    private final UserService userService = new UserService();
    private final RegisterService registerService = new RegisterService();
    private final CourseService courseService = new CourseService();
    private final OrderService orderService = new OrderService(); // Add OrderService

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
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
            if (recentCourses == null) {
                recentCourses = Collections.emptyList();
            }


            // Get recent activities with search, limit, and role
            List<User> recentActivities;
            if (activitySearch != null && !activitySearch.trim().isEmpty()) {
                recentActivities = userService.searchRecentActivities(activitySearch, activityLimit, activityRole);
            } else {
                recentActivities = userService.getRecentUsersByRole(activityLimit, activityRole);
            }
            if (recentActivities == null) {
                recentActivities = Collections.emptyList();
            }

            // Lấy thống kê user và khóa học
            int totalUsers = userService.countUsers(null, null);
            int totalCourses = courseService.countCourses(null, null);

            // Lấy thống kê đơn hàng và doanh thu
            OrderAnalyticsDTO orderStats = orderService.getOrderAnalytics();

            Map<String, Object> dashboardStats = new HashMap<>();
            dashboardStats.put("totalUsers", totalUsers);
            dashboardStats.put("totalCourses", totalCourses);
            dashboardStats.put("totalRevenue", orderStats.getTotalRevenue());

            request.setAttribute("dashboardStats", dashboardStats);
//            dashboardStats.put("totalUsers", totalUsers);
            request.setAttribute("recentActivities", recentActivities);
            request.setAttribute("recentCourses", recentCourses);
            List<CourseDTO> topCourses = courseService.getTopCourses(5);
            if (topCourses == null) {
                topCourses = Collections.emptyList();
            }
            request.setAttribute("topCourses", topCourses);

            Map<Integer, Role> userRoles = new HashMap<>();
            if (recentActivities != null) {
                for (User user : recentActivities) {
                    if (user != null) {
                        Role role = userService.getPrimaryRoleByUserId(user.getId()); // Gọi đúng hàm lấy role theo userId
                        userRoles.put(user.getId(), role);
                    }
                }
            }

            request.setAttribute("userRoles", userRoles);


            request.getRequestDispatcher("/WEB-INF/views/admin.jsp").forward(request, response);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Critical error in AdminController doGet", e);
            if (!response.isCommitted()) {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An unexpected error occurred. Please check server logs.");
            }
        }
    }
}
