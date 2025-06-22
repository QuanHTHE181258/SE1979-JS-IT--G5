package project.demo.coursemanagement.service;

import project.demo.coursemanagement.dto.OrderDTO;
import project.demo.coursemanagement.dto.OrderAnalyticsDTO;

import java.util.List;

public interface OrderService {
    // Existing methods
    List<OrderDTO> getAllOrders();
    List<OrderDTO> getOrdersByStatus(String status);
    OrderDTO getOrderById(Integer orderId);
    boolean updateOrderStatus(Integer orderId, String status);
    int countOrders();
    List<OrderDTO> getOrdersWithPagination(int offset, int limit);
    List<OrderDTO> searchOrders(String keyword, int offset, int limit);
    int countSearchResults(String keyword);
    
    // New methods for export functionality
    byte[] exportOrdersToExcel(List<OrderDTO> orders);
    byte[] exportOrdersToCSV(List<OrderDTO> orders);
    
    // New methods for analytics
    OrderAnalyticsDTO getOrderAnalytics();
    List<OrderDTO> getOrdersByDateRange(String startDate, String endDate);
} 