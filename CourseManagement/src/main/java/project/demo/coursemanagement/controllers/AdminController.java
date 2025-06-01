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
import java.util.HashMap;
import java.util.Map;

import java.io.IOException;


@WebServlet(name = "AdminController", urlPatterns = {"/admin"})
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy thống kê user
        RegisterDAO registerDAO = new RegisterDAOImpl();
        RegistrationStats stats = this.registerDAO.getRegistrationStatistics();

        // Lấy danh sách đăng ký gần đây (10 người gần nhất)
        java.util.List<project.demo.coursemanagement.entities.User> recentRegistrations = this.registerDAO.getRecentRegistrations(10);

        // Lấy danh sách user đăng nhập gần đây (10 người gần nhất)
        UserDAO userDAO = new UserDAOImpl();
        java.util.List<project.demo.coursemanagement.entities.User> recentLogins = this.userDAO.getRecentLogins(10);

        // Chuyển đổi Instant sang Date cho JSP formatting
        if (recentRegistrations != null) {
            for (project.demo.coursemanagement.entities.User user : recentRegistrations) {
                if (user.getCreatedAt() != null) {
                    user.setCreatedAtDate(java.util.Date.from(user.getCreatedAt()));
                }
                // lastLogin cũng cần được chuyển đổi cho cả recentRegistrations nếu muốn hiển thị
                 if (user.getLastLogin() != null) {
                    user.setLastLoginDate(java.util.Date.from(user.getLastLogin()));
                 }
            }
        }

        if (recentLogins != null) {
             for (project.demo.coursemanagement.entities.User user : recentLogins) {
                 if (user.getCreatedAt() != null) {
                     user.setCreatedAtDate(java.util.Date.from(user.getCreatedAt()));
                 }
                 if (user.getLastLogin() != null) {
                     user.setLastLoginDate(java.util.Date.from(user.getLastLogin()));
                 }
             }
         }

        // Lấy tổng số khóa học
        int totalCourses = this.courseDAO.countCourses(null, null);

        // Tạo map để truyền sang JSP (có thể mở rộng cho các thống kê khác)
        Map<String, Object> dashboardStats = new HashMap<>();
        dashboardStats.put("totalUsers", stats.getTotalUsers());
        dashboardStats.put("totalCourses", totalCourses);
        // Có thể bổ sung các trường khác nếu cần

        request.setAttribute("dashboardStats", dashboardStats);
        // Đặt danh sách user đăng ký gần đây vào request attribute
        request.setAttribute("recentUsers", recentRegistrations);

        // Đặt danh sách user đăng nhập gần đây vào request attribute cho Recent Activities
        request.setAttribute("recentActivities", recentLogins);

        // Forward tới admin.jsp (nằm trong WEB-INF/views)
        request.getRequestDispatcher("/WEB-INF/views/admin.jsp")
                .forward(request, response);
    }
}
