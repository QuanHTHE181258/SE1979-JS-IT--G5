package project.demo.coursemanagement.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import project.demo.coursemanagement.entities.User;
import project.demo.coursemanagement.dao.RegisterDAO;
import project.demo.coursemanagement.dao.impl.RegisterDAOImpl;
import project.demo.coursemanagement.dao.RegisterDAO.RegistrationStats;
import project.demo.coursemanagement.dao.UserDAO;
import project.demo.coursemanagement.dao.impl.UserDAOImpl;
import project.demo.coursemanagement.dao.CourseDAO;
import project.demo.coursemanagement.dto.CourseDTO;
import project.demo.coursemanagement.utils.DatabaseConnection;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Date;
import java.io.IOException;

@WebServlet("/admin/*")
public class AdminController extends HttpServlet {

    private final UserDAO userDAO;
    private final RegisterDAO registerDAO;
    private CourseDAO courseDAO;

    public AdminController() {
        this.userDAO = new UserDAOImpl();
        this.registerDAO = new RegisterDAOImpl();
        this.courseDAO = new CourseDAO();
    }

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
                // Ensure limit is either 5 or 10
                if (activityLimit != 5 && activityLimit != 10) {
                    activityLimit = 5;
                }
            }

            String courseLimitStr = request.getParameter("courseLimit");
            if (courseLimitStr != null && !courseLimitStr.trim().isEmpty()) {
                courseLimit = Integer.parseInt(courseLimitStr);
                // Ensure limit is either 5 or 10
                if (courseLimit != 5 && courseLimit != 10) {
                    courseLimit = 5;
                }
            }
        } catch (NumberFormatException e) {
            // If parsing fails, use default values
        }

        // Lấy role cho recent activities (chỉ student/teacher)
        String activityRole = request.getParameter("activityRole");
        if (activityRole == null || (!activityRole.equalsIgnoreCase("student") && !activityRole.equalsIgnoreCase("teacher"))) {
            activityRole = "student"; // mặc định là student
        }

        // Get recent courses with search and limit
        List<CourseDTO> recentCourses;
        if (courseSearch != null && !courseSearch.trim().isEmpty()) {
            recentCourses = courseDAO.searchRecentCourses(courseSearch, courseLimit);
        } else {
            recentCourses = courseDAO.getRecentCourses(courseLimit);
        }

        // Get recent activities with search, limit, and role
        List<User> recentActivities;
        if (activitySearch != null && !activitySearch.trim().isEmpty()) {
            recentActivities = userDAO.searchRecentActivities(activitySearch, activityLimit, activityRole);
        } else {
            recentActivities = userDAO.getRecentLogins(activityLimit); // This now gets recent users by creation date
        }

        // Convert Instant to Date for JSP formatting
        recentActivities.forEach(user -> {
            if (user.getLastLogin() != null) {
                user.setLastLoginDate(Date.from(user.getLastLogin()));
            }
            if (user.getCreatedAt() != null) {
                user.setCreatedAtDate(Date.from(user.getCreatedAt()));
            }
        });

        // Lấy thống kê user
        RegisterDAO registerDAO = new RegisterDAOImpl();
        RegistrationStats stats = this.registerDAO.getRegistrationStatistics();

        // Lấy tổng số khóa học
        int totalCourses = this.courseDAO.countCourses(null, null);

        // Tạo map để truyền sang JSP (có thể mở rộng cho các thống kê khác)
        Map<String, Object> dashboardStats = new HashMap<>();
        dashboardStats.put("totalUsers", stats.getTotalUsers());
        dashboardStats.put("totalCourses", totalCourses);
        dashboardStats.put("activeEnrollments", 0); // TODO: Implement enrollment counting
        dashboardStats.put("totalRevenue", 0.0); // TODO: Implement revenue calculation
        // Có thể bổ sung các trường khác nếu cần

        request.setAttribute("dashboardStats", dashboardStats);
        // Đặt danh sách user đăng ký gần đây vào request attribute
        request.setAttribute("recentUsers", this.registerDAO.getRecentRegistrations(10));

        // Đặt danh sách user đăng nhập gần đây vào request attribute cho Recent Activities
        request.setAttribute("recentActivities", recentActivities);

        // Đặt danh sách khóa học gần đây vào request attribute
        request.setAttribute("recentCourses", recentCourses);

        // Đặt danh sách top courses vào request attribute
        request.setAttribute("topCourses", this.courseDAO.getTopCourses(5));

        // Forward tới admin.jsp (nằm trong WEB-INF/views)
        request.getRequestDispatcher("/WEB-INF/views/admin.jsp")
                .forward(request, response);
    }
}
