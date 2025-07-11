package project.demo.coursemanagement.dto;

import java.math.BigDecimal;
import java.util.Date;

public class RevenueDetailDTO {
    private int orderId;
    private Date orderDate;
    private String status;
    private BigDecimal totalAmount;
    private String courseTitle;
    private BigDecimal coursePrice;
    private String customerName;
    private String customerEmail;

    // Getters and Setters
    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }
    public Date getOrderDate() { return orderDate; }
    public void setOrderDate(Date orderDate) { this.orderDate = orderDate; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public BigDecimal getTotalAmount() { return totalAmount; }
    public void setTotalAmount(BigDecimal totalAmount) { this.totalAmount = totalAmount; }
    public String getCourseTitle() { return courseTitle; }
    public void setCourseTitle(String courseTitle) { this.courseTitle = courseTitle; }
    public BigDecimal getCoursePrice() { return coursePrice; }
    public void setCoursePrice(BigDecimal coursePrice) { this.coursePrice = coursePrice; }
    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }
    public String getCustomerEmail() { return customerEmail; }
    public void setCustomerEmail(String customerEmail) { this.customerEmail = customerEmail; }
} 