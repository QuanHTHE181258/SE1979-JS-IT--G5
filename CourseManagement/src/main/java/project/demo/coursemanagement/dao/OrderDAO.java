package project.demo.coursemanagement.dao;

import project.demo.coursemanagement.dto.OrderDTO;
import project.demo.coursemanagement.dto.OrderAnalyticsDTO;
import project.demo.coursemanagement.dto.RevenueDetailDTO;
import project.demo.coursemanagement.dto.OrderDetailsViewDTO;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

public interface OrderDAO {
    List<OrderDTO> getAllOrders();
    List<OrderDTO> getOrdersByStatus(String status);
    OrderDTO getOrderById(Integer orderId);
    boolean updateOrderStatus(Integer orderId, String status);
    int countOrders();
    List<OrderDTO> getOrdersWithPagination(int offset, int limit);
    List<OrderDTO> searchOrders(String keyword, int offset, int limit);
    int countSearchResults(String keyword);
    
    // New methods for analytics
    OrderAnalyticsDTO getOrderAnalytics();
    List<OrderDTO> getOrdersByDateRange(String startDate, String endDate);
    BigDecimal getTotalRevenue();
    Map<String, Integer> getOrdersCountByStatus();

    // Method to get orders by user ID
    List<OrderDTO> getOrdersByUserId(Integer userId);
    OrderDetailsViewDTO getOrderDetailView(int orderId);
    List<project.demo.coursemanagement.dto.RevenueDetailDTO> getRevenueDetails();
    List<project.demo.coursemanagement.dto.RevenueDetailDTO> getRevenueByDay();
    List<project.demo.coursemanagement.dto.RevenueDetailDTO> getRevenueByWeek();
    List<project.demo.coursemanagement.dto.RevenueDetailDTO> getRevenueByMonth();
    List<project.demo.coursemanagement.dto.RevenueDetailDTO> getRevenueByYear();
}
