package project.demo.coursemanagement.service;

import project.demo.coursemanagement.dao.OrderDAO;
import project.demo.coursemanagement.dao.impl.OrderDAOImpl;
import project.demo.coursemanagement.dto.OrderDTO;
import project.demo.coursemanagement.dto.OrderAnalyticsDTO;
import project.demo.coursemanagement.dto.RevenueDetailDTO;

import java.util.List;

public class OrderService {
    private final OrderDAO orderDAO = new OrderDAOImpl();

    public List<OrderDTO> getAllOrders() {
        return orderDAO.getAllOrders();
    }

    public List<OrderDTO> getOrdersByStatus(String status) {
        return orderDAO.getOrdersByStatus(status);
    }

    public OrderDTO getOrderById(Integer orderId) {
        return orderDAO.getOrderById(orderId);
    }

    public boolean updateOrderStatus(Integer orderId, String status) {
        return orderDAO.updateOrderStatus(orderId, status);
    }

    public int countOrders() {
        return orderDAO.countOrders();
    }

    public List<OrderDTO> getOrdersWithPagination(int offset, int limit) {
        return orderDAO.getOrdersWithPagination(offset, limit);
    }

    public List<OrderDTO> searchOrders(String keyword, int offset, int limit) {
        return orderDAO.searchOrders(keyword, offset, limit);
    }

    public int countSearchResults(String keyword) {
        return orderDAO.countSearchResults(keyword);
    }

    // Export functionality (simple CSV for both Excel and CSV)
    public byte[] exportOrdersToExcel(List<OrderDTO> orders) {
        return exportOrdersToCSV(orders);
    }

    public byte[] exportOrdersToCSV(List<OrderDTO> orders) {
        StringBuilder sb = new StringBuilder();
        sb.append("Order ID,User,Email,Course,Price,Status,Order Date\n");
        for (OrderDTO order : orders) {
            sb.append(order.getOrderId()).append(",")
                    .append(order.getUsername()).append(",")
                    .append(order.getCustomerEmail()).append(",")
                    .append(order.getOrderDetails() != null && !order.getOrderDetails().isEmpty() ? order.getOrderDetails().get(0).getCourseTitle() : "N/A").append(",")
                    .append(order.getTotalAmount()).append(",")
                    .append(order.getStatus()).append(",")
                    .append(order.getCreatedAtDate()).append("\n");
        }
        return sb.toString().getBytes();
    }

    public OrderAnalyticsDTO getOrderAnalytics() {
        return orderDAO.getOrderAnalytics();
    }

    public List<OrderDTO> getOrdersByDateRange(String startDate, String endDate) {
        return orderDAO.getOrdersByDateRange(startDate, endDate);
    }

    public List<OrderDTO> getOrdersByUserId(Integer userId) {
        return orderDAO.getOrdersByUserId(userId);
    }

    public List<RevenueDetailDTO> getRevenueDetails() {
        return orderDAO.getRevenueDetails();
    }
    public List<project.demo.coursemanagement.dto.RevenueDetailDTO> getRevenueByDay() {
        return orderDAO.getRevenueByDay();
    }
    public List<project.demo.coursemanagement.dto.RevenueDetailDTO> getRevenueByWeek() {
        return orderDAO.getRevenueByWeek();
    }
    public List<project.demo.coursemanagement.dto.RevenueDetailDTO> getRevenueByMonth() {
        return orderDAO.getRevenueByMonth();
    }
    public List<project.demo.coursemanagement.dto.RevenueDetailDTO> getRevenueByYear() {
        return orderDAO.getRevenueByYear();
    }
}

