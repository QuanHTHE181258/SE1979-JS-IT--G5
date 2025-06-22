package project.demo.coursemanagement.service.impl;

import project.demo.coursemanagement.dao.OrderDAO;
import project.demo.coursemanagement.dao.OrderDAOImpl;
import project.demo.coursemanagement.dto.OrderDTO;
import project.demo.coursemanagement.dto.OrderAnalyticsDTO;
import project.demo.coursemanagement.service.OrderService;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

public class OrderServiceImpl implements OrderService {
    private final OrderDAO orderDAO = new OrderDAOImpl();

    // Existing methods delegation
    @Override
    public List<OrderDTO> getAllOrders() {
        return orderDAO.getAllOrders();
    }

    @Override
    public List<OrderDTO> getOrdersByStatus(String status) {
        return orderDAO.getOrdersByStatus(status);
    }

    @Override
    public OrderDTO getOrderById(Integer orderId) {
        return orderDAO.getOrderById(orderId);
    }

    @Override
    public boolean updateOrderStatus(Integer orderId, String status) {
        return orderDAO.updateOrderStatus(orderId, status);
    }

    @Override
    public int countOrders() {
        return orderDAO.countOrders();
    }

    @Override
    public List<OrderDTO> getOrdersWithPagination(int offset, int limit) {
        return orderDAO.getOrdersWithPagination(offset, limit);
    }

    @Override
    public List<OrderDTO> searchOrders(String keyword, int offset, int limit) {
        return orderDAO.searchOrders(keyword, offset, limit);
    }

    @Override
    public int countSearchResults(String keyword) {
        return orderDAO.countSearchResults(keyword);
    }

    // Export functionality
    @Override
    public byte[] exportOrdersToExcel(List<OrderDTO> orders) {
        // Simple CSV format for Excel compatibility
        return exportOrdersToCSV(orders);
    }

    @Override
    public byte[] exportOrdersToCSV(List<OrderDTO> orders) {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        try (PrintWriter writer = new PrintWriter(baos)) {
            // Write CSV header
            writer.println("Order ID,User,Email,Course,Price,Status,Order Date");
            
            // Write data rows
            for (OrderDTO order : orders) {
                writer.printf("%d,%s,%s,%s,%.2f,%s,%s%n",
                    order.getOrderId(),
                    order.getUsername(),
                    order.getCustomerEmail(),
                    order.getOrderDetails() != null && !order.getOrderDetails().isEmpty() ? 
                        order.getOrderDetails().get(0).getCourseTitle() : "N/A",
                    order.getTotalAmount(),
                    order.getStatus(),
                    order.getCreatedAtDate()
                );
            }
        }
        return baos.toByteArray();
    }

    // Analytics functionality
    @Override
    public OrderAnalyticsDTO getOrderAnalytics() {
        return orderDAO.getOrderAnalytics();
    }

    @Override
    public List<OrderDTO> getOrdersByDateRange(String startDate, String endDate) {
        return orderDAO.getOrdersByDateRange(startDate, endDate);
    }
} 