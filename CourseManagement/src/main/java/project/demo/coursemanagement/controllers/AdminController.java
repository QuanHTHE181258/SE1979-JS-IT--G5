package project.demo.coursemanagement.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import project.demo.coursemanagement.entities.User;
import project.demo.coursemanagement.dao.RegisterDAO;
import project.demo.coursemanagement.dao.RegisterDAOImpl;
import project.demo.coursemanagement.dao.RegisterDAO.RegistrationStats;
import project.demo.coursemanagement.dao.UserDAO;
import project.demo.coursemanagement.dao.UserDAOImpl;
import project.demo.coursemanagement.dao.CourseDAO;
import project.demo.coursemanagement.dto.CourseDTO;
import project.demo.coursemanagement.utils.DatabaseConnection;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            showDashboard(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void showDashboard(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get search parameters
        String courseSearch = request.getParameter("courseSearch");
        String activitySearch = request.getParameter("activitySearch");

        // Get recent courses with search
        List<CourseDTO> recentCourses;
        if (courseSearch != null && !courseSearch.trim().isEmpty()) {
            recentCourses = courseDAO.searchRecentCourses(courseSearch, 5);
        } else {
            recentCourses = courseDAO.getRecentCourses(5);
        }

        // Get recent activities with search
        List<User> recentActivities;
        if (activitySearch != null && !activitySearch.trim().isEmpty()) {
            recentActivities = userDAO.searchRecentActivities(activitySearch, 5);
        } else {
            recentActivities = userDAO.getRecentLogins(5);
        }

        // Lấy thống kê user
        RegisterDAO registerDAO = new RegisterDAOImpl();
        RegistrationStats stats = this.registerDAO.getRegistrationStatistics();

        // Lấy tổng số khóa học
        int totalCourses = this.courseDAO.countCourses(null, null);

        // Tạo map để truyền sang JSP (có thể mở rộng cho các thống kê khác)
        Map<String, Object> dashboardStats = new HashMap<>();
        dashboardStats.put("totalUsers", stats.getTotalUsers());
        dashboardStats.put("totalCourses", totalCourses);
        // Có thể bổ sung các trường khác nếu cần

        request.setAttribute("dashboardStats", dashboardStats);
        // Đặt danh sách user đăng ký gần đây vào request attribute
        request.setAttribute("recentUsers", this.registerDAO.getRecentRegistrations(10));

        // Đặt danh sách user đăng nhập gần đây vào request attribute cho Recent Activities
        request.setAttribute("recentActivities", recentActivities);

        // Đặt danh sách khóa học gần đây vào request attribute
        request.setAttribute("recentCourses", recentCourses);

        // Forward tới admin.jsp (nằm trong WEB-INF/views)
        request.getRequestDispatcher("/WEB-INF/views/admin.jsp")
                .forward(request, response);
    }
}
