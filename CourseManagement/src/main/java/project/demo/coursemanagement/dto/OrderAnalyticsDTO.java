package project.demo.coursemanagement.dto;

import java.math.BigDecimal;
import java.util.Map;

public class OrderAnalyticsDTO {
    private int totalOrders;
    private BigDecimal totalRevenue;
    private Map<String, Integer> ordersByStatus;
    private Map<String, BigDecimal> revenueByMonth;
    private int pendingOrders;
    private int completedOrders;
    private int cancelledOrders;
    private BigDecimal averageOrderValue;

    public OrderAnalyticsDTO() {
    }

    public OrderAnalyticsDTO(int totalOrders, BigDecimal totalRevenue, Map<String, Integer> ordersByStatus,
                           Map<String, BigDecimal> revenueByMonth, int pendingOrders, int completedOrders,
                           int cancelledOrders, BigDecimal averageOrderValue) {
        this.totalOrders = totalOrders;
        this.totalRevenue = totalRevenue;
        this.ordersByStatus = ordersByStatus;
        this.revenueByMonth = revenueByMonth;
        this.pendingOrders = pendingOrders;
        this.completedOrders = completedOrders;
        this.cancelledOrders = cancelledOrders;
        this.averageOrderValue = averageOrderValue;
    }

    // Getters and Setters
    public int getTotalOrders() {
        return totalOrders;
    }

    public void setTotalOrders(int totalOrders) {
        this.totalOrders = totalOrders;
    }

    public BigDecimal getTotalRevenue() {
        return totalRevenue;
    }

    public void setTotalRevenue(BigDecimal totalRevenue) {
        this.totalRevenue = totalRevenue;
    }

    public Map<String, Integer> getOrdersByStatus() {
        return ordersByStatus;
    }

    public void setOrdersByStatus(Map<String, Integer> ordersByStatus) {
        this.ordersByStatus = ordersByStatus;
    }

    public Map<String, BigDecimal> getRevenueByMonth() {
        return revenueByMonth;
    }

    public void setRevenueByMonth(Map<String, BigDecimal> revenueByMonth) {
        this.revenueByMonth = revenueByMonth;
    }

    public int getPendingOrders() {
        return pendingOrders;
    }

    public void setPendingOrders(int pendingOrders) {
        this.pendingOrders = pendingOrders;
    }

    public int getCompletedOrders() {
        return completedOrders;
    }

    public void setCompletedOrders(int completedOrders) {
        this.completedOrders = completedOrders;
    }

    public int getCancelledOrders() {
        return cancelledOrders;
    }

    public void setCancelledOrders(int cancelledOrders) {
        this.cancelledOrders = cancelledOrders;
    }

    public BigDecimal getAverageOrderValue() {
        return averageOrderValue;
    }

    public void setAverageOrderValue(BigDecimal averageOrderValue) {
        this.averageOrderValue = averageOrderValue;
    }
} 