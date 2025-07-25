package project.demo.coursemanagement.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import project.demo.coursemanagement.dto.OrderAnalyticsDTO;
import project.demo.coursemanagement.service.OrderService;
import project.demo.coursemanagement.dto.RevenueDetailDTO;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/revenue-analytics")
public class RevenueAnalyticsController extends HttpServlet {
    private final OrderService orderService = new OrderService();


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<RevenueDetailDTO> revenueByDay = orderService.getRevenueByDay();
        List<RevenueDetailDTO> revenueByWeek = orderService.getRevenueByWeek();
        List<RevenueDetailDTO> revenueByYear = orderService.getRevenueByYear();
        List<RevenueDetailDTO> revenueByMonth = orderService.getRevenueByMonth();

        request.setAttribute("revenueByDay", revenueByDay);
        request.setAttribute("revenueByWeek", revenueByWeek);
        request.setAttribute("revenueByYear", revenueByYear);
        request.setAttribute("revenueByMonth", revenueByMonth);
        // Lấy dữ liệu analytics từ service
        OrderAnalyticsDTO analytics = orderService.getOrderAnalytics();
        java.util.List<RevenueDetailDTO> revenueDetails = orderService.getRevenueDetails();
        request.setAttribute("analytics", analytics);
        request.setAttribute("revenueDetails", revenueDetails);
        // Forward tới trang phân tích doanh thu
        request.getRequestDispatcher("/WEB-INF/views/admin_revenue_analytics.jsp").forward(request, response);
    }

} 