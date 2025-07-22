package project.demo.coursemanagement.dao;

import project.demo.coursemanagement.dto.OrderDTO;
import project.demo.coursemanagement.dto.OrderAnalyticsDTO;
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
    Map<String, BigDecimal> getRevenueByMonth();
    
    // Method to get orders by user ID
    List<OrderDTO> getOrdersByUserId(Integer userId);
    List<project.demo.coursemanagement.dto.RevenueDetailDTO> getRevenueDetails();
}
