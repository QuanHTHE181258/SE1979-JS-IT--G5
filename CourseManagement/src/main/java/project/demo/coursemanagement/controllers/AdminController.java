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
import java.util.HashMap;
import java.util.Map;

import java.io.IOException;


@WebServlet(name = "AdminController", urlPatterns = {"/admin"})
public class AdminController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy thống kê user
        RegisterDAO registerDAO = new RegisterDAOImpl();
        RegistrationStats stats = registerDAO.getRegistrationStatistics();

        // Tạo map để truyền sang JSP (có thể mở rộng cho các thống kê khác)
        Map<String, Object> dashboardStats = new HashMap<>();
        dashboardStats.put("totalUsers", stats.getTotalUsers());
        // Có thể bổ sung các trường khác nếu cần

        request.setAttribute("dashboardStats", dashboardStats);

        // Forward tới admin.jsp (nằm trong WEB-INF/views)
        request.getRequestDispatcher("/WEB-INF/views/admin.jsp")
                .forward(request, response);
    }
}
