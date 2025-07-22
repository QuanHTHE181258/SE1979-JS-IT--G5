package project.demo.coursemanagement.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import project.demo.coursemanagement.dto.OrderAnalyticsDTO;
import project.demo.coursemanagement.service.OrderService;

import java.io.IOException;

@WebServlet("/admin/revenue-analytics")
public class RevenueAnalyticsController extends HttpServlet {
    private final OrderService orderService = new OrderService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy dữ liệu analytics từ service
        OrderAnalyticsDTO analytics = orderService.getOrderAnalytics();
        java.util.List<project.demo.coursemanagement.dto.RevenueDetailDTO> revenueDetails = orderService.getRevenueDetails();
        request.setAttribute("analytics", analytics);
        request.setAttribute("revenueDetails", revenueDetails);
        // Forward tới trang phân tích doanh thu
        request.getRequestDispatcher("/WEB-INF/views/admin_revenue_analytics.jsp").forward(request, response);
    }
} 